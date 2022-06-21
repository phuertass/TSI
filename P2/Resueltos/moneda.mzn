int: amount = 17;
array[1..7] of int: demons = [200,100,50,25,10,5,1];

array[1..7] of var 0..100: counts;

constraint sum(i in 1..7) (counts[i] * demons[i]) = amount;

var int: coins = sum(counts);
solve minimize coins;

output [ 
    "amount = ", show(amount), "\n",
    "coins = ", show(coins), ";\n",
    "counts = ", show(counts), ";\n",
    "demons = ", show(demons), ";\n"
];