45
// Recorre los valores y los suma en un registro indexado por el numero de sensor
// R1 : Id Sensor
// R2 : Iterador general
// R3 : Numero de Elementos
// R21 : -1
// R22: valor id del recorrido cuando se busca el id
// R23: iterador de la busqueda
// R28: usado
// R29: usado
// F1 : Valor actual Sensor
// F2 : Acumulador Sensor
// F3 : factor multiplicador
// While R1 != -1
	ADDI R32 R0 #-1
	ADDI R33 R0 #1 
  ADDI R29 R0 #5
//CONTAR: //Contar número de sensores
//	LW R31 0(R29)
//	ADDI R29 R29 #2
//	BNE R31 R32 CONTAR
//
//	// GUARDAR EN R29 N ELEMENTOS
//	ADDI R29 R29 #-2
//	SRLV R29 R29 R33
//	ADDI R29 R29 #-1

ADDI R21 R0 #-1
LOOP: //Recorrer datos hasta leer -1
    ADDF F2 F0 F0 //poner acumulador a 0
    LW R1 40(R2) //leer id
    BEQ R1 R21 FINAL //si R1 == -1 salir
    ADDI R2 R2 #1 //siguiente elemento
    LW R3 40(R2) //leer n
    ADDI R2 R2 #1 //siguiente elemento
    LOOPV: //para n..1
        LF F1 40(R2) //Primer valor
        ADDI R2 R2 #1 //siguiente iterador
        LW R4 40(R2) //Leer variable aplicar factor
        ADDI R2 R2 #1 //siguiente iterador
        BEQ R0 R4 NOMULTIPLICAR  //si variable condicion falsa, no multiplicar
        BEQ R0 R0 FBUSQUEDA //Compara factor leido con R1 y coloca en F3 factor buscado
        BUSQUEDARET: //llamada a busqueda
        ADD R0 R0 R0    //llamada a busqueda
        MULTF F1, F1, F3  //multiplicar el valor por el factor
        NOMULTIPLICAR:
        ADDF F2 F2 F1 //Acumular valor
        ADD R3 R3 R21 //n--
        BNE R3 R0 LOOPV //volver al bucle si n!=0
    SF F2 20(R1)
    BEQ R0 R0 LOOP
// R22: valor id del recorrido cuando se busca el id
// R23: iterador de la busqueda
// R1: id buscado
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
	BEQ R1 R37 BUSQUEDAFINISH
	// Condicionales entre v y el elemento en p
	BGT R1 R37 IFGREATER //si s > v[p]

  //si s < v[p]
	SRLV R30 R36 R33  //n = p/2 - 1
	ADDI R30 R30 #-1
	BEQ R0 R0 BUSQUEDA

IFGREATER: //si s > v[p]
	SRLV R35 R36 R33 //i = p/2 + 1
	ADDI R35 R35 #1
	BEQ R0 R0 BUSQUEDA

BUSQUEDAFINISH:
	LF F3 1(R36)
	SF F3 100(R28)
	BEQ R0 R0 BUSQUEDARET

FINAL:
    ADDI R60 R0 #10
