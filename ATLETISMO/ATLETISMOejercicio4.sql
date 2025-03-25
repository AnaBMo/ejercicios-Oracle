/* ###### EJERCICIO 4: ######

EJERCICIO 4: Crea una funci�n que reciba como par�metro el c�digo de una prueba 
y devuelva el nombre y apellidos concatenados en una �nica variable del atleta 
que ha ganado esa prueba. */


/* ############ Paso 1, plantear la sentencia. */
SELECT A.nombre, A.apellidos
FROM ATLETA A, COMPETIR C
WHERE A.dorsal = C.dorsal_atl
AND C.codigo_pru = '100LM'
AND C.posicion = 1;


/* ############ Paso 2, como solo devuelve info de un registro, es CURSOR IMPL�CITO. */
CREATE OR REPLACE FUNCTION ver_ganador_prueba (pCodPru VARCHAR2)
RETURN VARCHAR2
IS
    -- declaraci�n de variables.
    vNombreCompleto VARCHAR2 (50);

BEGIN
    SELECT A.nombre || ' ' || A.apellidos INTO vNombreCompleto
    FROM ATLETA A, COMPETIR C
    WHERE A.dorsal = C.dorsal_atl
    AND UPPER(C.codigo_pru) = UPPER(pCodPru)
    AND C.posicion = 1;
    
    -- resultado que devuelve la funci�n:
    RETURN vNombreCompleto;

END ver_ganador_prueba;






