#!/bin/bash

# -c
gamma=1
# -t
maxIter=2000

projectDir="$HOME/UIB/Quart/S1/models_fisica/mates/treball"

imageDir=${projectDir}/imatges

image=cavalls

input=${imageDir}/inputs/${image}.jpg

output=${imageDir}/outputs/varsep/g${gamma}${image}.tiff

parameters="-c ${gamma} -t ${maxIter}" 

${projectDir}/codis/codis_definitiu/bin/src_treball_models_fisica_varsep ${parameters} ${input} ${output}

