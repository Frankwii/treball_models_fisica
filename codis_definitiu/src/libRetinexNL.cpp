#include "libRetinexNL.h"
#include <sstream>
// DEBUG: printf(s[0]);
//     o: std::cout << e importar iostream

std::vector<std::string> split(std::string s, std::string delimiter) {
    size_t pos_start = 0, pos_end, delim_len = delimiter.length();
    std::string token;
    std::vector<std::string> res;

    while ((pos_end = s.find(delimiter, pos_start)) != std::string::npos) {
        token = s.substr (pos_start, pos_end - pos_start);
        pos_start = pos_end + delim_len;
        res.push_back (token);
    }

    res.push_back (s.substr (pos_start));
    return res;
}

// Compute sqrt(weights) for NL regularization on a prescribed color image using all neighbouring pixels
void nlweights_reg(float *image, std::vector< std::vector<float> > &wxy, std::vector< std::vector<int> > &posxy,
                   std::vector<int> &numxy, std::vector< std::vector<float> > &wyx, std::vector< std::vector<int> > &posyx,
                   std::vector<int> &numyx, std::vector< std::vector<int> > &posw, float hSim, float hClose, int numNeighbours,
                   int reswind, int compwind, int flagNormalize, int width, int height)
{
    /**
     * image:          Initial (unprocessed) image.
     * width:          Width of the image.
     * length:         Length of the image.
     * dim:            width*length. "image" has length dim.
     * flagNormalize:  Boolean storing wether the weights are to be normalised or not.
     * reswind:        Size of window for searching neighbours.
     * compwind:       Patch size.
     * numNeighbours:  Maximum number of neighbours a pixel can have.
     * hSim:           Patch similarity parameter. The bigger, the more we reward patch similarity.
     * hClose:         Distance penalisation parameter. The bigger, the less we penalise the distance between pixels.
     * numxy:          Vector storing the number of neighbours of each pixel; that is, image[i] has numxy[i] neighbours.
                       Has length dim.
     * wxy:            Vector storing the weights between each pixel and its neighbours (w(x,y) for a given x).
                       Has dimensions dim X numxy.
     * posxy:          Vector storing the positions (in "image") of the neighbours of each pixel.
                       Has dimensions dim X numxy.
     * numyx:          Vector storing the amount of pixels that have each pixel as a neighbour;
                       that is, there are numyx[i] pixels that have image[i] as a neighbour.
     * wyx:            Vector storing the weights between the neighbours of each pixel and itself(w(y,x) for a given x).
                       Has dimensions dim X numyx.
     * posyx:          Vector storing the positions (in "image") of the pixels that have a given pixel as a neighbour.
                       Has dimensions dim X numyx.
     * posw:
     **/

    // Research window size
    int resdim = (2 * reswind + 1) * (2 * reswind + 1);

    // Tabulate the function Exp(-x) for x>0.
    int luttaille = (int) (LUTMAX * LUTPRECISION);
    float *lut = new float[luttaille];
    libUSTG::wxFillExpLut(lut, luttaille);

    // Auxiliar vectors
    float *dist = new float[resdim];
    float *windex = new float[resdim];
    int *pos = new int[resdim];

    // Filtering parameter for spatial distance
    float hClose2 = hClose * hClose;

    // For each pixel l, compute weights w(l,l0)
    //#pragma omp parallel shared(image, lut, wxy, posxy, numxy)
    {
        //#pragma omp for schedule(dynamic) nowait
        for(int y = 0; y < height; y++)
        {
            // Fix row
            int ly = y * width;

            for(int x = 0; x < width; x++)
            {
                // Index of current pixel
                int l = ly + x;

                // Reduce window size if we are close to boundary
                int compwind0 = MAX(MIN(compwind, MIN(width-1-x-reswind, MIN(height-1-y-reswind, MIN(x-reswind, y-reswind)))), 0);

                // Learning zone depending on the window size
                int imin = MAX(x - reswind, compwind0);
                int jmin = MAX(y - reswind, compwind0);
                int imax = MIN(x + reswind, width - compwind0 - 1);
                int jmax = MIN(y + reswind, height - compwind0 - 1);




                // Adapt filter parameters to size of comparison window
                float compdim = (float) (2 * compwind0 + 1) * (2 * compwind0 + 1);
                float hSim2 = hSim * hSim * compdim;

                // Clean vectors
                libUSTG::fpClear(dist, 0.0f, resdim);
                libUSTG::fpClear(windex, 0.0f, resdim);
                libUSTG::ipClear(pos, 0, resdim);

                // Auxiliar variables
                float dMin = fLarge;
                int wcentral = 0;
                int w = 0;

                // Compute distance for each pixel in the resdim-neighbourhood
                for(int j = jmin; j <= jmax; j++)
                {
                    int l0y = j * width;

                    for(int i = imin; i <= imax; i++)
                    {
                        // Compute patch-based similarity distance
                        float dSim = libUSTG::fiL2FloatDist(image, image, x, y, i, j, compwind0, compwind0, width, width);
                        dSim /= hSim2;

                        // Compute spatial distance
                        float dClose = (float) ((x - i) * (x - i) + (y - j) * (y - j));
                        dClose /= hClose2;

                        // Save bilateral distance
                        dist[w] = dSim + dClose;


                        // Save w-position of central pixel in neighbourhood and the minimum bilateral distance
                        if((i == x) && (j == y))
                        {
                            wcentral = w;

                        } else
                        {
                            if(dist[w] < dMin)
                                dMin = dist[w];
                        }

                        //Save position in neighbourhood
                        windex[w] = (float) w;

                        // Save neighbouring pixel position
                        pos[w] = l0y + i;

                        // Update index
                        w++;
                    }
                }

                // Assign minimum distance to central pixel
                dist[wcentral] = dMin;

                // Adapt number of neighbouring pixels to window size
                int numNeighbours0 = MIN(numNeighbours, w);

                // Order bilateral distances
                libUSTG::fpQuickSort(dist, windex, w);

                // Auxiliar vectors
                std::vector<float> auxw;
                std::vector<int> auxp;

                // Compute weight w(l,l0) for each l0
                float weight_sum = 0.0f;

                for(int r = 0; r < numNeighbours0; r++)
                {
                    float weight = libUSTG::wxSLUT(dist[r], lut);

                    auxw.push_back(weight);
                    weight_sum += weight;

                    int w = (int) windex[r];
                    auxp.push_back(pos[w]);

                }

                // Normalize weights w(l,l0) with respect to l0
                if(flagNormalize)
                {
                    if(weight_sum > fTiny)
                    {
                        for(int r = 0; r < numNeighbours0; r++)
                        {
                            float wval = auxw[r];
                            auxw[r] = sqrt(wval / weight_sum);
                        }

                    } else
                    {
                        auxw.clear();
                        auxp.clear();

                        auxw.push_back(1.0f);
                        auxp.push_back(l);
                        numNeighbours0 = 1;
                    }

                } else
                {
                    for(int r = 0; r < numNeighbours0; r++)
                    {
                        float wval = auxw[r];
                        auxw[r] = sqrt(wval);
                    }
                }

                wxy.push_back(auxw);
                posxy.push_back(auxp);
                numxy.push_back(numNeighbours0);
            }
        }
    }

    // For each pixel l, compute weights w(l0,l)
    {
        for(int y = 0; y < height; y++)
        {
            int ly = y * width;

            for(int x = 0; x < width; x++)
            {
                // Current central pixel
                int l = ly + x;

                // Reduce window size if we are close to boundary
                int compwind0 = MAX(MIN(compwind, MIN(width-1-x-reswind, MIN(height-1-y-reswind, MIN(x-reswind, y-reswind)))), 0);

                // Learning zone depending on the window size
                int imin = MAX(x - reswind, compwind0);
                int jmin = MAX(y - reswind, compwind0);
                int imax = MIN(x + reswind, width - compwind0 - 1);
                int jmax = MIN(y + reswind, height - compwind0 - 1);

                // Auxiliar vectors
                std::vector<float> auxw;
                std::vector<int> auxp;
                std::vector<int> auxpw;
                int auxnw = 0;

                // Look at research window around l
                for(int j = jmin; j <= jmax; j++)
                {
                    int l0j = j * width;

                    for(int i = imin; i <= imax; i++)
                    {
                        // Neighbouring pixel
                        int l0 = l0j + i;


                        // Consider pixels l0 such that w(l0,l)>0
                        for(int w = 0; w < numxy[l0]; w++)
                        {
                            if(posxy[l0][w] == l)
                            {
                                float weight = wxy[l0][w];

                                if(weight > fTiny)
                                {
                                    auxw.push_back(weight);
                                    auxp.push_back(l0);
                                    auxpw.push_back(w);
                                    auxnw++;

                                }
                                break;
                            }
                        }
                    }
                }

                // Save outputs
                wyx.push_back(auxw);
                posyx.push_back(auxp);
                numyx.push_back(auxnw);
                posw.push_back(auxpw);
            }
        }

    }

    // Delete allocated memory
    delete[] lut;
    delete[] dist;
    delete[] windex;
    delete[] pos;
}

