int: NUM_NODES = 4; 
int: NUM_EDGES = 6;
array[1..NUM_EDGES,1..2] of int: edges = [|
0, 1|    
1, 2|      
1, 3|];

% Decision Variable: the solver will find the values of these
array[0..NUM_NODES-1] of var 1..NUM_NODES: color;

% Our Constraints 
constraint forall(e in 1..NUM_EDGES)(color[edges[e,1]] != color[edges[e,2]]);

% Our Objective Function
solve minimize max(color);

% formatted output
output[show(color)];