#include "tami/core/libBasic.h"

std::vector<std::string> split(std::string s, std::string delimiter);

// Computes the next iteration of primal variables
void primal_step(float *r, float *l, float *s,
                 float *NLdiv_rdual, float *div_ldual,
                 int dim, float beta, float gamma, float tau);

// Computes next iteration of dual variables
void dual_step(std::vector< std::vector<float> > &rdual, float *ldualx, float *ldualy,
               std::vector< std::vector<float> > &NLgrad_r, float *grad_lx, float *grad_ly,
               std::vector<int> &numxy, int dim, float alpha, float sigma);

// Compute sqrt(weights) for NL regularization on a prescribed color image using all neighbouring pixels
void nlweights_reg(float *image, std::vector< std::vector<float> > &wxy, std::vector< std::vector<int> > &posxy,
                   std::vector<int> &numxy, std::vector< std::vector<float> > &wyx, std::vector< std::vector<int> > &posyx,
                   std::vector<int> &numyx, std::vector< std::vector<int> > &posw, float hSim, float hClose, int numNeighbours,
                   int reswind, int compwind, int flagNormalize, int width, int height);

// Compute nonlocal divergence at each pixel as minus the adjoint operator of the nonlocal gradient
void nl_divergence(std::vector< std::vector<float> > &data, float *nldiv, std::vector< std::vector<float> > &wxy,
                   std::vector<int> &numxy, std::vector< std::vector<float> > &wyx, std::vector<int> &numyx,
                   std::vector< std::vector<int> > &posyx, std::vector< std::vector<int> > &posw, int dim);

// Compute nonlocal gradient operator at each pixel
void nl_gradient(float *data, std::vector< std::vector<float> > &nlgrad, std::vector< std::vector<float> > &wxy,
                 std::vector< std::vector<int> > &posxy, std::vector<int> &numxy, int dim);

// Compute local divergence at each pixel as minus the adjoint operator of the local gradient, div = -nabla^T
void divergence(const float *v1, const float *v2, float *div, const int width, const int height);

// Compute local gradient at each pixel via forward differences
void forward_gradient(const float *f, float *fx, float *fy, int width, const int height);

// Weights need to be calculated beforehand
void primaldual_step
        (float *r, float *l, float *s,
         std::vector<std::vector<float>> &NLgrad_r, float *grad_lx, float *grad_ly,
         std::vector<std::vector<float>> &rdual, float *ldualx, float *ldualy,
         float *NLdiv_rdual, float *div_ldual,
         float sigma, float tau, float alpha, float beta, float gamma,
         std::vector<std::vector<float>> &wxy, std::vector<std::vector<int>> &posxy, std::vector<int> &numxy,
         std::vector<std::vector<float>> &wyx, std::vector<std::vector<int>> &posyx, std::vector<int> &numyx,
         std::vector<std::vector<int>> &posw,
         int width, int height, int dim);

void retinex_NLTychonoff
        (float *r, float *l, float *s,
         float sigma, float tau, float alpha, float beta, float gamma, int maxIter,
         std::vector<std::vector<float>> &wxy, std::vector<std::vector<int>> &posxy,
         std::vector<int> &numxy, std::vector<std::vector<float>> &wyx, std::vector<std::vector<int>> &posyx,
         std::vector<int> &numyx, std::vector<std::vector<int>> &posw,
         int width, int height
        );

void retinex_NLTV
        (float *r, float *l, float *s,
         float sigma, float tau, float alpha, float beta, float gamma, int maxIter,
         std::vector<std::vector<float>> &wxy, std::vector<std::vector<int>> &posxy,
         std::vector<int> &numxy, std::vector<std::vector<float>> &wyx, std::vector<std::vector<int>> &posyx,
         std::vector<int> &numyx, std::vector<std::vector<int>> &posw,
         int width, int height
        );