// Compute nonlocal divergence at each pixel as minus the adjoint operator of the nonlocal gradient
void nl_divergence(std::vector< std::vector<float> > &data, float *nldiv, std::vector< std::vector<float> > &wxy,
                   std::vector<int> &numxy, std::vector< std::vector<float> > &wyx, std::vector<int> &numyx,
                   std::vector< std::vector<int> > &posyx, std::vector< std::vector<int> > &posw, int dim)
{
    /**
     * data:    Vector whose divergence is to be calculated. Has dimension dim X numxy
     * nldiv:   Vector where the divergence is to be stored. Has dimension dim

     For the rest of the variables, see nlweights_reg()
     **/

    for(int l = 0; l < dim; l++)
    {
        // Auxiliar variable
        float divl = 0.0f;

        // Terms involving w(x,y)
        for(int w = 0; w < numxy[l]; w++)
        {
            // Weight
            float weight = wxy[l][w];

            // Assign value
            divl += data[l][w] * weight;
        }

        // Terms involving w(y,x)
        for(int w = 0; w < numyx[l]; w++)
        {
            // Index of neighbouring pixel
            int l0 = posyx[l][w];

            // Index of w(y,x)
            int w0 = posw[l][w];

            // Weight
            float weight = wyx[l][w];

            // Assign value
            divl -= data[l0][w0] * weight;
        }

        // Save divergence at current pixel
        nldiv[l] = divl;
    }
}

