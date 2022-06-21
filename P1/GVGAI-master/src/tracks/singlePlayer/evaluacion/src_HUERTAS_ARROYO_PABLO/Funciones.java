package tracks.singlePlayer.evaluacion.src_HUERTAS_ARROYO_PABLO;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedList;

import core.game.Observation;
import core.game.StateObservation;
import ontology.Types;
import ontology.Types.ACTIONS;
import tools.Vector2d;

public class Funciones {
    //Objeto de la clase Comparator que nos va a servir como criterio
    //de comparacion en las colas con prioridad de los algoritmos de A*, IDA* y RTA*
    private static Comparator com;

    //Vectores usados para la generacion de hijos
    private static int[] x_arrNeig = null;
    private static int[] y_arrNeig = null;

    //ArrayList que contiene los indices de los obstaculos del mapa
    static public ArrayList<Integer> obstacleItypes;

    //ArrayList que contiene el grid del mapa
    static public ArrayList<Observation> grid[][];

    //Objeto de la clase StateObservation
    StateObservation state;
    

    //Constructor de la clase Funciones
    public Funciones(StateObservation stateObs){
        this.state = stateObs;
        this.grid = stateObs.getObservationGrid();

        obstacleItypes = new ArrayList<>();
		obstacleItypes.add(0);
		obstacleItypes.add(4);

        //El criterio de comparacion sera el de la funcion g(n)+h(n)
        com = new Comparator<Nodo>(){
			public int compare(Nodo a, Nodo b)
			{
				if (a.totalCost+a.estimatedCost>b.totalCost+b.estimatedCost)
					return 1;
				else
					return -1;
			}
		};

        init();
    }

    int[] GetXArrNeig()
    {
        return x_arrNeig;
    }

    int[] GetYArrNeig()
    {
        return y_arrNeig;
    }

    //Inicializamos los vectores de generacion de hijos, para que se expandan en el orden
    //de arriba, abajo, izquierda, derecha
    //Esta funcion ha sido reutilizada de la clase PathFinder
    private void init()
    {
        if(x_arrNeig == null)
        {
            ArrayList<Types.ACTIONS> actions = this.state.getAvailableActions();
            if(actions.size() == 3)
            {
                //left, right
                x_arrNeig = new int[]{-1, 1};
                y_arrNeig = new int[]{0,  0};
            }else
            {
                //up, down, left, right
                x_arrNeig = new int[]{0,    0,    -1,    1};
                y_arrNeig = new int[]{-1,   1,     0,    0};
            }
        }
    }

    //Funcion que devuelve true si la casilla pasada por parametro
    //es un obstaculo de los definidos en el arrayList obstacleItypes
    //Esta funcion ha sido reutilizada de la clase PathFinder
    public boolean isObstacle(int row, int col)
    {
        if(row<0 || row>=grid.length) return true;
        if(col<0 || col>=grid[row].length) return true;

        for(Observation obs : grid[row][col])
        {
            if(obstacleItypes.contains(obs.itype))
                return true;
        }

        return false;
    }

    //Funcion generadora de hijos
    //Genera los hijos en el correcto orden, si no son obstaculos
    //Esta funcion ha sido reutilizada de la clase PathFinder
    public ArrayList<Nodo> getNeighbours(Nodo Nodo) {
        ArrayList<Nodo> neighbours = new ArrayList<Nodo>();
        int x = (int) (Nodo.position.x);
        int y = (int) (Nodo.position.y);

        for(int i = 0; i < x_arrNeig.length; ++i)
        {
            if(!isObstacle(x+x_arrNeig[i], y+y_arrNeig[i]))
            {
                neighbours.add(new Nodo(new Vector2d(x+x_arrNeig[i], y+y_arrNeig[i])));
            }
        }

        return neighbours;
    }

    //Heuristica utilizada en los algoritmos
    //Distancia manhattan entre el nodo actual y el nodo objetivo
    static public double DistanciaManhattan(Nodo actual, Nodo objetivo)
    {
    	double Diffx = Math.abs(actual.position.x - objetivo.position.x);
    	double Diffy = Math.abs(actual.position.y - objetivo.position.y);
    	
    	return Diffx+Diffy;

    }
	
    //Funcion que calcula el camino de nodos que se han de seguir desde 
    //los antecesores del nodo pasado como parametro hasta el nodo pasado por parametro
    //El ultimo padre del nodo pasado deberá ser el nodo inicial del algoritmo de busqueda
    //ya que todos los nodos serán sucesores suyos
    //Esta funcion ha sido reutilizada de la clase PathFinder
	static ArrayList<Nodo> calcularPath(Nodo nodo) {
		ArrayList<Nodo> ruta = new ArrayList<>();
		while(nodo != null) {
			if(nodo.parent != null) {
				nodo.setMoveDir(nodo.parent);
				ruta.add(0, nodo);
			}
			nodo = (Nodo) nodo.parent;
		}
		return ruta;
	}

    //Getter del objeto com de la clase Comparator
    public static Comparator GetCom(){
        return com;
    }

    static LinkedList<Types.ACTIONS> CalculoRuta(ArrayList<Nodo> camino, Nodo inicial){ 
        //Una vez obtenido el camino, que es una secuencia de nodos, 
        //calculamos a partir del nodo objetivo conseguido el camino
        //que se ha recorrido para llegar al objetivo
        LinkedList<ACTIONS> ruta = new LinkedList<>();

        int tamanio_camino = camino.size();

        for(int contador=0; contador<=tamanio_camino-1; contador++){
            Nodo n = camino.get(contador);
            if(inicial.position.y>n.position.y)
                ruta.addLast(ACTIONS.ACTION_UP);
            else if(inicial.position.y<n.position.y)
                ruta.addLast(ACTIONS.ACTION_DOWN);
            else if(inicial.position.x>n.position.x)
                ruta.addLast(ACTIONS.ACTION_LEFT);
            else if(inicial.position.x<n.position.x)
                ruta.addLast(ACTIONS.ACTION_RIGHT);
            inicial = n;
        }

        return ruta;
    }
    
}
