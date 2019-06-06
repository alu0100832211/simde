26
	ADDI R32 R0 #-1
	ADDI R33 R0 #1 

//Lee un valor, suma 2 a R30 y lee la posicion 0(R30) con el siguiente valor
// Cuando encuentra el -1 no carga el siguiente valor, resta 2 a R30 y lo divide por 2 (desplazando 1 bit a laderecha)
// Esto se hace una única vez
CONTAR:  // se puede suponer que se tiene el nº de elementos
	LW R31 0(R30) //Cargar primer valor
	ADDI R30 R30 #2
	BNE R31 R32 CONTAR

	// GUARDAR EN R30 N ELEMENTOS
	ADDI R30 R30 #-2
	SRLV R30 R30 R33
	ADDI R30 R30 #-1

// R35: i (tope izquierdo)
// R30: n (tope derecho)
// R34: v (sensor a buscar)
// R36: p (posición del elemento)
// R37: elemento
// R38: 2i
	LW R34 40(R0) // Cogemos sensor a buscar (en este caso, 4)

BUSQUEDA:
	// p = (n - i + 1) / 2 * 2 + (2 * i)
	SUB R36 R30 R35
	ADDI R36 R36 #1
	SRLV R36 R36 R33
	SLLV R36 R36 R33

	SLLV R38 R35 R33
	ADD R36 R36 R38

	// Terminar si i == n
	BEQ R30 R35 FINISHBUSQUEDA

	// Cogemos elemento[p]
	LW R37 0(R36)

	// Terminar si v == elemento[p]
	BEQ R34 R37 FINISHBUSQUEDA

	// Condicionales entre v y el elemento en p
	BGT R34 R37 IFGREATER // si v > p

	SRLV R30 R36 R33
	ADDI R30 R30 #-1
	BEQ R0 R0 BUSQUEDA

IFGREATER:
	SRLV R35 R36 R33
	ADDI R35 R35 #1
	BEQ R0 R0 BUSQUEDA

FINISHBUSQUEDA:
	LF F3 1(R36)
