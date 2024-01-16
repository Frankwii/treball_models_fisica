#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fstream>
#include <sstream>
#include <stdbool.h>
#include <time.h>
#include <math.h>

#include "tami/core/libImage.h"
#include "libRetinexNLTychonoff.h"

int main(int argc, char **argv)
{
    std::vector <OptStruct *> options;
    OptStruct oalpha = {"a:", 0, "1", NULL, "Parameter alpha"}; options.push_back(&oalpha);
    OptStruct obeta = {"b:", 0, "1", NULL, "Parameter beta"}; options.push_back(&obeta);
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
    OptStruct ogammaCorrection = {"g:", 0, "0.5", NULL, "Luminance gamma correction factor"}; options.push_back(&ogammaCorrection);

    std::vector<ParStruct *> parameters;
    ParStruct pInit = {"init", NULL, "input channel initialization"}; parameters.push_back(&pInit);
    ParStruct pOutput_r = {"output_r", NULL, "output r"}; parameters.push_back(&pOutput_r);
    ParStruct pOutput_l = {"output_l", NULL, "output l"}; parameters.push_back(&pOutput_l);
    ParStruct pOutput_im = {"output_im", NULL, "output image"}; parameters.push_back(&pOutput_im);

    if(!parsecmdline(
            "src_pxs_RetinexNLTychonoff.cpp", "INFO: Retinex Nonlocal Tychonoff", argc, argv, options, parameters))
        return EXIT_FAILURE;

    float alpha = atof(oalpha.value);
    float beta = atof(obeta.value);
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
    float gammaCorrection = atof(ogammaCorrection.value);

    libUSTG::flimage init;
    init.load(pInit.value);

    int width {init.w()};
    int height {init.h()};
    int dim {width * height};

    float *s= new float[dim];
    libUSTG::fpCopy(init.v(), s, dim);
    std::vector< std::vector<float> > wxy;
    std::vector< std::vector<int> > posxy;
    std::vector<int> numxy;
    std::vector< std::vector<float> > wyx;
    std::vector< std::vector<int> > posyx;
    std::vector<int> numyx;
    std::vector< std::vector<int> > posw;

    // Compute nonlocal weights
    nlweights_reg(s, wxy, posxy, numxy, wyx, posyx, numyx, posw, hSim, hClose,
                  numNeighbours, reswind, compwind, flagNormalize, width, height);

    for (int i=0; i<dim; i++)
    {
        s[i]= log(s[i]+0.01f);
    }
    float *r = new float[dim];
    float *l = new float[dim];

    retinex_NL_Tychonoff(r,l,s,sigma,tau,alpha,beta,gamma,maxIter,wxy,posxy,numxy,wyx,posyx,numyx,posw,width,height);

    for (int i=0; i<dim; i++){
        r[i]= exp(-r[i]);
        l[i]= exp(l[i]);
        l[i]=255*pow(l[i]/255,gammaCorrection);
        s[i]= r[i]*l[i];
        r[i]=255*r[i];
    }

    libUSTG::flimage outputr(width,height,r);
    outputr.save(pOutput_r.value);
    libUSTG::flimage outputl(width,height,l);
    outputl.save(pOutput_l.value);
    libUSTG::flimage outputim(width,height,s);
    outputim.save(pOutput_im.value);

    return 0;
}