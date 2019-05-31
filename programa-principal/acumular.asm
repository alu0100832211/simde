16
// Recorre los valores y los suma en un registro indexado por el numero de sensor
// R1 : Id Sensor
// R2 : Iterador general
// R3 : Numero de Elementos
// R21 : -1
// F1 : Valor actual Sensor
// F2 : Acumulador Sensor
//
// While R1 != -1

ADDI R21 R0 #-1
LOOP: //por cada sensor
    ADDF F2 F0 F0 //poner acumulador a 0
    LW R1 40(R2) //id del sensor
    BEQ R1 R21 FINAL //si R1 == -1 salir
    ADDI R2 R2 #1 //sumar 1 al iterador
    LW R3 40(R2) //numero de elementos
    ADDI R2 R2 #1
    LOOPV: //para numero elementos(R3)..0
        LF F1 40(R2) //Primer valor
        ADDI R2 R2 #1
        // LW R0 40(R2) //Segundo valor //Si se hace LW R0 peta
        ADDI R2 R2 #1
        ADDF F2 F2 F1 //Acumulador
        ADD R3 R3 R21 //n--
        BNE R3 R0 LOOPV //volver al bucle si n!=0
    SF F2 20(R1)
    BEQ R0 R0 LOOP
FINAL:
    ADDI R60 R0 #10
