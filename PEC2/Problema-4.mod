/* Parametros de la red */
set I;					/* posibles intalaciones de red*/
set J;					/*conjunto de ususarios a cubrir*/
param inv{I}; /* inversion de utilizar una instalación de red*/
param c{I, J}, >=0; /*ganacia de usar una instalacion i que cuabra a un conjunto j de usuarios */

/*Variables*/
var x{I,J}, binary;		/* flujo de cada enlace */
var y{I}, binary;		/*enlaces activos*/

/* Función objetivo*/
maximize FOBJETIVO: sum{i in I, j in J} c[i,j]*x[i,j] - sum{i in I} inv[i]*y[i];
/* restricciones*/
s.t. RESTRIC1{j in J}:
	sum{i in I} x[i, j] = 1;
s.t. RESTRIC2{i in I, j in J}:
	x[i, j] <= y[i];

solve;
/* Solucion */
printf "\n";printf{1..56} "="; printf "\n";
printf "OBJECTIVE FUNCTION, FOBJETIVO: %.4f\n\n", FOBJETIVO;
printf "C.Usuarios  Instalaciones  Ganancia   Inversion\n\n";
printf{j in J} "  %5d        %5d   %10g   %10g\n", j, sum{i in I} i *x[i,j],
   sum{i in I} c[i,j] * x[i,j], sum{i in I} x[i,j]*inv[i];
printf "\n";printf{1..56} "="; printf "\n";
/* Datos */
data;
set J:= 1, 2, 3, 4, 5, 6, 7, 8, 9, 10;
param: I: inv:=
1 45.197
2 134.958
3 11.179
4 294.689
;
param c := [*,*]: 1 2 3 4 5 6 7 8 9 10:=
1 381.68 171.82 210.08 311.53 136.24 892.86 153.85 130.55 136.43 275.48
2 144.72 510.20 109.29 135.50 216.45 140.45 917.43 526.32 303.95 101.21
3 315.46 377.36 168.92 259.74 195.31 348.43 306.75 216.92 215.05 168.07
4 125.79 294.12 169.20 115.47 3030.30 138.12 239.81 348.43 714.29 133.51
;
end;