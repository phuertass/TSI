include "globals.mzn";
% Cinco personas de cinco regiones diferentes viven en las primeras cinco
% casas contiguas de una calle. Practican cinco profesiones distintas, y cada uno tiene un animal y
% una bebida favoritos, todos ello diferentes. Las casas están pintadas con diferentes colores.
% Ademas sabemos lo siguiente:
% a. El vasco vive en la casa roja.
% b. El catalán tiene un perro.
% c. El gallego es un pintor.
% d. El navarro bebe te.
% e. El andaluz vive en la primera casa de la izquierda.
% f. El de la casa verde bebe café.
% g. La casa verde está al lado de la blanca y a su derecha.
% h. El escultor cría caracoles.
% i. El diplomático vive en la casa amarilla.
% j. En la casa central se bebe leche.
% k. La casa del andaluz está al lado de la azul.
% l. El violinista bebe zumo.
% m. El zorro está en una casa al lado de la del médico.
% n. El caballo está en una casa al lado de la del diplomático.
% Resolver el problema de forma que podamos responder: ¿dónde está la cebra y quién bebe
% agua?

%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
% DECLARACION DE VARIABLES
%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
array[1..5] of var 1..5: casa;
array[1..5] of var 1..5: color;
array[1..5] of var 1..5: profesion;
array[1..5] of var 1..5: nacionalidad;
array[1..5] of var 1..5: bebida;
array[1..5] of var 1..5: animal;

array[1..5] of string: strCasa = ["Primera", "Segunda", "Tercera", "Cuarta", "Quinta"];
array[1..5] of string: strColor = ["Rojo", "Verde", "Blanco", "Amarillo", "Azul"];
array[1..5] of string: strProfesion = ["Pintor", "Escultor", "Diplomatico", "Violinista", "Medico"];
array[1..5] of string: strNacionalidad = ["Vasco", "Catalan", "Gallego", "Navarro", "Andaluz"];
array[1..5] of string: strBebida = ["Te", "Cafe", "Leche", "Zumo", "Agua"];
array[1..5] of string: strAnimal = ["Perro", "Caracoles", "Zorro", "Caballo", "Cebra"];

%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
% RESTRICCIONES
%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
% Lo primero que hacemos es condicionar que los arrays de casa, color, profesion, nacionalidad,
% bebida y animal no tengan ningun elemento repetido.
constraint alldifferent(casa);
constraint alldifferent(color);
constraint alldifferent(profesion);
constraint alldifferent(nacionalidad);
constraint alldifferent(bebida);
constraint alldifferent(animal);

% Nos han dado 14 datos que tenemos que conocer para resolver el problema.

% El vasco vive en la casa roja.
constraint (nacionalidad[1] == color[1]);
% El catalán tiene un perro.
constraint (nacionalidad[2] == animal[1]);
% El gallego es un pintor.
constraint (nacionalidad[3] == profesion[1]);
% El navarro bebe te.
constraint (nacionalidad[4] == bebida[1]);
% El andaluz vive en la primera casa de la izquierda.
constraint (nacionalidad[5] == casa[1]);
% El de la casa verde bebe café.
constraint (color[2] == bebida[2]);
% La casa verde está al lado de la blanca y a su derecha.
% Recorro todos los posibles valores que puede tomar el color, y cuando coincide que 
% los colores en la iteracion i-esima son el verde y el blanco, entonces la casa verde está
% a la derecha de la casa blanca, es decir, una posicion superior en el array de casa
constraint forall(i,j in 1..5)(if (i == color[2] /\ j == color[3] ) 
then ((j == casa[1] /\ i == casa[2]) \/ (j == casa[2] /\ i == casa[3]) \/ 
(j == casa[3] /\ i == casa[4]) \/ (j == casa[4] /\ i == casa[5])) endif);
% El escultor cría caracoles.           
constraint (profesion[2] == animal[2]);
% El diplomático vive en la casa amarilla.
constraint (profesion[3] == color[4]);
% En la casa central se bebe leche.
constraint (casa[3] == bebida[3]);
% La casa del andaluz está al lado de la azul.
constraint forall(i,j in 1..5)(if (i == nacionalidad[5] /\ j == color[5])
 then (((i == casa[1] /\ j == casa[2]) \/ (j == casa[1] /\ i == casa[2])) 
 \/ ((i == casa[2] /\ j == casa[3]) \/ (j == casa[2] /\ i == casa[3])) \/
 ((i == casa[3] /\ j == casa[4]) \/ (j == casa[3] /\ i == casa[4])) \/ 
 ((i == casa[4] /\ j == casa[5]) \/ (j == casa[4] /\ i == casa[5]))) endif);
                  
% El violinista bebe zumo.                  
constraint (profesion[4] == bebida[4]);

% El zorro está en una casa al lado de la del médico.
constraint forall(i,j in 1..5)(if (i == animal[3] /\ j == profesion[5]) then 
(((i == casa[1] /\ j == casa[2]) \/ (j == casa[1] /\ i == casa[2])) \/ 
((i == casa[2] /\ j == casa[3]) \/ (j == casa[2] /\ i == casa[3])) \/ 
((i == casa[3] /\ j == casa[4]) \/ (j == casa[3] /\ i == casa[4])) \/ 
((i == casa[4] /\ j == casa[5]) \/ (j == casa[4] /\ i == casa[5]))) endif);

% El caballo está en una casa al lado de la del diplomático.
constraint forall(i,j in 1..5)(if (i == animal[4] /\ j == profesion[3]) then 
(((i == casa[1] /\ j == casa[2]) \/ (j == casa[1] /\ i == casa[2])) \/ 
((i == casa[2] /\ j == casa[3]) \/ (j == casa[2] /\ i == casa[3])) \/ 
((i == casa[3] /\ j == casa[4]) \/ (j == casa[3] /\ i == casa[4])) \/ 
((i == casa[4] /\ j == casa[5]) \/ (j == casa[4] /\ i == casa[5]))) endif);


solve satisfy;
%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
% OUTPUT
% Mostramos los resultados obtenidos
% Vease que la posicion i-esima de los correspondientes arrays que declaran los datos del problema
% deben ser igual a la posicion i-esima del array que completa la asociacion
%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
output ["Profesion:\t"];
output ["\(strProfesion[i]) = Persona \(profesion[i])\t" | i in 1..5];
output ["\n"];
output ["Nacionalidad:\t"];
output ["\(strNacionalidad[i]) = Persona \(nacionalidad[i])\t" | i in 1..5];
output ["\n"];
output ["Casa:\t\t"];
output ["\(strCasa[i]) = Persona \(casa[i])\t" | i in 1..5];
output ["\n"];
output ["Color:\t\t"];
output ["\(strColor[i]) = Persona \(color[i])\t" | i in 1..5];
output ["\n"];
output ["Animal:\t\t"];
output ["\(strAnimal[i]) = Persona \(animal[i])\t" | i in 1..5];
output ["\n"];
output ["Bebida:\t\t"];
output ["\(strBebida[i]) = Persona \(bebida[i])\t" | i in 1..5];
output ["\n"];