% Ejemplo: Sudoku
include "globals.mzn";
int: S = 4; int: N = S * S;
set of int: RangoPuzzle = 1..N; set of int: RangoCuadrado = 1..S;
array[RangoPuzzle, RangoPuzzle] of var RangoPuzzle: puzzle;
% Todos diferentes por filas
constraint forall (i in RangoPuzzle)
( alldifferent( [ puzzle[i,j] | j in RangoPuzzle ]) );
% Todos diferents por columnas
constraint forall (j in RangoPuzzle)
( alldifferent( [ puzzle[i,j] | i in RangoPuzzle ]) );
% (continua en la siguiente diapositiva…)
% int: S = 3; int: N = S * S;
% set of int: RangoPuzzle = 1..N; set of int: RangoCuadrado = 1..S;
%Todos diferentes en cada cuadrado
constraint forall (a, o in RangoCuadrado)
( alldifferent( [ puzzle[S*(a-1)+x , S*(o-1)+y]
| x, y in RangoCuadrado ] ) );
solve satisfy;
output [ "\(puzzle[i,j]) " ++
if i == N then "\n" else "" endif | j,i in 1..N];