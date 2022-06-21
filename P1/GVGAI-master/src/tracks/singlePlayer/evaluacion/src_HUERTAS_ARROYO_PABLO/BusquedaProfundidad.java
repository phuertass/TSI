package tracks.singlePlayer.evaluacion.src_HUERTAS_ARROYO_PABLO;

import java.util.ArrayList;
import java.util.Hashtable;
import core.game.StateObservation;

public class BusquedaProfundidad {	
	Funciones funcs;

	//Tabla hash que contiene las posiciones del tablero, y true o false 
	//si ha sido visitada ya esa posicion o no
	Hashtable<String, Boolean> tablero;

	ArrayList<Nodo> ruta;

	//Variables que guardan el numero de nodos expandidos y el numero de nodos
	//maximos en memoria (maximo numero de nodos que han estado en la cola)
	int  max_nodos_memoria;
	int nodos_expandidos;

	//Constrcutor de la clase
	public BusquedaProfundidad(StateObservation stateObs) {
		funcs = new Funciones(stateObs);

		ruta = new ArrayList<Nodo>();
		tablero = new Hashtable<>();

		max_nodos_memoria=0;
		nodos_expandidos=0;
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
	
	public ArrayList<Nodo> DFS(Nodo inicial, Nodo objetivo)
	{
		//Inicial no tiene nodo padre (null)
		inicial.parent=null;
		
		//Añado a la tabla hash la posicion del nodo inicial y lo marco como visitado
		tablero.put(inicial.position.toString(), true);

		//Llamo a la funcion de busqueda
		DFS_search(inicial, objetivo);

		//Cuando terminen las llamadas recursivas, devuelvo la ruta
		return ruta;
	}
	
	public boolean DFS_search(Nodo inicial, Nodo objetivo)
	{

		//Comprobamos el maximo de nodos en memoria
		if(tablero.size()>max_nodos_memoria)
			max_nodos_memoria=tablero.size();

		//Si el nodo actual es el objetivo, devuelvo true y a la variable
		//ruta le asigno el camino que ha de seguir el agente para llegar al objetivo
		if(inicial.position.equals(objetivo.position)){
    		ruta = Funciones.calcularPath(inicial);
			return true;
    	}

		//Aumentamos los nodos expandidos
		nodos_expandidos++;
    	
		//Generamos los hijos del nodo
		ArrayList<Nodo> hijos = funcs.getNeighbours(inicial);

		boolean continuar=false;
    	for(int i=0; i<hijos.size() && !continuar; i++) {
    		Nodo hijo = hijos.get(i);

			//El padre del hijo es el nodo actual
			hijo.parent=inicial;

			//Si el nodo no ha sido visitado, lo marco como visitado y llamo a la funcion de busqueda
			//de forma recursiva
			if(!tablero.containsKey(hijo.position.toString())){
				tablero.put(hijo.position.toString(), true);
    			continuar = DFS_search(hijo, objetivo);
			}
    	}
		return continuar;	
	}
}
