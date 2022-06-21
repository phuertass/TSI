int: cantidad = 499;
array[1..8] of int: centimos = [200,100,50,20,10,5,2,1];

array[1..8] of var 0..1000: contador;

constraint if cantidad>200 then contador[1]>=1 else 
if cantidad>100 then contador[2]>=1 endif endif;

constraint sum(i in 1..8) (contador[i] * centimos[i]) = cantidad;

var int: monedas = sum(contador);
solve minimize monedas;

output [ 
    "cantidad = ", show(cantidad), "\n",
    "monedas = ", show(monedas), ";\n",
    "contador = ", show(contador), ";\n",
    "centimos = ", show(centimos), ";\n"
];
