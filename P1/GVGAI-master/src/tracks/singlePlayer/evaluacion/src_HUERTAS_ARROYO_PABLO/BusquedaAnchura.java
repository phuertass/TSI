package tracks.singlePlayer.evaluacion.src_HUERTAS_ARROYO_PABLO;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.LinkedList;


import core.game.StateObservation;
import tools.Vector2d;



public class BusquedaAnchura {
	//Cola de nodos que va a ser usada en el algoritmo de busqueda
	LinkedList<Nodo> cola;

	//Tabla hash que contiene las posiciones del tablero, y true o false 
	//si ha sido visitada ya esa posicion o no
	Hashtable<String, Boolean> tablero;

	//Variables que guardan el numero de nodos expandidos y el numero de nodos
	//maximos en memoria (maximo numero de nodos que han estado en la cola)
	int nodos_expandidos;
	int max_nodos_memoria;

	Funciones funcs;

	//Constructor de la clase
	public BusquedaAnchura(StateObservation stateObs) {
		funcs = new Funciones(stateObs);
		cola = new LinkedList<>();
		max_nodos_memoria=0;
		nodos_expandidos=0;
		tablero = new Hashtable<>();
	}

	//Funcion que devuelve el numero de nodos expandidos
	int GetNodosExpandidos()
	{
		return nodos_expandidos;
	}

	//Funcion que devuelve el numero maximo de nodos en memoria
	int GetMaxNodosMemoria()
	{
		return max_nodos_memoria;
	}

	//Funcion que devuelve el camino que ha de seguir el agente para llegar al objetivo
	public ArrayList<Nodo> CalculaCamino(Nodo inicial, Nodo objetivo)
	{
		//Inicializo la cola con el nodo inicial
		//Inicial no tiene nodo padre (null)
		//Añado a la tabla hash la posicion del nodo inicial y lo marco como visitado
		inicial.parent=null;
		tablero.put(inicial.position.toString(), true);
		cola.add(inicial);


		//Mientras la cola no esta vacia...
		while(!cola.isEmpty())
		{
			//Si el numero de visitados es mayor que max_nodos_memoria se actualiza
			if(tablero.size()>max_nodos_memoria)
				max_nodos_memoria=tablero.size();

			//Obtengo el primer nodo de la cola
			Nodo current = cola.poll();
			

        	//Comprueba si es solucion
        	if(current.position.equals(objetivo.position)) {
        		return Funciones.calcularPath(current);
        	}
			//Aumento en uno el numero de nodos expandidos
        	nodos_expandidos++;

			//Genero los hijos posibles del nodo actual
			ArrayList<Nodo> hijos = funcs.getNeighbours(current);
			for(int i=0; i<hijos.size(); i++){
				Nodo hijo = hijos.get(i);

				//Si la posicion del hijo no ha sido visitada la añado a la cola,
				//y actualizo su padre al nodo actual
				//Además añado dicha posicion al tablero y lo marco como visitado
				if(!tablero.containsKey(hijo.position.toString())){
					hijo.parent = current;
					tablero.put(hijo.position.toString(), true);
					cola.add(hijo);
				}
			}  
        }

		//Si no se ha encontrado solucion devuelvo null
        return null;
	}
}

