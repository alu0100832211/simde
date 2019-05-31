35
	ADDI R32 R0 #-1
	ADDI R33 R0 #1 

// bbin_seq | Busca factores para las etiquetas a partir de la 
// dirección de memoria 90, y guarda los resultados en orden en la 100
// Utilizar con la memoria sensores_seq.mem

// CONTAR 
CONTAR:
	LW R31 0(R29)
	ADDI R29 R29 #2
	BNE R31 R32 CONTAR

	// GUARDAR EN R29 N ELEMENTOS
	ADDI R29 R29 #-2
	SRLV R29 R29 R33
	ADDI R29 R29 #-1

// R28: Posición del sensor a buscar/guardar

MAIN:
	BEQ R34 R32 FINISH
	// while carga de memoria != -1
	// Cargar de memoria el sensor a buscar
	LW R34 90(R28)
	// buscar
	BEQ R0 R0 FBUSQUEDA
BUSQUEDARET:
	// incrementar 
	ADDI R28 R28 #1
	BEQ R0 R0 MAIN

// R35: i (tope izquierdo)
// R30: n (tope derecho)
// R34: v (sensor a buscar)
// R36: p (posición del elemento)
// R37: elemento
// R38: 2i

FBUSQUEDA:
	// Carga de registros
	ADDI R35 R0 #0
	ADDI R30 R29 #0

BUSQUEDA:
	// p = (n - i + 1) / 2 * 2 + (2 * i)
	SUB R36 R30 R35
	ADDI R36 R36 #1
	SRLV R36 R36 R33
	SLLV R36 R36 R33

	SLLV R38 R35 R33
	ADD R36 R36 R38

	// Terminar si i == n
	BEQ R30 R35 BUSQUEDAFINISH

	// Cogemos elemento[p]
	LW R37 0(R36)

	// Terminar si v == elemento[p]
	BEQ R34 R37 BUSQUEDAFINISH

	// Condicionales entre v y el elemento en p
	BGT R34 R37 IFGREATER

	SRLV R30 R36 R33
	ADDI R30 R30 #-1
	BEQ R0 R0 BUSQUEDA

IFGREATER:
	SRLV R35 R36 R33
	ADDI R35 R35 #1
	BEQ R0 R0 BUSQUEDA

BUSQUEDAFINISH:
	LF F3 1(R36)
	SF F3 100(R28)
	BEQ R0 R0 BUSQUEDARET

FINISH:
	ADDI R0 R0 #0
