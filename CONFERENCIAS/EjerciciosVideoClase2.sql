/*VIDEO CLASE UD6 – Sesión 2 */

SET SERVEROUTPUT ON; -- esto solo es necesario activarlo una vez.

/* 1) Realiza un bloque PL/SQL que muestre por pantalla dos líneas como las siguientes:
Hola, me llamo Víctor.
Estoy estudiando la unidad 6 de Base de Datos. */
BEGIN
    DBMS_OUTPUT.PUT_LINE ('Hola, me llamo Ana');
    DBMS_OUTPUT.PUT_LINE ('Estoy intentando descifrar el tema 6 de BBDD.');
END;


/* 2) Realiza un bloque PL/SQL que contenga dos variables, una para almacenar tu nombre y
otra para almacenar la fecha actual del sistema. El bloque tendrá que mostrar por pantalla
la siguiente línea:
La fecha de hoy es 10/04/2024 y mi nombre es Víctor */
DECLARE 
    -- declarar variables (guardar espacio en memoria para la info)
    v_fecha DATE;
    v_nombre VARCHAR2 (20);
BEGIN
    -- inicializar variables
    v_fecha := sysdate;
    v_nombre := 'Ana';
    DBMS_OUTPUT.PUT_LINE ('La fecha de hoy es ' || v_fecha || ' y mi nombre es ' || v_nombre);
END;

/* 3) Realiza un bloque PL/SQL que obtenga por pantalla los datos de la conferencia de
referencia ADS1314. */
-- Ya sabemos que como se está hablando de una clave primaria, nos devolverá un solo registro
-- por tanto es un CURSOR IMPLÍCITO
DECLARE
    v_ref VARCHAR2(20);
    v_tema VARCHAR2(60);
    v_precio NUMBER;
    v_fecha DATE;
    v_turno VARCHAR2(1);
    v_sala VARCHAR2(12);
BEGIN
    SELECT * 
    INTO v_ref, v_tema, v_precio, v_fecha, v_turno, v_sala
    FROM CONFERENCIA 
    WHERE referencia LIKE 'ADS1314';
    DBMS_OUTPUT.PUT_LINE ('Datos: ' || v_ref || ' - ' || 
                                       v_tema || ' - ' || 
                                       v_precio || ' - ' || 
                                       v_fecha || ' - ' || 
                                       v_turno || ' - ' || 
                                       v_sala);
END;


/* 4) Realiza un bloque PL/SQL que obtenga por pantalla el nombre de la empresa 'BK
Programación' y también el total de asistentes de esa empresa. Además, si el total de
asistentes es inferior a 10 mostrará el mensaje 'No obtiene ningún descuento' y en caso
contrario mostrará el mensaje 'Obtiene un 10% de descuento' */
DECLARE
    v_empresa VARCHAR2 (40);
    v_totalAsistentes NUMBER (4);
BEGIN
    SELECT empresa, count(*) 
    INTO v_empresa, v_totalAsistentes 
    FROM ASISTENTE 
    WHERE empresa = 'BK Programación'
    GROUP BY empresa;
     
    DBMS_OUTPUT.PUT_LINE ('La empresa ' || v_empresa || ' tiene ' || v_totalAsistentes || ' asistentes');

    IF (v_totalAsistentes < 10) THEN
        DBMS_OUTPUT.PUT_LINE ('No obtiene ningún descuento');
    ELSE
        DBMS_OUTPUT.PUT_LINE ('Obtiene un 10% de descuento');
    END IF;
END;



/* 5) Realiza un bloque PL/SQL que obtenga el nombre, primer apellido y especialidad de
aquellos ponentes que participan en alguna conferencia cuyo tema contiene la palabra
'SEGURIDAD'. */

/* Si nos fijamos en el diagrama ER, vemos que tengo que pasar
por la tabla PARTICIPAR para llegar al tema de CONFERENCIA. 

IMPORTANTÍSIMO relacionar las tablas entre ellas. Es lo primero del WHERE
para que no se nos olvide.*/
DECLARE    
    CURSOR cPonentes
    IS
    SELECT nombre, apellido1, especialidad
    FROM PONENTE P, PARTICIPAR PA, CONFERENCIA C
    WHERE P.codigo = PA.codponente
    AND C.referencia = PA.refconferencia
    AND UPPER(C.tema) LIKE '%SEGURIDAD%'; -- Ojo porque Oracle es sensible a mayus y minus, usamos siempre UPPER.

    v_ponentes cPonentes%ROWTYPE;

BEGIN
    FOR v_ponentes IN cPonentes LOOP
        DBMS_OUTPUT.PUT_LINE ('Ponente: ' || v_ponentes.nombre 
                                          || ' ' || v_ponentes.apellido1 
                                          || ' ' || v_ponentes.especialidad);
    END LOOP;
END;