// Compute nonlocal gradient operator at each pixel
void nl_gradient(float *data, std::vector< std::vector<float> > &nlgrad, std::vector< std::vector<float> > &wxy,
                 std::vector< std::vector<int> > &posxy, std::vector<int> &numxy, int dim)
{
    /**
     * data:    Vector whose gradient is to be calculated. Has dimension dim.
     * nlgrad:  Vector where the gradient is to be stored. Has dimension dim X numxy.

     For the rest of the variables, see nlweights_reg()
     **/
    for(int l = 0; l < dim; l++)
    {
        for(int w = 0; w < numxy[l]; w++)
        {
            // Index of neighbouring pixel with non-zero weight
            int l0 = posxy[l][w];

            // Weight
            float weight = wxy[l][w];

            // Compute gradient at (l, l0)
            nlgrad[l][w] = (data[l0] - data[l]) * weight;
        }
    }
}

// Compute local divergence at each pixel as minus the adjoint operator of the local gradient, div = -nabla^T
void divergence(const float *v1, const float *v2, float *div, const int width, const int height)
{
    for(int i = 1; i < height - 1; i++)
        for(int j = 1; j < width - 1; j++)
        {
            const int p  = i * width + j;
            const int p1 = p - 1;
            const int p2 = p - width;

            const double v1x = v1[p] - v1[p1];
            const double v2y = v2[p] - v2[p2];

            div[p] = v1x + v2y;
        }

    // Compute the divergence on the first and last rows
    for (int j = 1; j < width - 1; j++)
    {
        const int p = (height - 1) * width + j;
        div[j] = v1[j] - v1[j-1] + v2[j];
        div[p] = v1[p] - v1[p-1] - v2[p - width];
    }


    // Compute the divergence on the first and last columns
    for (int i = 1; i < height - 1; i++)
    {
        const int p1 = i * width;
        const int p2 = (i+1) * width - 1;
        div[p1] =  v1[p1]   + v2[p1] - v2[p1 - width];
        div[p2] = -v1[p2-1] + v2[p2] - v2[p2 - width];
    }

    div[0]         =  v1[0]         + v2[0];
    div[width - 1]      = -v1[width - 2] + v2[width - 1];
    div[(height - 1) * width] = v1[(height - 1) * width] - v2[(height - 2) * width];
    div[height * width - 1]   = -v1[height * width - 2] - v2[(height - 1) * width - 1];
}

