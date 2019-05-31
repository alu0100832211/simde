26
	ADDI R32 R0 #-1
	ADDI R33 R0 #1 

// CONTAR 
CONTAR:
	LW R31 0(R30)
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
	BEQ R30 R35 FINISH

	// Cogemos elemento[p]
	LW R37 0(R36)

	// Terminar si v == elemento[p]
	BEQ R34 R37 FINISH

	// Condicionales entre v y el elemento en p
	BGT R34 R37 IFGREATER

	SRLV R30 R36 R33
	ADDI R30 R30 #-1
	BEQ R0 R0 BUSQUEDA

IFGREATER:
	SRLV R35 R36 R33
	ADDI R35 R35 #1
	BEQ R0 R0 BUSQUEDA

FINISH:
	LF F3 1(R36)
