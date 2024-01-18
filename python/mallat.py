from PIL import Image # Llibreria per carregar imatges
import numpy as np

projectDir="/home/frank/UIB/Quart/S1/models_fisica/mates/treball/"
inputDir=projectDir+"imatges/inputs/"
outputDir=projectDir+"imatges/outputs/mallat/"

def EDPEliptica(m, n, a, b, c, d, f, g, sol_exacta=0):
    """
    Ofrece una solución aproximación de u(x, y)

    Args:
        m: (int) Número de rectas horizontales del mallado
        n: (int) Número de rectas verticales del mallado
        a: (float) Extremo izquierdo del intervalo [a, b]
        b: (float) Extremo derecho del intervalo [a, b]
        c: (float) Extremo izquierdo del intervalo [c, d]
        d: (float) Extremo derecho del intervalo [c, d]
        f: (fun) Función f(x, y)
        g: (fun) Función g(x, y)
        sol_exacta: (fun) Función para definir la solución exacta

    Returns:
        u: (ndarray) Aproximaciones de u(x, y)
    """

    # Hallamos los pasos para x y para y
    h = (b - a) / n
    k = (d - c) / m


    #print("h =", h)
    #print("k =", k)

    x = np.zeros(n)
    y = np.zeros(m)

    for i in range(n):
        x[i] = a + (i + 1) * h

    for j in range(m):
        y[j] = c + (j + 1) * k


    #print("\nx =", x)
    #print("y =", y)


    Lambda = math.pow(h, 2) / math.pow(k, 2)
    mu = 2 * (1 + Lambda)

    #print("\nlambda =", Lambda)
    #print("mu =", mu)

    A = np.zeros(((n - 1) * (m - 1), (n - 1) * (m - 1)))
    B = np.zeros((n - 1) * (m - 1))

    for l in range(1, (n - 1) * (m - 1) + 1):
        i = l - (math.ceil(l / (n - 1)) - 1) * (n - 1)
        j = m - math.ceil(l / (n - 1))

        B[l - 1] = -math.pow(h, 2) * f(x[i - 1], y[j - 1])
        A[l - 1, l - 1] = mu

        if (i - 1) >= 1:
            A[l - 1, l - 2] = -1
        if (i + 1) <= n - 1:
            A[l - 1, l] = -1
        if (j - 1) >= 1:
            A[l - 1, l + (n - 1) - 1] = -Lambda
        if (j + 1) <= m - 1:
            A[l - 1, l - (n - 1) - 1] = -Lambda
        if i == 1:
            B[l - 1] += g(a, y[j - 1])
        if i == n - 1:
            B[l - 1] += g(b, y[j - 1])
        if j == 1:
            B[l - 1] += Lambda * g(x[i - 1], c)
        if j ==  m - 1:
            B[l - 1] += Lambda * g(x[i - 1], d)


    #print("\nA =\n{}".format(A))
    #print("b =\n{}".format(B))

    u = np.linalg.solve(A, B)
    """
    error = np.zeros_like(u, dtype = float)
    u_exacta = np.zeros_like(u, dtype = float)
    coor_x = np.zeros_like(u, dtype = float)
    coor_y = np.zeros_like(u, dtype = float)

    k=0
    for y in np.array([c + (d - c) / m * i for i in range(m-1, 0,-1)]):
        for x in np.array([a + (b - a) / n * j for j in range(1, n)]):
            coor_x[k] = x
            coor_y[k] = y
            error[k]=(u_exacta[k]-u[k])
            k=k+1

    #resultados = pd.DataFrame({"x":coor_x, "y":coor_y, "u": u, "u exacta": u_exacta, "error":error})

    #print(resultados)
    """
    return u

def g(x,y):
    return 0

inputImg="cavalls.jpg"
gamma=1

with Image.open(inputDir+inputImg) as u0:
    u0.load()
    u0R,u0G,u0B=u0.split() # separam per colors
    u0R=np.asarray(u0R)
    u0G=np.asarray(u0G)
    u0B=np.asarray(u0B)

    n,m=u0.size # u0 es una imatge de n x m pixels

    uR=np.zeros((n,m))
    uG=np.zeros((n,m))
    uB=np.zeros((n,m))

    # Tractament

    u=Image.merge("RGB",(uR,uG,uB))
    u.show()
#    u.save(outputDir+"gamma"+str(gamma)+inputImg)
