package tracks.singlePlayer.evaluacion.src_MARTINEZ_SANCHEZ_JUAN_ANTONIO;

import java.util.ArrayList;


import tools.Vector2d;
import tools.pathfinder.Node;

public class Nodo extends Node{
	
	public boolean visitado;

	public Nodo(Vector2d pos) {
		super(pos);
		visitado = false;
	}
	
	public Nodo(Vector2d pos, Nodo padre) {
		super(pos);
		visitado = false;
		this.parent = padre;
	}
	/*
	public ArrayList<Nodo> getHijos() {
		ArrayList<Nodo> hijos = new ArrayList<Nodo>();
		
	}
	
	private boolean hayObstaculo(int fila, int columna, ArrayList<Observation> grid[][]) {
		if(fila<0 || fila>=grid.length) return true;
        if(columna<0 || columna>=grid[fila].length) return true;

        for(Observation obs : grid[fila][columna])
        {
            if(obstacleItypes.contains(obs.itype))
                return true;
        }

        return false;

	}
*/	

}
