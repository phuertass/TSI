int: cantidad = 499;
array[1..7] of int: centimos = [200,100,50,25,10,5,1];

array[1..7] of var 0..1000000: contador;

constraint sum(i in 1..7) (contador[i] * centimos[i]) = cantidad;

var int: monedas = sum(contador);
solve minimize monedas;

output [ 
    "cantidad = ", show(cantidad), "\n",
    "monedas = ", show(monedas), ";\n",
    "contador = ", show(contador), ";\n",
    "centimos = ", show(centimos), ";\n"
];