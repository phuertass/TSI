package tracks.singlePlayer.evaluacion.src_MARTINEZ_SANCHEZ_JUAN_ANTONIO;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

import tools.pathfinder.Node;
import tools.pathfinder.PathFinder;

public class BFS {

	public static Queue<Nodo> Q;
	public PathFinder pathfinder;
	
	
	public BFS(PathFinder pathfinder) {
		this.pathfinder = pathfinder;
	}
	
	private ArrayList<Nodo> calcularPath(Nodo nodo) {
		ArrayList<Nodo> path = new ArrayList<Nodo>();
		while(nodo != null) {
			if(nodo.parent != null) {
				nodo.setMoveDir(nodo.parent);
				path.add(0, nodo);
			}
			nodo = (Nodo) nodo.parent;
		}
		return path;
	}
	
	
	public ArrayList<Nodo> Anchura(Nodo inicial, Nodo objetivo) {
		
        Q = new LinkedList<>();
        
        Q.add(inicial);
        
        while(!Q.isEmpty()) {
        	Nodo current = Q.poll();
        	current.visitado = true;
        	
        	if(current.position.equals(objetivo.position)) {
        		return calcularPath(current);
        	}
        	
        	ArrayList<Node> hijos = pathfinder.getNeighbours((Node) current);
        	for(int i=0; i<hijos.size(); i++) {
        		Nodo hijo = (Nodo) hijos.get(i);
        		if(hijo.visitado == false) {
        			hijo.visitado = true;
        			hijo.parent = current;
        			Q.add(hijo);
        		}
        	}
        }
        
        if(!inicial.position.equals(objetivo.position))
            return null;

        return calcularPath(inicial);
		
		
	}
	
	
}
