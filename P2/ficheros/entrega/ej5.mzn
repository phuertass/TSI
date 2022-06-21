include "globals.mzn";
%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
% DECLARACION DE VARIABLES
%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
int: n; % Numero de nodos
int: m; % Numero de aristas
% Array 2D, que almacena las aristas del grafo
array[1..m,1..2] of int: E; 
% Dominio de los colores a usar para limitar el espacio de búsqueda
int: maxcolor = m;

% Color de la arista m
array[1..m] of var 1..maxcolor: c; 

% Matriz que almacena los colores de cada arista
% Si la arista no existe dicho valor no se considera
set of int: Rango = 1..n;
array[Rango, Rango] of var 0..maxcolor: colores;

% El primer nodo tiene color 1
%constraint c[1] == 1;

% La diagonal de la matriz de colores es vacía, ya que no hay 
% aristas que conecten el mismo nodo
constraint forall(i in 1..n) (colores[i,i] == 0);

% Para cada arista de los datos, en la posición [i,j] y [j,i] de la matriz, se almacena el color de la arista
% que une los nodos i y j y viceversa
constraint forall(i in 1..m)(colores[ E[i,1],E[i,2] ] == c[i] /\ colores[ E[i,2],E[i,1] ] == c[i]);

% Los valores de cada fila y cada columna deben ser diferentes entre sí
constraint forall(i in 1..n)(alldifferent ([colores[i,j] | j in 1..n]));
constraint forall(j in 1..n)(alldifferent ([colores[i,j] | i in 1..n]));

solve minimize(max(c));


%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
% DEFINICION DEL OUTPUT
% Muestra el conjunto de aristas que se han leido del dataset, la matriz de colores que ha sido
% generada y el valor de la función objetivo, es decir, el maximo de colores usados
%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
%output ["\nAristas-->\n"];
%output["\(E[i,1]), \(E[i,2]) | " | i in 1..m];
%
%output["\n\n"];
%
%output [ "Matriz colores-->\n"];
%output["\(colores[i,j]) "++
% if i == n then "\n" else "" endif | j,i in 1..n];

output["\n"];
output["Maximo de colores--> ", show(max(c))];
