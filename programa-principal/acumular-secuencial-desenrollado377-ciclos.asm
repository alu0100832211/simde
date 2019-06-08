46
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

ADDI R33 R0 #1
ADDI R21 R0 #-1
ADDI R5 R0 #-1
LOOP: //Recorrer datos hasta leer -1
    ADDF F2 F0 F0 //poner acumulador a 0
    LW R1 40(R2) //leer id
    BEQ R1 R21 FINAL //si R1 == -1 salir
    LW R3 41(R2) //leer n
    ADDI R2 R2 #2 //siguiente elemento
    BNE R1 R5 BUSQUEDASECUENCIAL //Compara factor leido con R1 y coloca en F3 factor buscado
    BUSQUEDARETURN:
    ADD R6 R0 R0
    NLOOP: //para n..1
        //desenrollado 1
        LF F10 40(R2) //Primer valor
        LW R10 41(R2) //Leer variable aplicar factor
        BEQ R0 R10 A
        MULTF F10, F10, F3  //multiplicar el valor por el factor
        A:
        //desenrollado 2
        LF F11 42(R2) //Primer valor
        LW R11 43(R2) //Leer variable aplicar factor
        BEQ R0 R11 B  //si variable condicion falsa, no multiplicar
        MULTF F11, F11, F3  //multiplicar el valor por el factor
        B:
        //desenrollado 3
        LF F12 44(R2) //Primer valor
        LW R12 45(R2) //Leer variable aplicar factor
        BEQ R0 R12 C  //si variable condicion falsa, no multiplicar
        MULTF F12, F12, F3  //multiplicar el valor por el factor
        C:
        //desenrollado 4
        LF F13 46(R2) //Primer valor
        LW R13 47(R2) //Leer variable aplicar factor
        BEQ R0 R13 D  //si variable condicion falsa, no multiplicar
        MULTF F13, F13, F3  //multiplicar el valor por el factor
        D:
        ADDF F5 F10 F11 //Acumular valor
        ADDF F4 F12 F13 //Acumular valor
        ADDF F2 F2 F5   //Acumular valor
        ADDF F2 F2 F4   //Acumular valor
        ADDI R3 R3 #-4
        ADDI R2 R2 #8
        BNE R3 R0 NLOOP //volver al bucle si n!=0
    SF F2 20(R1)
    BEQ R0 R0 LOOP
// R22: valor id del recorrido cuando se busca el id
// R23: iterador de la busqueda
BUSQUEDASECUENCIAL://Buscar un valor en la tabla que empieza en 0
  ADDI R6 R0 #1
  ADDI R5 R1 #0
  ADD R23 R0 R0 //Resetear contador
LOOPBUSQUEDA:
  LW R22 0(R23) //id factor
  BNE R22, R1 NOBUSCAR //no cargar valor si id no es el buscado
  LF F3 1(R23) //si es el id, carga factor
  BEQ R0 R0 BUSQUEDARETURN //y salir de subrutina
  NOBUSCAR:
    ADDI R23 R23 #2 //siguiente elemento
BNE R22, R21, LOOPBUSQUEDA
BEQ R22, R21 BUSQUEDARETURN

FINAL:
    ADDI R60 R0 #10