// Compute local gradient at each pixel via forward differences
void forward_gradient(const float *f, float *fx, float *fy, int width, const int height)
{
    for(int i = 0; i < height - 1; i++)
    {
        int p, p1, p2;

        for(int j = 0; j < width - 1; j++)
        {
            p  = i * width + j;
            p1 = p + 1;
            p2 = p + width;
            fx[p] = f[p1] - f[p];
            fy[p] = f[p2] - f[p];
        }
    }


    // Compute the gradient on the last row
    for(int j = 0; j < width - 1; j++)
    {
        const int p = (height - 1) * width + j;
        fx[p] = f[p+1] - f[p];
        fy[p] = 0;
    }


    // Compute the gradient on the last column
    for(int i = 1; i < height; i++)
    {
        const int p = i * width - 1;
        fx[p] = 0;
        fy[p] = f[p + width] - f[p];
    }

    fx[height * width - 1] = 0;
    fy[height * width - 1] = 0;
}

void retinex_NLTychonoff
        (float *r, float *l, float *s,
         float sigma, float tau, float alpha, float beta, float gamma, int maxIter,
         std::vector<std::vector<float>> &wxy, std::vector<std::vector<int>> &posxy,
         std::vector<int> &numxy, std::vector<std::vector<float>> &wyx, std::vector<std::vector<int>> &posyx,
         std::vector<int> &numyx, std::vector<std::vector<int>> &posw,
         int width, int height
         )
{
    int dim {width * height};

    // Initialise primal variables
    libUSTG::fpClear(r,0.0f,dim);
    libUSTG::fpCopy(s,l,dim);

    // Initialise dual variables
    std::vector<std::vector<float>> rdual;
    std::vector<std::vector<float>> NLgrad_r;
    std::vector<float> vaux;
    for(int i=0; i<dim;i++)
    {
        vaux.assign(numxy[i],0.0f);
        rdual.push_back(vaux);
        NLgrad_r.push_back(vaux);
    }

    float *ldualx = new float[dim];
    libUSTG::fpClear(ldualx,0.0f,dim);
    float *ldualy = new float[dim];
    libUSTG::fpClear(ldualy,0.0f,dim);

    // Frequently used coefficients
    float betatau{beta * tau};
    float denom_primal{betatau*(2+gamma*tau)+(gamma*tau+1)};
    float denom_rdual{1+sigma/2};
    float denom_ldual{1+sigma/alpha};
    float coef_r1{betatau+gamma*tau+1};
    float coef_r2{betatau*(1+gamma*tau)};

    // Declare vectors for differential operators, both local and nonlocal. They needn't be initialised.
    float *grad_lx = new float[dim];
    float *grad_ly = new float[dim];
    float *NLdiv_rdual = new float[dim];
    float *div_ldual = new float[dim];
    float *auxl = new float[dim];
    libUSTG::fpCopy(l,auxl,dim); // store l_n when l_{n+1} is computed
    float *auxr = new float[dim];
    libUSTG::fpCopy(r,auxr,dim); // store r_n when r_{n+1} is computed
    float temp; // auxiliary value
    // Main loop
    for (int iter=0; iter<maxIter; iter++)
    {
        // Compute NLgrad_r, grad_lx, grad_ly
        nl_gradient(auxr, NLgrad_r,wxy,posxy,numxy,dim);
        forward_gradient(auxl, grad_lx, grad_ly,width, height);
        // Dual step
        for (int i = 0; i < dim; i++)
        {
            for (int j = 0; j < numxy[i]; j++)
            {
                rdual[i][j]=(rdual[i][j]+sigma*NLgrad_r[i][j])/denom_rdual;
            }

            ldualx[i]=(ldualx[i]+sigma*grad_lx[i])/denom_ldual;
            ldualy[i]=(ldualy[i]+sigma*grad_ly[i])/denom_ldual;
            auxr[i]=r[i]; // r_n -> auxr
            auxl[i]=l[i]; // l_n -> auxl
        }

        // Compute NLdiv_rdual, div_ldual
        nl_divergence(rdual, NLdiv_rdual, wxy, numxy, wyx, numyx, posyx, posw, dim);
        divergence(ldualx,ldualy, div_ldual, width, height);

        // Primal step
        for (int i = 0; i < dim; i++) {
            temp=l[i]+tau*div_ldual[i];

            r[i]=MAX((coef_r1*(r[i]+tau*NLdiv_rdual[i])+betatau*temp-coef_r2*s[i])/denom_primal,0);
            l[i]=MAX((betatau*(r[i]+tau*NLdiv_rdual[i]+temp+s[i])+temp)/denom_primal,s[i]);

            auxr[i]=2*r[i]-auxr[i]; // 2r_{n+1}-r_n -> auxr
            auxl[i]=2*l[i]-auxl[i]; // 2l_{n+1}-l_n -> auxl
        }
    }
}

