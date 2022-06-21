package tracks.singlePlayer.evaluacion.src_MARTINEZ_SANCHEZ_JUAN_ANTONIO;


import java.util.ArrayList;
import java.util.*;

import core.game.Observation;
import core.game.StateObservation;
import core.player.AbstractPlayer;
import ontology.Types;
import ontology.Types.ACTIONS;
import tools.ElapsedCpuTimer;
import tools.Vector2d;
import tools.pathfinder.Node;
import tools.pathfinder.PathFinder;


public class AgenteBFS extends AbstractPlayer{

	private Vector2d fescala;
	private Vector2d portal;
	
	private ArrayList<Nodo> ruta;
	private ArrayList<ACTIONS> acciones;
	
	private ElapsedCpuTimer timer;
	
	 
	public AgenteBFS(StateObservation stateObs, ElapsedCpuTimer elapsedTimer) {
		
		fescala = new Vector2d(stateObs.getWorldDimension().width / stateObs.getObservationGrid().length,
				stateObs.getWorldDimension().getHeight() / stateObs.getObservationGrid()[0].length);
		
		ArrayList<Observation>[] posiciones = stateObs.getPortalsPositions(stateObs.getAvatarPosition());
		
		portal = posiciones[0].get(0).position;
		portal.x = Math.floor(portal.x / fescala.x);
		portal.y = Math.floor(portal.y / fescala.y);
	
	}
	
	
	@Override
    public Types.ACTIONS act(StateObservation stateObs, ElapsedCpuTimer elapsedTimer) {
        Vector2d pos_ini = new Vector2d(stateObs.getAvatarPosition().x / 
        		fescala.x, stateObs.getAvatarPosition().y / fescala.y);
        
        Nodo inicial = new Nodo(pos_ini);
        Nodo objetivo = new Nodo(portal);

        ArrayList<Integer> obstacleItypes = new ArrayList<>();
        obstacleItypes.add(0); // muros
        obstacleItypes.add(7); // piedras
        PathFinder pathfinder = new PathFinder(obstacleItypes);
        
        BFS bfs = new BFS(pathfinder);
        
        
        ruta = bfs.Anchura(inicial, objetivo);
        
        for(int i=0; i<ruta.size(); i++) {
        	System.out.println(ruta.get(i));
        	System.out.println(" ");
        }
        
        return Types.ACTIONS.ACTION_DOWN;
    }
	
	
	
	
	
	
	
}
