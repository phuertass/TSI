% Ejemplo: N-Reinas:
include "globals.mzn";
int: n;
array [1..n] of var 1..n: reinas;
% Ataques en misma fila: no hay (cada reina ya está en filas
%distintas gracias al modelado del problema)
constraint alldifferent(reinas);
% Ataques en columnas
constraint alldifferent([reinas[i] - i | i in 1..n]); % Ataques en diag. princ.
constraint alldifferent([reinas[i] + i | i in 1..n]); % Ataques en diag. sec.
solve satisfy;
output [ if fix(reinas[j]) == i then "Q" else "." endif ++
if j == n then "\n" else "" endif | i,j in 1..n];