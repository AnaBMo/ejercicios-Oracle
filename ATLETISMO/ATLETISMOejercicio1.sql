
/* ###### EJERCICIO 1: ######

Crear un procedimiento que reciba como parámetro el nombre de una universidad y 
muestre por pantalla un listado con el dorsal, el nombre y los apellidos de los 
atletas que pertenecen a esa universidad formateando el listado por columnas 
bien alineadas. */

/* ############ Paso 1, montar el select para comprobar que devulve lo que pide el enunciado. */

SELECT A.dorsal, A.nombre, A.apellidos
FROM ATLETA A, UNIVERSIDAD U
WHERE A.universidad = U.codigo
AND U.nombre = 'Universidad de Alicante'; -- esto es para que se refleje el parámetro,
                                          -- luego habrá que cambiarlo por la variable parámetro.
/

/* ############ Paso 2, como hemos identificado que es una consulta que devuelve varios registros, 
sabemos que es un CURSOR EXPLÍCITO */
-- para recorrer usamos FOR que es la versión más corta y no hay que OPEN y CLOSE cursor.

CREATE OR REPLACE PROCEDURE ver_atletas(pNomUni VARCHAR2) 
IS
    CURSOR cAtletas IS 
    SELECT A.dorsal, A.nombre, A.apellidos
    FROM ATLETA A, UNIVERSIDAD U
    WHERE A.universidad = U.codigo
    AND UPPER(U.nombre) = UPPER(pNomUni); -- cuando le de por parámetro 'Universidad de Alicante', me devolverá lo mismo que arriba.

    vAtleta cAtletas%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Listado de atletas de la Universidad: ' || pNomUni);
    DBMS_OUTPUT.PUT_LINE(RPAD('DORSAL', 10)|| RPAD('NOMBRE', 20) || RPAD('APELLIDOS', 20) );
    
    FOR vAtleta IN cAtletas LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(vAtleta.dorsal, 10)|| RPAD(vAtleta.nombre, 20) || RPAD(vAtleta.apellidos, 20) );
    END LOOP;

END ver_atletas;

-- bien se puede llamar el resultado desde el procedimiento o bien así:
set serveroutput on;
begin
    ver_atletas('Universidad de Sevilla');
end;


/* ############ Vamos a incluir un CURSOR IMPLÍCITO en el ejercicio #########
Por ejemplo, si nos dicen que incluyamos el nombre del entrenador de esa Universidad. 
Devuelve un único registro y por eso es implícito. */

CREATE OR REPLACE PROCEDURE ver_atletas_entrenador(pNomUni VARCHAR2) 
IS
    CURSOR cAtletas IS 
    SELECT A.dorsal, A.nombre, A.apellidos
    FROM ATLETA A, UNIVERSIDAD U
    WHERE A.universidad = U.codigo
    AND UPPER(U.nombre) = UPPER(pNomUni); -- cuando le de por parámetro 'Universidad de Alicante', me devolverá lo mismo que arriba.

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


