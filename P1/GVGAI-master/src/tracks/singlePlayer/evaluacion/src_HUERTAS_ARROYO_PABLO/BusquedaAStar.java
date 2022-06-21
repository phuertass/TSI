package tracks.singlePlayer.evaluacion.src_HUERTAS_ARROYO_PABLO;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.PriorityQueue;
import core.game.StateObservation;

public class BusquedaAStar {
	int nodos_expandidos = 0;
	int max_nodos_memoria=0;

	// Abiertos sera una cola con prioridad ordenada por el criterio de comparacion
	// del objeto com de la clase Comparator
	PriorityQueue<Nodo> Abiertos;

	//Tabla hash que contiene las posiciones del tablero, y el valor heuristico 
	//calculado de dica posicion
	Hashtable<String, Double> Cerrados;

	//Objeto de la clase Funciones
	Funciones funcs;

	public BusquedaAStar(StateObservation stateObs) {
		funcs = new Funciones(stateObs);
		
		// Inicializamos las colas de abiertos y cerrados con el criterio de 
		// comparacion de g(n)+h(n)
		Abiertos = new PriorityQueue<Nodo>(Funciones.GetCom());
		Cerrados = new Hashtable<>();
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
	
	//Funcion de busqueda que devuelve el camino de nodos a seguir desde 
	//el nodo inicial hasta el nodo objetivo
	public ArrayList<Nodo> CalculaCamino(Nodo inicial, Nodo objetivo)
	{
		//Actualizamos el nodo inicial con sus valores correspondientes
		Nodo current = inicial;
		inicial.parent=null;
		inicial.totalCost=0;
		inicial.estimatedCost+=Funciones.DistanciaManhattan(inicial, objetivo);
		
		//Lo añadimos a la cola con prioridad de abiertos
		Abiertos.add(inicial);
		
		while(true)
		{	
			// Se coge el elemento con mejor f(n), ya que la cola de abiertos
			// es una cola con prioridad ordenada por f(n)
			current = Abiertos.poll();
			
			//Lo añado a la tabla hash de cerrados, con la posicion y su coste estimado
			Cerrados.put(current.position.toString(), current.estimatedCost);
			
			//Actualizacion del numero maximo de nodos en memoria
			if(Cerrados.size() + Abiertos.size() > max_nodos_memoria)
				max_nodos_memoria = Cerrados.size() + Abiertos.size();

			//Comprobamos si es solucion
			if(current.position.equals(objetivo.position))
				return Funciones.calcularPath(current);
			
			//Expandimos el nodo actual
			nodos_expandidos++;
			ArrayList<Nodo> hijos = funcs.getNeighbours(current);
	    	for(int i=0; i<hijos.size(); i++) {
				Nodo hijo = hijos.get(i);
				//Si el hijo generado es igual al hijo actual, pasamos a la siguiente iteracion
				//del bucle
				if(hijo==current)
					continue;
				
				//Actualizamos el padre del hijo generado con el nodo actual
				hijo.parent = current;
				
				//Si el hijo generado no esta en la tabla hash de cerrados y tampoco 
				//está en la cola de abiertos, lo añadimos
				if(!Abiertos.contains(hijo) && !Cerrados.containsKey(hijo.position.toString()))
				{
					//Actualizamos los costes del hijo generado y lo añado a la cola de abiertos
					hijo.totalCost += current.totalCost;
					hijo.estimatedCost += Funciones.DistanciaManhattan(hijo, objetivo);
					Abiertos.add(hijo);

					//Aqui no lo añado a la tabla hash de cerrados porque cuando lo saque de la cola de 
					//abiertos, se añadira a cerrados
				}

	    	}
		}
	}
}
