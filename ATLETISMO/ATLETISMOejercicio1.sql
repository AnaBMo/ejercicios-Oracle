
/* ###### EJERCICIO 1: ######

Crear un procedimiento que reciba como par�metro el nombre de una universidad y 
muestre por pantalla un listado con el dorsal, el nombre y los apellidos de los 
atletas que pertenecen a esa universidad formateando el listado por columnas 
bien alineadas. */

/* ############ Paso 1, montar el select para comprobar que devulve lo que pide el enunciado. */

SELECT A.dorsal, A.nombre, A.apellidos
FROM ATLETA A, UNIVERSIDAD U
WHERE A.universidad = U.codigo
AND U.nombre = 'Universidad de Alicante'; -- esto es para que se refleje el par�metro,
                                          -- luego habr� que cambiarlo por la variable par�metro.
/

/* ############ Paso 2, como hemos identificado que es una consulta que devuelve varios registros, 
sabemos que es un CURSOR EXPL�CITO */
-- para recorrer usamos FOR que es la versi�n m�s corta y no hay que OPEN y CLOSE cursor.

CREATE OR REPLACE PROCEDURE ver_atletas(pNomUni VARCHAR2) 
IS
    CURSOR cAtletas IS 
    SELECT A.dorsal, A.nombre, A.apellidos
    FROM ATLETA A, UNIVERSIDAD U
    WHERE A.universidad = U.codigo
    AND UPPER(U.nombre) = UPPER(pNomUni); -- cuando le de por par�metro 'Universidad de Alicante', me devolver� lo mismo que arriba.

    vAtleta cAtletas%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Listado de atletas de la Universidad: ' || pNomUni);
    DBMS_OUTPUT.PUT_LINE(RPAD('DORSAL', 10)|| RPAD('NOMBRE', 20) || RPAD('APELLIDOS', 20) );
    
    FOR vAtleta IN cAtletas LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(vAtleta.dorsal, 10)|| RPAD(vAtleta.nombre, 20) || RPAD(vAtleta.apellidos, 20) );
    END LOOP;

END ver_atletas;

-- bien se puede llamar el resultado desde el procedimiento o bien as�:
set serveroutput on;
begin
    ver_atletas('Universidad de Sevilla');
end;


/* ############ Vamos a incluir un CURSOR IMPL�CITO en el ejercicio #########
Por ejemplo, si nos dicen que incluyamos el nombre del entrenador de esa Universidad. 
Devuelve un �nico registro y por eso es impl�cito. */

CREATE OR REPLACE PROCEDURE ver_atletas_entrenador(pNomUni VARCHAR2) 
IS
    CURSOR cAtletas IS 
    SELECT A.dorsal, A.nombre, A.apellidos
    FROM ATLETA A, UNIVERSIDAD U
    WHERE A.universidad = U.codigo
    AND UPPER(U.nombre) = UPPER(pNomUni); -- cuando le de por par�metro 'Universidad de Alicante', me devolver� lo mismo que arriba.

    vAtleta cAtletas%ROWTYPE;
    vNomEntrenador VARCHAR2(20);
BEGIN

    SELECT U.entrenador INTO vNomEntrenador FROM UNIVERSIDAD U WHERE U.nombre= pNomUni;
    DBMS_OUTPUT.PUT_LINE('Listado de atletas de la Universidad: ' || pNomUni || ' cuyo entrenador es: ' || vNomEntrenador);
    DBMS_OUTPUT.PUT_LINE(RPAD('DORSAL', 10)|| RPAD('NOMBRE', 20) || RPAD('APELLIDOS', 20) );
    
    FOR vAtleta IN cAtletas LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(vAtleta.dorsal, 10)|| RPAD(vAtleta.nombre, 20) || RPAD(vAtleta.apellidos, 20) );
    END LOOP;

END ver_atletas_entrenador;


