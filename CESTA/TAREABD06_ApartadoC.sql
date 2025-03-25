/* Morales Jim�nez, Ana Bel�n */

/* ######## BBDD_TAREA 6_APARTADO C ######## */
/* Crear una  funci�n que reciba como par�metro el nombre de un producto y 
devuelva la cantidad total de ese producto que se ha repartido entre todas 
las cestas. */

CREATE OR REPLACE FUNCTION total_producto(pNomProd VARCHAR2)
RETURN NUMBER -- devuelve un valor de tipo NUMBER
IS
    -- Declaraci�n de variables
    vCantidadProd NUMBER;
BEGIN
    /* C�lculo del n�mero total de puntos de los atletas de la universidad pasada como par�metro */
    SELECT SUM(D.cantidad) INTO vCantidadProd FROM DETALLE_CESTA D, PRODUCTOS P
    WHERE D.ref_p = P.referencia
    AND UPPER(P.nombre) = UPPER(pNomProd);

    RETURN vCantidadProd;
    
END total_producto;