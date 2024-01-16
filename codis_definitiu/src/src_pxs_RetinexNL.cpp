#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fstream>
#include <sstream>
#include <stdbool.h>
#include <time.h>
#include <math.h>




//TODO: quitar
#include <typeinfo>
#include <iostream>

#include "tami/core/libImage.h"
#include "libRetinexNL.h"

int main(int argc, char **argv)
{
    std::vector <OptStruct *> options;
    OptStruct oalphaRange = {"a:", 0, "1", NULL, "Parameter alpha range"}; options.push_back(&oalphaRange);
    OptStruct obetaRange = {"b:", 0, "1", NULL, "Parameter beta range"}; options.push_back(&obetaRange);
    OptStruct ogamma = {"c:", 0, "1", NULL, "Parameter gamma"}; options.push_back(&ogamma);
    OptStruct ohSim = {"i:", 0, "2.5", NULL, "Filtering parameter for most similar pixels"}; options.push_back(&ohSim);
    OptStruct ohClose = {"j:", 0, "1.25", NULL, "Filtering parameter for closest pixels"}; options.push_back(&ohClose);
    OptStruct oreswind = {"r:", 0, "10", NULL, "Half-size of research window"}; options.push_back(&oreswind);
    OptStruct ocompwind = {"s:", 0, "1", NULL, "Half-size of comparison window"}; options.push_back(&ocompwind);
    OptStruct onumNeighbours = {"k:", 0, "15", NULL, "Number of neighbours of each pixel"}; options.push_back(&onumNeighbours);
    OptStruct oflagNormW = {"n:", 0, "1", NULL, "Normalize weights"};  options.push_back(&oflagNormW);
    OptStruct oTau = {"y:", 0, "0.05", NULL, "Step-size of proximity operator of data-fidelity term)"}; options.push_back(&oTau);
    OptStruct oSigma = {"z:", 0, "0.05", NULL, "Step-size of proximity operator of regularization term)"}; options.push_back(&oSigma);
    OptStruct oIter = {"t:", 0, "1000", NULL, "Max algorithm iterations"}; options.push_back(&oIter);
    OptStruct ogammaCorrectionRange = {"g:", 0, "0.5", NULL, "Luminance gamma correction factor range"}; options.push_back(&ogammaCorrectionRange);

    std::vector<ParStruct *> parameters;
    ParStruct pInit = {"init", NULL, "input channel initialization"}; parameters.push_back(&pInit);
    ParStruct pOutput = {"output", NULL, "output folder path"}; parameters.push_back(&pOutput);

    if(!parsecmdline(
            "src_pxs_RetinexNL.cpp", "INFO: Retinex Nonlocal", argc, argv, options, parameters))
        return EXIT_FAILURE;

    std::string abs_path(pOutput.value);
    abs_path=abs_path+"/Tychonoff";
    std::vector<std::string> alphaRange = split(oalphaRange.value,",");
    std::vector<std::string> betaRange = split(obetaRange.value,",");
    float gamma = atof(ogamma.value);
    float hSim = atof(ohSim.value);
    float hClose = atof(ohClose.value);
    int reswind = atoi(oreswind.value);
    int compwind = atoi(ocompwind.value);
    int numNeighbours = atoi(onumNeighbours.value);
    int flagNormalize = oflagNormW.flag;
    float tau = atof(oTau.value);
    float sigma = atof(oSigma.value);
    int maxIter = atoi(oIter.value);
    std::vector<std::string> gammaCorrectionRange = split(ogammaCorrectionRange.value,",");

    libUSTG::cflimage init;
    init.load(pInit.value);

    int width {init.w()};
    int height {init.h()};
    int dim {width * height};
    int num_channels = init.c();

    float **s = new float*[num_channels];
    float **r = new float*[num_channels];
    float **l = new float*[num_channels];

    for(int c = 0; c < num_channels; c++)
    {
        s[c] = new float[dim];
        r[c] = new float[dim];
        l[c] = new float[dim];
        libUSTG::fpCopy(init.v(c), s[c], dim);
    }

    float *s_grayscale= new float[dim];
    libUSTG::fpClear(s_grayscale,0.0f,dim);
    // Compute grayscale image
    for (int i=0; i<dim; i++){
        for (int c=0; c<num_channels; c++){
            s_grayscale[i]=s_grayscale[i]+s[c][i];
        }
        s_grayscale[i]=s_grayscale[i]/num_channels;
    }

    std::vector< std::vector<float> > wxy;
    std::vector< std::vector<int> > posxy;
    std::vector<int> numxy;
    std::vector< std::vector<float> > wyx;
    std::vector< std::vector<int> > posyx;
    std::vector<int> numyx;
    std::vector< std::vector<int> > posw;

    // Compute nonlocal weights
    nlweights_reg(s_grayscale, wxy, posxy, numxy, wyx, posyx, numyx, posw, hSim, hClose,
                  numNeighbours, reswind, compwind, flagNormalize, width, height);

    printf("Computed weights\n");
    for (int c=0; c<num_channels; c++){
        for (int i=0; i<dim; i++)
        {
            s[c][i]= log(s[c][i]+1);
        }

    }


    float alpha;
    float beta;
    float gammaCorrection;
    std::string file_name;
    // Save output
    libUSTG::cflimage outputim(width,height,num_channels);
    libUSTG::cflimage outputr(width, height, num_channels);
    libUSTG::cflimage outputl(width,height,num_channels);


    for (auto str_alpha: alphaRange){for(auto str_beta: betaRange){
        alpha= atof(str_alpha.c_str());
        beta= atof(str_beta.c_str());

        for (int c=0;c<num_channels;c++){
            retinex_NLTychonoff(r[c], l[c], s[c], sigma, tau, alpha, beta, gamma, maxIter, wxy, posxy, numxy, wyx, posyx, numyx,
                                 posw, width, height);

            for (int i=0; i<dim; i++){
                l[c][i]= exp(l[c][i]);
                r[c][i]= exp(-r[c][i]);
            }

            printf(("Computed channel "+std::to_string(c+1)+"\n").c_str());
        }

        for (auto str_gammaCorrection: gammaCorrectionRange){
            gammaCorrection= atof(str_gammaCorrection.c_str());
            file_name="a"+str_alpha+"b"+str_beta+"gcorr"+str_gammaCorrection+".tif";
            for (int c=0; c<num_channels; c++) {
                libUSTG::fpCopy(l[c], outputl.v(c), dim);
                libUSTG::fpCopy(r[c], outputr.v(c), dim);
                // Gamma correction and r visualization
                for (int i=0;i<dim;i++) {
                    s[c][i] = r[c][i] * 255 * pow(l[c][i] / 255, gammaCorrection);
                }
                libUSTG::fpCopy(s[c], outputim.v(c), dim);
            }

            outputr.save((abs_path+"/R/TychonoffR"+file_name).c_str());
            outputl.save((abs_path+"/L/TychonoffL"+file_name).c_str());
            outputim.save((abs_path+"/image/Tychonoffim"+file_name).c_str());

            printf(("Saved image "+file_name+"\n").c_str());
        }

        for (int c=0; c<num_channels; c++){
            libUSTG::fpCopy(init.v(c), s[c], dim);
            for (int i=0; i<dim; i++)
            {
                s[c][i]= log(s[c][i]+1);
            }

        }

    }}



    return 0;
}