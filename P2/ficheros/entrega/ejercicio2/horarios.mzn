include "globals.mzn";
%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
% DECLARACION DE VARIABLES
% Existe un aula disponible en seis franjas consecutivas de 1h (por ejemplo, de 8:00 a
% 14:00) de lunes a viernes.
% Existen nueve asignaturas (A1..A9). El número de horas semanales de cada asignatura
% se detalla en la siguiente tabla:
%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
% hora de inicio, eliminar valor si queremos que nos pregunte (sigue funcionando)
int : hora_comienzo = 8;
% hora de finalizacion, le sumamos 5 ya que si sumamos 6, tendremos 7 horas, no 6
int : hora_fin = hora_comienzo+5;
% dias de la semana, de lunes a viernes, lo representamos de 1 a 5
set of int : dias_semana = 1..5;
% las horas que vamos a asignar van de hora_comienzo a hora_fin
set of int : horas_clase = 8..13;
% numero de asignaturas del horario
set of int : num_asignaturas = 1..9;
% numero de horas necesarias para cada asignatura, la asignatura i necesita tantas horas
% como marque la posición i
array[num_asignaturas] of 1..4 : horas_necesarias = [4, 2, 4, 4, 4, 2, 2, 2, 1];
% dias de la semana, el objetivo es rellenar estos vectores
% van de 0 a 9, 0 para horas libres, 1..9 para cada asignatura
array[horas_clase] of var 0..9 : lunes;
array[horas_clase] of var 0..9 : martes;
array[horas_clase] of var 0..9 : miercoles;
array[horas_clase] of var 0..9 : jueves;
array[horas_clase] of var 0..9 : viernes;

%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
% RESTRICCIO DE BLOQUES DE ASIGNATURAS 
% Las asignaturas {A1,A3,A4,A5,A8} deben impartirse en bloques de 2h consecutivas,
% mientras que el resto, es decir {A2,A6,A7,A9}, se imparten en bloques de 1h.
% En cada día de la semana solo se puede impartir, como máximo, un bloque de cada
% asignatura.
%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
% en un dia solo se puede impartir un bloque y los bloques de la 2, 6, 7 y 9 son de 1 hora, mientras que los demas de 2
% no contamos los 0, ya que no son asignaturas, son horas libres
% hay dos tipos de asignaturas, las que se imparten en bloques de 1 hora o las que se imparten en bloques de dos horas
constraint forall(i in num_asignaturas)(if i == 2 \/ i == 6 \/ i == 7 \/ i == 9 then count( lunes, i) <= 1 else count( lunes, i) == 2 \/ count( lunes, i) == 0 endif );
constraint forall(i in num_asignaturas)(if i == 2 \/ i == 6 \/ i == 7 \/ i == 9 then count( martes, i) <= 1 else count( martes, i) == 2 \/ count( martes, i) == 0 endif);
constraint forall(i in num_asignaturas)(if i == 2 \/ i == 6 \/ i == 7 \/ i == 9 then count( miercoles, i) <= 1 else count( miercoles, i) == 2 \/ count( miercoles, i) == 0 endif);
constraint forall(i in num_asignaturas)(if i == 2 \/ i == 6 \/ i == 7 \/ i == 9 then count( jueves, i) <= 1 else count( jueves, i) == 2 \/ count( jueves, i) == 0 endif);
constraint forall(i in num_asignaturas)(if i == 2 \/ i == 6 \/ i == 7 \/ i == 9 then count( viernes, i) <= 1 else count( viernes, i) == 2 \/ count( viernes, i) == 0 endif);

