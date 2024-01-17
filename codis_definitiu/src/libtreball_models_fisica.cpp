#include "libtreball_models_fisica.h"
#include <sstream>
#include <cmath>
// DEBUG: printf(s[0]);
//     o: std::cout << e importar iostream

// Main variables separades
void varsep(float *s, float gamma, int maxIter, int width, int height)
{
		int dim {width*height};
		std::vector<float> u(dim);
		// Inicialitzam a 0
		for (int y=0;y<height;y++)
		{
				for (int x=0;x<width;x++)
				{
						u[y*width+x]=0;
				}
		}

		std::vector<float> Xn(width); // Xn[x]=X_n(x)
		std::vector<float> Yn(height); // Yn[y]=Y_n(y)
		std::vector<float> Cn(height); // Cn[y]=C_(y)
		std::vector<float> Intn1(height); // Intn1[y]=\sum_{k=0}^y\sinh(k\delta_n)C_n(k)
		std::vector<float> Intn2(height); // Intn2[y]=\sum_{k=0}^y\cosh(k\delta_n)C_n(k)

		// Constants per a calcular cada Yn
		float sqkn;
		float deltan;
		float taun;
		float thetan;
		float bn;

		for (int n=0;n<maxIter;n++)
		{
				for (int x=0;x<width;x++)
				{
						Xn[x]=0;
				}
				for (int y=0;y<height;y++)
				{
						Cn[y]=0;
						Yn[y]=0;
						Intn1[y]=0;
						Intn2[y]=0;
				}
				sqkn=(n*(3.1415926535)/width);
				deltan=std::sqrt(sqkn*sqkn+gamma);
				// Calculam X_n, C_n[0]
				for(int x=0; x<width;x++)
				{
						Xn[x]=std::sqrt(2.0/width)*std::sin((n*x*3.1415926535)/width);
						Cn[0]=Cn[0]+s[x]*Xn[x];
				}
				Cn[0]=gamma*Cn[0];
				// Calculam C_n, I_n1, I_n2
				Intn1[0]=0;
				Intn2[0]=Cn[0];
				Yn[0]=0;
				for (int y=1;y<height;y++)
				{
						// Calculam C_n(y)
						for (int x=0;x<width;x++)
						{
								Cn[y]=Cn[y]+s[y*width+x]*Xn[x];
						}
						Cn[y]=gamma*Cn[y];

						// La integral entre 0 i y+1 (suma de 0 a y)
						Intn1[y]=Intn1[y-1]+Cn[y]*std::sinh(y*deltan);
						Intn2[y]=Intn2[y-1]+Cn[y]*std::cosh(y*deltan);
				}
				thetan=-Intn1[height-1]/deltan;
				taun=Intn2[height-1];
				bn=thetan+std::tanh(height*deltan)/deltan*taun;
				for (int y=1;y<height;y++)
				{
						Yn[y]=(std::sinh(y*deltan)*bn-std::cosh(y*deltan)*Intn1[y]+std::sinh(y*deltan)*Intn2[y])/deltan;
				}
				// Actualitzam u
				for (int y=0;y<height;y++)
				{
						for (int x=0;x<width;x++)
						{
								u[width*y+x]=u[width*y+x]+Xn[x]*Yn[y];
						}
				}
		}
		// Actualitzam s
		for (int y=0;y<height;y++)
		{
				for (int x=0;x<width;x++)
				{
						s[width*y+x]=u[width*y+x];
				}
		}
}
