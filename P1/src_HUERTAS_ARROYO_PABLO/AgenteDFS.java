package tracks.singlePlayer.evaluacion.src_HUERTAS_ARROYO_PABLO;
import core.game.Observation;
import core.game.StateObservation;
import java.util.ArrayList;
import java.util.LinkedList;

import core.player.AbstractPlayer;
import ontology.Types;
import ontology.Types.ACTIONS;
import tools.ElapsedCpuTimer;
import tools.Vector2d;

public class AgenteDFS extends AbstractPlayer {
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
    
    BusquedaProfundidad BusquedaDFS;
    //Variable para realizar la búsqueda una vez solamente
    boolean primeravez=true;
    
    /**
     * Public constructor with state observation and time due.
     *
     * @param stateObs     state observation of the current game.
     * @param elapsedTimer Timer for the controller creation.
     */
    public AgenteDFS(StateObservation stateObs, ElapsedCpuTimer elapsedTimer){
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
        
	    //Inicializo el objeto de la clase de Busqueda en Profundidad
		BusquedaDFS = new BusquedaProfundidad(stateObs);
    }	

    @Override
    public Types.ACTIONS act(StateObservation stateObs, ElapsedCpuTimer elapsedTimer) {
    	if(primeravez)
    	{        

			//Una vez que entre en este if, no volverá a entrar más
            primeravez = false;
			
			//Calculo de tiempos
			long tInicio = System.nanoTime();
			//Búsqueda del camino de nodos a seguir
    	    camino = BusquedaDFS.DFS(inicial, objetivo);
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
			System.out.println("Numero de nodos expandidos->"+BusquedaDFS.GetNodosExpandidos());
			System.out.println("Maximo de nodos en memorias->"+BusquedaDFS.GetMaxNodosMemoria());
			System.out.println("Tamaño de la ruta->"+ruta.size());
			System.out.println("Tiempo de ejecucion-> "+tiempoTotalenMiliSegundos+" ms");
			
    	}
    		
    	
        //Cogemos la primera posición de la ruta calculada y la devolvemos
	    Types.ACTIONS accion= ruta.pollFirst();
    	return accion;
    }
}
    