% asignaturas que se imparten en blosuqe de dos horas
array[1..5] of var int : bloques_dos_horas = [1, 3, 4, 5, 8];
% si se imparten en dos horas, las horas tienen que ser contiguas
constraint forall(j in 1..5)(forall(i in hora_comienzo+1..hora_fin-1)(if lunes[i] == bloques_dos_horas[j] then lunes[i+1] == bloques_dos_horas[j] \/ lunes[i-1] == bloques_dos_horas[j] endif));
constraint forall(j in 1..5)(forall(i in hora_comienzo+1..hora_fin-1)(if martes[i] == bloques_dos_horas[j] then martes[i+1] == bloques_dos_horas[j] \/ martes[i-1] == bloques_dos_horas[j] endif));
constraint forall(j in 1..5)(forall(i in hora_comienzo+1..hora_fin-1)(if miercoles[i] == bloques_dos_horas[j] then miercoles[i+1] == bloques_dos_horas[j] \/ miercoles[i-1] == bloques_dos_horas[j] endif));
constraint forall(j in 1..5)(forall(i in hora_comienzo+1..hora_fin-1)(if jueves[i] == bloques_dos_horas[j] then jueves[i+1] == bloques_dos_horas[j] \/ jueves[i-1] == bloques_dos_horas[j] endif));
constraint forall(j in 1..5)(forall(i in hora_comienzo+1..hora_fin-1)(if viernes[i] == bloques_dos_horas[j] then viernes[i+1] == bloques_dos_horas[j] \/ viernes[i-1] == bloques_dos_horas[j] endif));


%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
% RESTRICCIONES DE PROFESORES
% El profesor/a de cada asignatura es el siguiente: Prof1={A1,A3}; Prof2={A4,A5};
% Prof3={A6,A9}; Prof4={A2,A7,A8}.
% Cada profesor solo puede impartir un bloque de alguna de sus asignaturas cada día,
% excepto Prof4 (que puede impartir más de una).
%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
% restricciones del profesor 1, si un dia da una clase de A1, no puede dar clase de A3
constraint if count(lunes, 1) != 0 then count(lunes, 3) == 0 endif;
constraint if count(martes, 1) != 0 then count(martes, 3) == 0 endif;
constraint if count(miercoles, 1) != 0 then count(miercoles, 3) == 0 endif;
constraint if count(jueves, 1) != 0 then count(jueves, 3) == 0 endif;
constraint if count(viernes, 1) != 0 then count(viernes, 3) == 0 endif;

constraint if count(lunes, 3) != 0 then count(lunes, 1) == 0 endif;
constraint if count(martes, 3) != 0 then count(martes, 1) == 0 endif;
constraint if count(miercoles, 3) != 0 then count(miercoles, 1) == 0 endif;
constraint if count(jueves, 3) != 0 then count(jueves, 1) == 0 endif;
constraint if count(viernes, 3) != 0 then count(viernes, 1) == 0 endif;
% restricciones del profesor 2, si en un día da clase de la asignatura 4, no puede dar de la 5
constraint if count(lunes, 4) != 0 then count(lunes, 5) == 0 endif;
constraint if count(martes, 4) != 0 then count(martes, 5) == 0 endif;
constraint if count(miercoles, 4) != 0 then count(miercoles, 5) == 0 endif;
constraint if count(jueves, 4) != 0 then count(jueves, 5) == 0 endif;
constraint if count(viernes, 4) != 0 then count(viernes, 5) == 0 endif;

constraint if count(lunes, 5) != 0 then count(lunes, 4) == 0 endif;
constraint if count(martes, 5) != 0 then count(martes, 4) == 0 endif;
constraint if count(miercoles, 5) != 0 then count(miercoles, 4) == 0 endif;
constraint if count(jueves, 5) != 0 then count(jueves, 4) == 0 endif;
constraint if count(viernes, 5) != 0 then count(viernes, 4) == 0 endif;
% restricciones del profesor 3, si un un día da clase de la asignatura 6 no puede dar de la 9
constraint if count(lunes, 6) != 0 then count(lunes, 9) == 0 endif;
constraint if count(martes, 6) != 0 then count(martes, 9) == 0 endif;
constraint if count(miercoles, 6) != 0 then count(miercoles, 9) == 0 endif;
constraint if count(jueves, 6) != 0 then count(jueves, 9) == 0 endif;
constraint if count(viernes, 6) != 0 then count(viernes, 9) == 0 endif;

constraint if count(lunes, 9) != 0 then count(lunes, 6) == 0 endif;
constraint if count(martes, 9) != 0 then count(martes, 6) == 0 endif;
constraint if count(miercoles, 9) != 0 then count(miercoles, 6) == 0 endif;
constraint if count(jueves, 9) != 0 then count(jueves, 6) == 0 endif;
constraint if count(viernes, 9) != 0 then count(viernes, 6) == 0 endif;


