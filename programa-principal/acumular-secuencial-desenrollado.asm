31
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

ADDI R21 R0 #-1
LOOP: //Recorrer datos hasta leer -1
    ADDF F2 F0 F0 //poner acumulador a 0
    LW R1 40(R2) //leer id
    BEQ R1 R21 FINAL //si R1 == -1 salir
    ADDI R2 R2 #1 //siguiente elemento
    LW R3 40(R2) //leer n
    ADDI R2 R2 #1 //siguiente elemento
    NLOOP: //para n..1
        LF F1 40(R2) //Primer valor
        ADDI R2 R2 #1 //siguiente iterador
        LW R4 40(R2) //Leer variable aplicar factor
        ADDI R2 R2 #1 //siguiente iterador
        BEQ R0 R4 NOMULTIPLICAR  //si variable condicion falsa, no multiplicar
        BNE R1 R5 BUSQUEDASECUENCIAL //Compara factor leido con R1 y coloca en F3 factor buscado
        BUSQUEDARETURN: //llamada a busqueda
        ADD R0 R0 R0    //llamada a busqueda
        MULTF F1, F1, F3  //multiplicar el valor por el factor
        NOMULTIPLICAR:
        ADDF F2 F2 F1 //Acumular valor
        ADD R3 R3 R21 //n--
        BNE R3 R0 NLOOP //volver al bucle si n!=0
    SF F2 20(R1)
    BEQ R0 R0 LOOP
// R22: valor id del recorrido cuando se busca el id
// R23: iterador de la busqueda
BUSQUEDASECUENCIAL://Buscar un valor en la tabla que empieza en 0
  ADDI R5 R1 #0
  ADD R23 R0 R0 //Resetear contador
LOOPBUSQUEDA:
  LW R22 0(R23) //id factor
  ADDI R23 R23 #1 //siguiente elemento
  BNE R22, R1 NOBUSCAR //no cargar valor si id no es el buscado
  LF F3 0(R23) //si es el id, carga factor
  BEQ R0 R0 BUSQUEDARETURN //y salir de subrutina
  NOBUSCAR:
    ADDI R23 R23 #1 //siguiente elemento
BNE R22, R21, LOOPBUSQUEDA
BEQ R22, R21 BUSQUEDARETURN

FINAL:
    ADDI R60 R0 #10
