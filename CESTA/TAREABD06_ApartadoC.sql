/* Morales Jiménez, Ana Belén */

/* ######## BBDD_TAREA 6_APARTADO C ######## */
/* Crear una  función que reciba como parámetro el nombre de un producto y 
devuelva la cantidad total de ese producto que se ha repartido entre todas 
las cestas. */

CREATE OR REPLACE FUNCTION total_producto(pNomProd VARCHAR2)
RETURN NUMBER -- devuelve un valor de tipo NUMBER
IS
    -- Declaración de variables
    vCantidadProd NUMBER;
BEGIN
    /* Cálculo del número total de puntos de los atletas de la universidad pasada como parámetro */
    SELECT SUM(D.cantidad) INTO vCantidadProd FROM DETALLE_CESTA D, PRODUCTOS P
    WHERE D.ref_p = P.referencia
    AND UPPER(P.nombre) = UPPER(pNomProd);

    RETURN vCantidadProd;
    
END total_producto;