%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
% RESTRICCION DEL RECREO
% La cuarta franja horaria debe reservarse para el recreo (“NA”); es decir, no asignar
% ninguna asignatura
%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
% la hora del recreo es la cuarta hora, por lo que la asignamos como libre
constraint lunes[hora_comienzo+3] == 0;
constraint martes[hora_comienzo+3] == 0;
constraint miercoles[hora_comienzo+3] == 0;
constraint jueves[hora_comienzo+3] == 0;
constraint viernes[hora_comienzo+3] == 0;

%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
% Varios profesores tienen ciertas restricciones horarias:
% • El Profesor 1 solo puede dar clase en las dos últimas horas de la mañana.
% • El Profesor 2 solo puede dar clase en las dos primeras horas de la mañana.
% • El Profesor 3 solo puede dar clase en la hora justo antes del recreo.
%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
% Asignaturas del profesor 1 son las asignaturas 1 y 3
constraint ( 1 == lunes[hora_fin-1] /\ 1 == lunes[hora_fin] ) \/ (count(lunes,1)==0);
constraint ( 3 == lunes[hora_fin-1] /\ 3 == lunes[hora_fin] ) \/ (count(lunes,3)==0);
constraint ( 1 == martes[hora_fin-1] /\ 1 == martes[hora_fin] ) \/ (count(martes,1)==0);
constraint ( 3 == martes[hora_fin-1] /\ 3 == martes[hora_fin] ) \/ (count(martes,3)==0);
constraint ( 1 == miercoles[hora_fin-1] /\ 1 == miercoles[hora_fin] ) \/ (count(miercoles,1)==0);
constraint ( 3 == miercoles[hora_fin-1] /\ 3 == miercoles[hora_fin] ) \/ (count(miercoles,3)==0);
constraint ( 1 == jueves[hora_fin-1] /\ 1 == jueves[hora_fin] ) \/ (count(jueves,1)==0);
constraint ( 3 == jueves[hora_fin-1] /\ 3 == jueves[hora_fin] ) \/ (count(jueves,3)==0);
constraint ( 1 == viernes[hora_fin-1] /\ 1 == viernes[hora_fin] ) \/ (count(viernes,1)==0);
constraint ( 3 == viernes[hora_fin-1] /\ 3 == viernes[hora_fin] ) \/ (count(viernes,3)==0);
% Asignaturas del profesor 2 son las asignaturas 4 y 5
constraint ( 4 == lunes[hora_comienzo] /\ 4 == lunes[hora_comienzo+1] ) \/ (count(lunes,4)==0);
constraint ( 5 == lunes[hora_comienzo] /\ 5 == lunes[hora_comienzo+1] ) \/ (count(lunes,5)==0);
constraint ( 4 == martes[hora_comienzo] /\ 4 == martes[hora_comienzo+1] ) \/ (count(martes,4)==0);
constraint ( 5 == martes[hora_comienzo] /\ 5 == martes[hora_comienzo+1] ) \/ (count(martes,5)==0);
constraint ( 4 == miercoles[hora_comienzo] /\ 4 == miercoles[hora_comienzo+1] ) \/ (count(miercoles,4)==0);
constraint ( 5 == miercoles[hora_comienzo] /\ 5 == miercoles[hora_comienzo+1] ) \/ (count(miercoles,5)==0);
constraint ( 4 == jueves[hora_comienzo] /\ 4 == jueves[hora_comienzo+1] ) \/ (count(jueves,4)==0);
constraint ( 5 == jueves[hora_comienzo] /\ 5 == jueves[hora_comienzo+1] ) \/ (count(jueves,5)==0);
constraint ( 4 == viernes[hora_comienzo] /\ 4 == viernes[hora_comienzo+1] ) \/ (count(viernes,4)==0);
constraint ( 5 == viernes[hora_comienzo] /\ 5 == viernes[hora_comienzo+1] ) \/ (count(viernes,5)==0);
% Asignaturas del profesor 3 son las asignaturas 6 y 9
constraint ( 6 == lunes[hora_comienzo+2] ) \/ (count(lunes,6)==0);
constraint ( 9 == lunes[hora_comienzo+2] ) \/ (count(lunes,9)==0);
constraint ( 6 == martes[hora_comienzo+2] ) \/ (count(martes,6)==0);
constraint ( 9 == martes[hora_comienzo+2] ) \/ (count(martes,9)==0);
constraint ( 6 == miercoles[hora_comienzo+2] ) \/ (count(miercoles,6)==0);
constraint ( 9 == miercoles[hora_comienzo+2] ) \/ (count(miercoles,9)==0);
constraint ( 6 == jueves[hora_comienzo+2] ) \/ (count(jueves,6)==0);
constraint ( 9 == jueves[hora_comienzo+2] ) \/ (count(jueves,9)==0);
constraint ( 6 == viernes[hora_comienzo+2] ) \/ (count(viernes,6)==0);
constraint ( 9 == viernes[hora_comienzo+2] ) \/ (count(viernes,9)==0);

