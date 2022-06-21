include "globals.mzn";

% Array con 10 posiciones con números del 0 al 20
set of int :VALUES= 0..10;
set of int: POS = 1..10;

set of int :Tipos_monedas = {0,1,2,5,10,20,50,100,200};

array[1..100] of var Tipos_monedas: solucion;


% All different:

constraint sum(solucion) == 498;
 
output [ "\(solucion[p]) " | p in POS ]

