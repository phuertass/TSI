package tracks.singlePlayer.evaluacion.src_HUERTAS_ARROYO_PABLO;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.LinkedList;

import core.game.Observation;
import core.game.StateObservation;
import ontology.Types;
import ontology.Types.ACTIONS;
import tools.ElapsedCpuTimer;
import tools.Vector2d;

import core.player.AbstractPlayer;

public class AgenteRTAStar extends AbstractPlayer {
    private Vector2d fescala;
    private Vector2d portal;
	Vector2d pos_ini;
    Nodo inicial;
    Nodo objetivo;
	Nodo actual;

    private ArrayList<Nodo> camino;
    private LinkedList<ACTIONS> ruta;

    long tiempoTotalenMiliSegundos=0;

	Hashtable<String, Double> tablero;
	Funciones funcs;

    
    
	//Variable que permite llamar al metodo para buscar el camino una unica vez
	//en "act"
    boolean primeravez=true;
    
    /**
     * Public constructor with state observation and time due.
     *
     * @param stateObs     state observation of the current game.
     * @param elapsedTimer Timer for the controller creation.
     */
    public AgenteRTAStar(StateObservation stateObs, ElapsedCpuTimer elapsedTimer){
		
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
		actual = inicial;
		
		//Inicializacion de los objetos de la clase Busqueda de A*, y la ruta que
		//se devolvera
	    ruta = new LinkedList<Types.ACTIONS>();
		tablero = new Hashtable<String, Double>();
		funcs = new Funciones(stateObs);
    }
    	
    	
    @Override
    public Types.ACTIONS act(StateObservation stateObs, ElapsedCpuTimer elapsedTimer) {
		actual.estimatedCost = Funciones.DistanciaManhattan(actual, objetivo);
		tablero.put(actual.position.toString(), actual.estimatedCost);

		// Debo generar todos los hijos posibles del nodo actual, y me muevo al que menor
		// heuristica tenga
		ArrayList<Nodo> hijos = funcs.getNeighbours(actual);
		for(int i=0; i<hijos.size(); i++){
			Nodo hijo = hijos.get(i);
			if(!tablero.containsKey(hijo.position.toString())){
				hijo.estimatedCost = Funciones.DistanciaManhattan(hijo, objetivo);
				tablero.put(hijo.position.toString(), hijo.estimatedCost);
			}
		}

		Types.ACTIONS accion = null;
    	return accion;
    };

}