# -a
alphaRange=1

# -b
betaRange=5

# -c
gamma=0.00001

# -i
hsimRange='2.5'

# -j
hclose=1.25

# -r			
reswind=10

# -s
compwind=1			

# -k
numNeighbours=15		

# -n
flagNorm=1			

# -y
tau=0.005       		

# -z
sigma=0.005	           	

# -t
maxIter=2000	

# -g
gammaCorrectionRange=0.35,0.4,0.5,0.6,0.7

imageFolder=/home/frank/Documents/colaboracio_joan_catalina/imatges

image=lg-image23.png

input=${imageFolder}/inputs/${image}

output=${imageFolder}/outputs/${image%.*}

for hsim in ${hsimRange}; do
   parameters="-a ${alphaRange} -b ${betaRange} -c ${gamma} -i ${hsim} -j ${hclose} -r ${reswind} -s ${compwind} -k ${numNeighbours} -n ${flagNorm} -y ${tau} -z ${sigma} -t ${maxIter} -g ${gammaCorrectionRange}" 
   /home/frank/Documents/colaboracio_joan_catalina/codis/codis_definitiu/bin/src_pxs_RetinexNL ${parameters} ${input} ${output}
   
done

