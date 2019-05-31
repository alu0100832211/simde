21
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

    LW R34 40(R0) // Cogemos sensor a buscar (en este caso, 4)

BUSQUEDA:
    // Calculamos p
    SUB R36 R30 R35
    SRLV R36 R36 R33
    ADD R36 R36 R35
    ADDI R36 R36 #-1

    // i == j
    BEQ R30 R35 FINISH
    // sensor == v[p]
    BEQ R37 R34 FINISH

    // Cogemos elemento[p]
    LW R37 0(R36)

    // if (v R34 < elemento R37) {n = p - 1}
    // else {i = p + 1}

    BGT R37 R34 IFGREATER

    ADDI R30 R36 #-1
    BEQ R0 R0 BUSQUEDA

IFGREATER:
    ADDI R35 R36 #1
    BEQ R0 R0 BUSQUEDA

FINISH:
    LW R40 0(R30)
