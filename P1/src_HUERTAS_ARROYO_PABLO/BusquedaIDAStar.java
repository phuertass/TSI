package tracks.singlePlayer.evaluacion.src_HUERTAS_ARROYO_PABLO;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedList;
import core.game.StateObservation;


public class BusquedaIDAStar {
	LinkedList<Nodo> camino;

	int nodos_expandidos;
	int max_nodos_memoria;
	
	static final double INFINITO = 9999999999.0;

	Funciones funcs;

	//Constructor de la clase
	public BusquedaIDAStar(StateObservation stateObs) {
		funcs = new Funciones(stateObs);
		camino = new LinkedList<Nodo>();

		nodos_expandidos = 0;
		max_nodos_memoria = 0;
	}
	
	
	//Funcion que devuelve el maximo numero de nodos en memoria
	int GetMaxNodosMemoria(){
		return max_nodos_memoria;
	}
	
	//Funcion que devuelve el numero de nodos expandidos
	int GetNodosExpandidos()
	{
		return nodos_expandidos;
	}
	

	public LinkedList<Nodo> IDAStar(Nodo inicial, Nodo objetivo)
	{
		double cota = Funciones.DistanciaManhattan(inicial, objetivo);
		inicial.estimatedCost = cota;
		camino.addLast(inicial);

		boolean sigue=true;
		double t;

		while(sigue)
		{
			t = CalculaCamino(camino, 0, cota, objetivo);
			
			//Actualizo el maximo de nodos en memoria, que con este algoritmo 
			//sera el mayor tamaño del camino
			if(camino.size()>max_nodos_memoria)
				max_nodos_memoria=camino.size();

			//Si t es 0, considero que hemos llegado al objetivo
			if(t==0.0f) return camino;
			else cota = t;
		}
		
		return null;
	};

	public double CalculaCamino(LinkedList<Nodo> camino, double g, double cota, Nodo objetivo)
	{
		Nodo current = camino.getLast();
		
		double f = g + current.estimatedCost;
		
		//Si la heuristica del nodo es mayor que la cota, no hay que expandir
		//más nodos, y devolvemos el valor de la heuristica
		if(f>cota)	return f;
		
		//Si es solucion, devuelvo 0(el camino se va calculando constantemente)
		if(current.position.equals(objetivo.position))
			return 0.0f;
		
		//Actualizo la variable minimo a infinito, para que el siguiente nodo
		//sea el que tenga el valor mínimo y asi tener una buena referencia
		double min = INFINITO;

		//Genero los sucesores del nodo actual
		ArrayList<Nodo> hijos = funcs.getNeighbours(current);
		//Aumento el numero de nodos expandidos
		nodos_expandidos++;
    	for(int i=0; i<hijos.size(); i++) {

			//Para cada hijo, le actualizo sus valores de g(n), h(n) y su padre
			Nodo hijo = hijos.get(i);
			hijo.totalCost += current.totalCost;
			hijo.estimatedCost+=Funciones.DistanciaManhattan(hijo, objetivo);
			hijo.parent = current;
		}

		//Ordeno los sucesores de menor a mayor valor de f(n)
		Collections.sort(hijos, Funciones.GetCom());

		for(int i=0; i<hijos.size(); i++)
		{
			//Para cada hijo, si no se encuentra en el camino actual, lo añado
			//y llamo recursivamente a la funcion de nuevo, pero incrementando en
			//1 el valor de g(n) (1 porque es el coste de moverse desde una casilla a otra en este juego)
			Nodo hijo = hijos.get(i);
			if(!camino.contains(hijo)){
				camino.addLast(hijo);
				double t = CalculaCamino(camino, g+1, cota, objetivo);

				//Compruebo el tamaño del camino para actualizar el maximo 
				//de nodos en memoria
				if(camino.size()> max_nodos_memoria) max_nodos_memoria=camino.size();

				//Si la llamada recursiva ha encontrado el camino, devuelvo 0
				if(t==0) return 0.0f;
				//Actualizo el valor minimo de t
				else if(t<min) min = t;

				//Elimino el nodo del camino
				camino.removeLast();
			}	
		}
    	
		return min;
	}
}
