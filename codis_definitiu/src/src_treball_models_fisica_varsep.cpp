#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fstream>
#include <sstream>
#include <stdbool.h>
#include <time.h>
#include <math.h>

#include "tami/core/libImage.h"
#include "libtreball_models_fisica.h"

int main(int argc, char **argv)
{
    std::vector <OptStruct *> options;
    OptStruct ogamma = {"c:", 0, "1", NULL, "Parameter gamma"}; options.push_back(&ogamma);
    OptStruct oIter = {"t:", 0, "1000", NULL, "Nombre de sumands a emprar"}; options.push_back(&oIter);

    std::vector<ParStruct *> parameters;
    ParStruct pInit = {"init", NULL, "input channel initialization"}; parameters.push_back(&pInit);
    ParStruct pOutput_im = {"output_im", NULL, "output image"}; parameters.push_back(&pOutput_im);

    if(!parsecmdline(
            "treball_models_fisica_varsep.cpp", "INFO: Implementacio treball per variables separades", argc, argv, options, parameters))
        return EXIT_FAILURE;

    float gamma = atof(ogamma.value);
    int maxIter = atoi(oIter.value);

    libUSTG::cflimage init;
    init.load(pInit.value);

    int width {init.w()};
    int height {init.h()};
    int dim {width * height};
    int num_channels = init.c();

    float **s = new float*[num_channels];
    for(int c = 0; c < num_channels; c++)
    {
        s[c] = new float[dim];
        libUSTG::fpCopy(init.v(c), s[c], dim);
    }

    for (int c=0; c<num_channels;c++) {
				varsep(s[c],gamma,maxIter,width,height);
    }

    // Save output
    libUSTG::cflimage outputim(width,height,num_channels);

    for(int c = 0; c < num_channels; c++)
        libUSTG::fpCopy(s[c], outputim.v(c), dim);

    outputim.save(pOutput_im.value);

    return 0;
}
