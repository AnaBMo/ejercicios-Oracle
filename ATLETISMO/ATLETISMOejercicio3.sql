/* ###### EJERCICIO 3: ######

EJERCICIO 3: Crea una funci�n que reciba como par�metro el nombre de una universidad y 
devuelva la suma total de puntos obtenidos por todos los atletas de esa Universidad. */


/* ############ Paso 1, plantear la sentencia. */
SELECT SUM(C.puntos)
FROM ATLETA A, COMPETIR C, UNIVERSIDAD U
WHERE A.dorsal = C.dorsal_atl
AND A.universidad = U.codigo
AND U.nombre = 'Universidad de Alicante';

/* ############ Paso 2, integrar la sentencia en la funci�n. */
CREATE OR REPLACE FUNCTION puntos_totales_uni(pNomUni VARCHAR2)
RETURN NUMBER
IS
    -- declaraci�n de variables
    vPuntosTotales NUMBER;
    
BEGIN
    --c�lculo del n�mero total de puntos de los atletas pasando el nombre de universidad como par�metro.
    SELECT SUM(C.puntos) INTO vPuntosTotales
    FROM ATLETA A, COMPETIR C, UNIVERSIDAD U
    WHERE A.dorsal = C.dorsal_atl
    AND A.universidad = U.codigo
    AND UPPER(U.nombre) = UPPER(pNomUni);
    
    -- valor de retorno de la funci�n:
    RETURN vPuntosTotales;
    
    DBMS_OUTPUT.PUT_LINE('Los puntos totales de la ' || pNomUni || ' son ' || vPuntosTotales);

END puntos_totales_uni;

set serveroutput on;
    
    
    
    