void retinex_NLTV
        (float *r, float *l, float *s,
         float sigma, float tau, float alpha, float beta, float gamma, int maxIter,
         std::vector<std::vector<float>> &wxy, std::vector<std::vector<int>> &posxy,
         std::vector<int> &numxy, std::vector<std::vector<float>> &wyx, std::vector<std::vector<int>> &posyx,
         std::vector<int> &numyx, std::vector<std::vector<int>> &posw,
         int width, int height
        )
{
    int dim {width * height};

    // Initialise primal variables
    libUSTG::fpClear(r,0.0f,dim);
    libUSTG::fpCopy(s,l,dim);

    // Initialise dual variables
    std::vector<std::vector<float>> rdual;
    std::vector<std::vector<float>> NLgrad_r;
    std::vector<float> vaux;
    for(int i=0; i<dim;i++)
    {
        vaux.assign(numxy[i],0.0f);
        rdual.push_back(vaux);
        NLgrad_r.push_back(vaux);
    }

    float *ldualx = new float[dim];
    libUSTG::fpClear(ldualx,0.0f,dim);
    float *ldualy = new float[dim];
    libUSTG::fpClear(ldualy,0.0f,dim);

    // Frequently used coefficients
    float betatau{beta * tau};
    float denom_primal{betatau*(2+gamma*tau)+(gamma*tau+1)};
    float denom_rdual{1+sigma/2};
    float coef_r1{betatau+gamma*tau+1};
    float coef_r2{betatau*(1+gamma*tau)};

    // Declare vectors for differential operators, both local and nonlocal. They needn't be initialised.
    float *grad_lx = new float[dim];
    float *grad_ly = new float[dim];
    float *NLdiv_rdual = new float[dim];
    float *div_ldual = new float[dim];
    float *auxl = new float[dim];
    libUSTG::fpCopy(l,auxl,dim); // store l_n when l_{n+1} is computed
    float *auxr = new float[dim];
    libUSTG::fpCopy(r,auxr,dim); // store r_n when r_{n+1} is computed
    float temp; // auxiliary value
    // Main loop
    for (int iter=0; iter<maxIter; iter++)
    {
        // Compute NLgrad_r, grad_lx, grad_ly
        nl_gradient(auxr, NLgrad_r,wxy,posxy,numxy,dim);
        forward_gradient(auxl, grad_lx, grad_ly,width, height);
        // Dual step
        for (int i = 0; i < dim; i++)
        {
            for (int j = 0; j < numxy[i]; j++)
            {
                rdual[i][j]=(rdual[i][j]+sigma*NLgrad_r[i][j])/denom_rdual;
            }
            temp=(ldualx[i]+sigma*grad_lx[i])*(ldualx[i]+sigma*grad_lx[i])+(ldualy[i]+sigma*grad_ly[i])*(ldualy[i]+sigma*grad_ly[i]);
            ldualx[i]=(ldualx[i]+sigma*grad_lx[i])/MAX(1,sqrt(temp)/alpha);
            ldualy[i]=(ldualy[i]+sigma*grad_ly[i])/MAX(1,sqrt(temp)/alpha);
            auxr[i]=r[i]; // r_n -> auxr
            auxl[i]=l[i]; // l_n -> auxl
        }

        // Compute NLdiv_rdual, div_ldual
        nl_divergence(rdual, NLdiv_rdual, wxy, numxy, wyx, numyx, posyx, posw, dim);
        divergence(ldualx,ldualy, div_ldual, width, height);

        // Primal step
        for (int i = 0; i < dim; i++) {
            temp=l[i]+tau*div_ldual[i];

            r[i]=MAX((coef_r1*(r[i]+tau*NLdiv_rdual[i])+betatau*temp-coef_r2*s[i])/denom_primal,0);
            l[i]=MAX((betatau*(r[i]+tau*NLdiv_rdual[i]+temp+s[i])+temp)/denom_primal,s[i]);

            auxr[i]=2*r[i]-auxr[i]; // 2r_{n+1}-r_n -> auxr
            auxl[i]=2*l[i]-auxl[i]; // 2l_{n+1}-l_n -> auxl
        }
    }
}

