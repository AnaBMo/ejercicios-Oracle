/* VIDEO CLASE UD6 � Sesi�n 3*/

SET SERVEROUTPUT ON;

/* 1) Realiza un bloque PL/SQL que sume dos valores introducidos en dos variables y se obtenga
por pantalla un mensaje como el siguiente:
La suma de 12 y 8 es igual a 20 */
DECLARE
    v_num1 NUMBER;
    v_num2 NUMBER;
    v_suma NUMBER;

BEGIN
    v_num1 := 16;
    v_num2 := 8;
    v_suma := v_num1 + v_num2;
    
    DBMS_OUTPUT.PUT_LINE ('La suma de ' || v_num1 || ' y ' || v_num2 || ' es igual a ' || v_suma);
    
END;


/* 2) Realiza un bloque PL/SQL que compare dos valores introducidos en dos variables indicando
un mensaje seg�n el resultado de la comparaci�n Saldr� un mensaje en cada ejecuci�n del
bloque PL/SQL seg�n los valores de las variables que se introduzcan:
� MENSAJE 1: El primero es menor que el segundo.
� MENSAJE 2: Los dos n�meros son iguales.
� MENSAJE 3: El primero es mayor que el segundo.
Por ejemplo: Si se introducen en las variables los valores 6 y 9 respectivamente saldr�:
El primero es menor que el segundo. */
DECLARE
    v_num1 NUMBER;
    v_num2 NUMBER;

BEGIN
    v_num1 := 2;
    v_num2 := 8;
    
    CASE
       WHEN v_num1 < v_num2 THEN
        DBMS_OUTPUT.PUT_LINE ('El primero es menor que el segundo.');
        WHEN v_num1 = v_num2 THEN
        DBMS_OUTPUT.PUT_LINE ('Los dos n�meros son iguales.'); 
        WHEN v_num1 > v_num2 THEN
        DBMS_OUTPUT.PUT_LINE ('El primero es mayor que el segundo.');
    END CASE;
END;


/* ----------- OTRA VERSI�N INTRODUCIENDO N�MEROS POR PANTALLA ----------
SIMPLEMENTE EN LA INICIALIZACI�N DE LOS N�MEROS SE PONE & */
DECLARE
    v_num1 NUMBER;
    v_num2 NUMBER;

BEGIN
    v_num1 := &primero;
    v_num2 := &segundo;
    
    CASE
       WHEN v_num1 < v_num2 THEN
        DBMS_OUTPUT.PUT_LINE ('El primero es menor que el segundo.');
        WHEN v_num1 = v_num2 THEN
        DBMS_OUTPUT.PUT_LINE ('Los dos n�meros son iguales.'); 
        WHEN v_num1 > v_num2 THEN
        DBMS_OUTPUT.PUT_LINE ('El primero es mayor que el segundo.');
    END CASE;
END;



/* 3) Realiza un bloque PL/SQL que obtenga por pantalla por cada tema de conferencia, el total
recaudado de los asistentes que han asistido. Tienes que redondear el total para que no
tenga decimales y formatear con las funciones RPAD y LPAD para que queden alineadas las
columnas. */
-- Si el enunciado dice por cada, es un GROUP BY
DECLARE
    --Necesito un cursor que devulva varios registros (EXPL�CITO)
    CURSOR cConfe 
    IS
    SELECT C.tema, ROUND(SUM(C.precio)) AS Total
    FROM CONFERENCIA C, ASISTIR AR
    WHERE AR.refconferencia = C.referencia
    GROUP BY C.tema
    ORDER BY Total DESC; --no lo pide, pero lo ordeno 

    vConfe cConfe%ROWTYPE; --haces una variable para meter la fila y as� no tienes
                            -- que hacer una por cada campo (v_tema, v_precio) y recorrerla 
                            -- con el FETCH. Esta opci�n es mucho m�s �ptima.
    
BEGIN
    -- FORMATEAR: en primer lugar la CABECERA:
    DBMS_OUTPUT.PUT_LINE(RPAD('-',50, '-')); -- pon a la derecha del primero lo segundo hasta llegar a 50.
    DBMS_OUTPUT.PUT_LINE(RPAD('TEMA',45) || LPAD('TOTAL',5));  -- Imprime TEMA y espacios en blanco hasta el caracter 45. 
    DBMS_OUTPUT.PUT_LINE(RPAD('-',50, '-')); 
    
    FOR vConfe IN cConfe LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(vConfe.tema, 45) || LPAD(vConfe.Total,5));
    END LOOP;

END;


/* 4) Realiza un bloque PL/SQL que obtenga la edad de una persona a partir de una fecha de
nacimiento introducida en una variable. Debe mostrar un mensaje como este:
Actualmente tienes 35 a�os. */

DECLARE
    v_fecNac DATE;
    v_edad NUMBER;

BEGIN
    v_fecNac := '01-06-2000';
    v_edad := TRUNC (months_between(sysdate, v_fecNac)/12);
    DBMS_OUTPUT.PUT_LINE('Actualmente tienes ' || v_edad || ' a�os.');
END;

/* Nota: La dif entre ROUND y TRUNC es que ROUND te puede redondear hacia arriba y 
ponerte m�s a�os. TRUNC es quitar el pico. Mucho mejor en este caso. */


/* 5) Transforma el ejercicio 4 en una funci�n pasando como par�metro la fecha de nacimiento y
que devuelva el valor de la edad. */
 
    /* Parece que lo que se llama aqu� funci�n es un m�todo con sus par�metros. */
CREATE OR REPLACE FUNCTION calculaEdad(p_fecNac DATE)
RETURN NUMBER      -- Fundamental indicarle a la funci�n el tipo de dato a devolver.
IS 
    v_edad NUMBER;

BEGIN
    v_edad := TRUNC (months_between(sysdate, p_fecNac)/12);
    RETURN v_edad;
END;


/* Esa funci�n despu�s se puede usar desde un SELECT */
SELECT CALCULAEDAD ('01-06-2000')AS EDAD FROM DUAL;


/* 6) Realiza una funci�n que calcule el total ganado de las gratificaciones de un ponente cuyo
nombre y primer apellido se pasa como par�metros (utiliza un par�metro para el nombre y
otro para apellido1). Ejecuta la funci�n para comprobar su funcionamiento. */
CREATE OR REPLACE FUNCTION totalGrafificacion (pNombre VARCHAR2, pApell VARCHAR2)
RETURN NUMBER
IS
    v_total NUMBER;
    
BEGIN
    SELECT SUM(PA.gratificacion) AS Ingresa 
    INTO v_total
    FROM PONENTE P, PARTICIPAR PA
    WHERE P.codigo = PA.codponente
    AND UPPER(P.nombre) = UPPER(pNombre)
    AND UPPER(P.apellido1) = UPPER(pApell);

    RETURN v_total;
END;

SELECT totalGrafificacion ('Luisa', 'Soriano') FROM DUAL;








