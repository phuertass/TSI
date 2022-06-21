import numpy as np

# Funcion para generar un grafo aleatorio
# con n nodos y m aristas
def generar_grafo(n, m, seed):
    print("n=%d;" % n)
    print("m=%d;" % m)
    print("E=[", end="" )

    #Fijamos la semilla
    np.random.seed(seed)

    #Iteramos para cada arista
    for i in range(m):
        #Generamos dos nodos en [1,n]
        nodo1 = np.random.randint(0,n)+1
        nodo2 = np.random.randint(0,n)+1

        #Si son el mismo nodo, se regenera
        while nodo1 == nodo2:
            nodo2 = np.random.randint(0,n)+1
        
        #Se imprime la arista
        print("|%d,%d" % (nodo1, nodo2), end="\n")

    print("|];")
    print("")


generar_grafo(150, 1000, 3)

