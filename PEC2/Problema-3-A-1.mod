/* Parametros de la red */
set V;					/* nodos*/
set E, dimen 2;			/*enlaces*/
param cost{E};			/*coste del enlace*/
param capacity{E};		/*capacidad de los enlaces*/
set D;					/*Demandas*/
param h{D};				/*demandas de tráfico*/
param origen{D}, in V;	/*nodo origen por cada demenada*/
param destino{D}, in V;	/*nodo destino por cada demanda*/

/*Variables*/
var x{E, D} binary;		/* flujo de cada enlace */
var y{E} binary;		/*enlaces activos*/

/* Función objetivo*/
minimize ENERGIA: sum{(i,j) in E} y[i,j];

/* restricciones*/
s.t. CONSERVACION_FLUJO{i in V, d in D}:
	sum{(j, i) in E} x[j,i,d] + (if i =origen[d] then 1) =
	sum{(i, j)in E} x[i, j, d] + (if i=destino[d] then 1);
s.t. CAPACIDAD{(i,j) in E}:
	sum{d in D} x[i, j, d] * h[d] <= y[i,j]*capacity[i, j];
	

solve;
/* Solución */
printf "\n\n";printf{1..56} "="; printf "\n";
printf "OBJECTIVE FUNCTION, ENERGIA: %.4f\n\n", ENERGIA;

for {d in D} {
	printf "Demand %d\n", d;
	for {(i,j) in E: x[i,j,d]!=0}
		printf  "		x[%s, %s] =    %d\n", i,j,x[i, j, d];
printf "\n\n";
}
printf "\n\n";printf{1..56} "="; printf "\n";

data;
set V := 1, 2, 3, 4, 5, 6, 7;
param: D: origen destino h :=
1 1 7 10
;
param: E: cost capacity:=
1 2   8   20
1 3   2   20
1 4   4   80
2 5   3   25
2 7   6   35
3 2   7   35
3 5   1   20
3 6   5   25
4 3   5   40
5 6   1   30
5 7   4   30
6 4   4   10
6 7   1   35
;
end;