%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
% Varias asignaturas también deben ser impartidas ciertos días concretos de la semana:
% • Asignatura 1: lunes o martes
% • Asignatura 3: miércoles o jueves
% • Asignatura 4: lunes o martes
% • Asignatura 5: jueves o viernes
% • Asignatura 6: miércoles o viernes
% • Asignatura 7: martes o viernes
% • Asignatura 8: miércoles
% • Asignatura 9: lunes
%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------

% La asignatura 1 es solo los lunes y los martes
constraint count(lunes, 1) != 0 /\ count(martes, 1) != 0 /\ count(miercoles, 1) == 0 /\ count(jueves, 1) == 0 /\ count(viernes, 1) == 0;
% La asignatura 3 es los miercoles o los jueves
constraint count(lunes, 3) == 0 /\ count(martes, 3) == 0 /\ count(miercoles, 3) != 0 /\ count(jueves, 3) != 0 /\ count(viernes, 3) == 0;
% La asignatura 4 es los lunes y los martes
constraint count(lunes, 4) != 0 /\ count(martes, 4) != 0 /\ count(miercoles, 4) == 0 /\ count(jueves, 4) == 0 /\ count(viernes, 4) == 0;
% La asignatura 5 es los jueves y los viernes
constraint count(lunes, 5) == 0 /\ count(martes, 5) == 0 /\ count(miercoles, 5) == 0 /\ count(jueves, 5) != 0 /\ count(viernes, 5) != 0;
% La asignatura 6 es los miercoles o los viernes
constraint count(lunes, 6) == 0 /\ count(martes, 6) == 0 /\ count(miercoles, 6) != 0 /\ count(jueves, 6) == 0 /\ count(viernes, 6) != 0;
% La asignatura 7 es los martes o los viernes
constraint count(lunes, 7) == 0 /\ count(martes, 7) != 0 /\ count(miercoles, 7) == 0 /\ count(jueves, 7) == 0 /\ count(viernes, 7) != 0;
% La asignatura 8 es los miercoles
constraint count(lunes, 8) == 0 /\ count(martes, 8) == 0 /\ count(miercoles, 8) != 0 /\ count(jueves, 8) == 0 /\ count(viernes, 8) == 0;
% La asignatura 9 es los lunes
constraint count(lunes, 9) != 0 /\ count(martes, 9) == 0 /\ count(miercoles, 9) == 0 /\ count(jueves, 9) == 0 /\ count(viernes, 9) == 0;
% Solo hay una hora libre al dia
constraint count(lunes, 0) == 1 /\ count(martes, 0) == 1 /\ count(miercoles, 0) == 1 /\ count(jueves, 0) == 1 /\ count(viernes, 0) == 1;

solve satisfy;

%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
% DEFINICION DEL OUTPUT
% Muestra el resultado de la solucion con cada vector que almacena las asignaturas de dicho dia
%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
output ["Lunes: \n \t \(lunes) \n"];
output ["Martes: \n \t \(martes) \n"];
output ["Miercoles: \n \t \(miercoles)\n"];
output ["Jueves: \n \t \(jueves)\n"];
output ["Viernes: \n \t \(viernes)\n"];