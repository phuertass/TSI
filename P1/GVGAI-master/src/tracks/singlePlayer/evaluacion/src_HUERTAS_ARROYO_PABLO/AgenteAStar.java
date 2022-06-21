package tracks.singlePlayer.evaluacion.src_HUERTAS_ARROYO_PABLO;

import java.util.ArrayList;
import java.util.LinkedList;

import core.game.Observation;
import core.game.StateObservation;
import ontology.Types;
import ontology.Types.ACTIONS;
import tools.ElapsedCpuTimer;
import tools.Vector2d;

import core.player.AbstractPlayer;

public class AgenteAStar extends AbstractPlayer {
    private Vector2d fescala;
    private Vector2d portal;
	Vector2d pos_ini;
    Nodo inicial;
    Nodo objetivo;

    //ArrayList de nodos que será el que devuelva la función de búsqueda
    private ArrayList<Nodo> camino;

    //Lista en la que se guarda el recorrido que ha de seguir al agente para
    //llegar al objetivo
    private LinkedList<ACTIONS> ruta;

    BusquedaAStar AStar;
    
	//Variable que permite llamar al metodo para buscar el camino una unica vez
	//en "act"
    boolean primeravez=true;
    
    /**
     * Public constructor with state observation and time due.
     *
     * @param stateObs     state observation of the current game.
     * @param elapsedTimer Timer for the controller creation.
     */
    public AgenteAStar(StateObservation stateObs, ElapsedCpuTimer elapsedTimer){
		
		//Calculo de los nodos inicial y objetivo, obteniendo sus coordenada del grid
		fescala = new Vector2d(stateObs.getWorldDimension().width / stateObs.getObservationGrid().length,
				stateObs.getWorldDimension().getHeight() / stateObs.getObservationGrid()[0].length);
		
		ArrayList<Observation>[] posiciones = stateObs.getPortalsPositions(stateObs.getAvatarPosition());
		portal = posiciones[0].get(0).position;
		portal.x = Math.floor(portal.x / fescala.x);
		portal.y = Math.floor(portal.y / fescala.y);
	    
		pos_ini = new Vector2d(stateObs.getAvatarPosition().x / 
        		fescala.x, stateObs.getAvatarPosition().y / fescala.y);
		
		inicial = new Nodo(pos_ini);
        objetivo = new Nodo(portal);
		
		//Inicializacion de los objetos de la clase Busqueda de A*, y la ruta que
		//se devolvera
		AStar = new BusquedaAStar(stateObs);
    }
    	
    	
    @Override
    public Types.ACTIONS act(StateObservation stateObs, ElapsedCpuTimer elapsedTimer) {
    	if(primeravez)
    	{
			//Una vez que se calcule el camino no se vuelve a calcular
    		primeravez = false;
			
			//Calculamos el tiempo que tarda en calcular el camino desde el nodo inicial 
			//hasta el objetivo
			long tInicio = System.nanoTime();
    	    camino = AStar.CalculaCamino(inicial, objetivo);
			long tFin = System.nanoTime();
            long tiempoTotalenMiliSegundos = (tFin - tInicio)/1000000;
    		
			//Con el conjunto de nodos se calcula la ruta a seguir
            ruta = Funciones.CalculoRuta(camino, inicial);
			
    		
			//Muestra por pantalla los datos que han sido pedidos en la entrega
			//-Numero de nodos expandidos son el numero de nodos de los que se han generado sus hijos
			//-Maximo de nodos en memoria es el numero maximo de nodos que se han encontrado en 
			// algun momento del calculo del camino en memoria
			//-Tamaño de la ruta es el numero de acciones que se han necesitado para llegar del nodo 
			// inicial al nodo objetivo
			//-Tiempo de ejecucion es el tiempo que ha conllevado la busqueda del camino del algoritmo
    		System.out.println("Numero de nodos expandidos--->"+AStar.GetNodosExpandidos());
			System.out.println("Maximo de nodos en memoria--->"+AStar.GetMaxNodosMemoria());
			System.out.println("Tamaño de la ruta--->"+ruta.size());
			System.out.println("Tiempo de ejecucion--->"+tiempoTotalenMiliSegundos + " ms");
    	}
    	
    	//Una vez ya hemos calculado la ruta a seguir, vamos devolviendo el primer elemento
		//de este, que es la accion a realizar, y lo eliminamos de la cola
	    Types.ACTIONS accion= ruta.pollFirst();
    	return accion;
    };

}