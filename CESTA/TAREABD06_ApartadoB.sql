/* Morales Jiménez, Ana Belén */

/* ######## BBDD_TAREA 6_APARTADO B ######## */
/* Crear un procedimiento que reciba como parámetros el nombre y los apellidos 
de un socio y se actualice el tipo de ayuda que recibirá pudiendo ser un valor 
entre 1, 2 ó 3 según el cálculo entre su renta y el número de familiares que 
tenga a su cargo. */

CREATE OR REPLACE PROCEDURE tipo_ayuda (pNomSocio VARCHAR2, pApeSocio VARCHAR2)
IS

    -- Declaración de variables:
    vDNI VARCHAR2(9);
    vNombre VARCHAR2 (20);
    vApellidos VARCHAR2(50);
    vRenta NUMBER(10,2);
    vNumfam NUMBER(2,0);
    vRentaFamiliar NUMBER(6,2);
    vRentaNuevo VARCHAR2(1);

BEGIN
    -- Obtenemos el cálculo de renta dividido entre número de familiares:
    SELECT S.DNI, S.nombre, S.apellidos, S.renta, S.numfam, ROUND(S.renta / S.numfam,2) AS RentaXFamiliar
    INTO vDNI, vNombre, vApellidos, vRenta, vNumfam, vRentaFamiliar
    FROM SOCIOS S
    WHERE UPPER(S.nombre) = UPPER(pNomSocio)
    AND UPPER(S.apellidos) = UPPER(pApeSocio);
    
    -- En función del resultado de la media, definimos el tipo de ayuda:
    IF vRentaFamiliar<5000 THEN 
        vRentaNuevo:= '1';
    ELSIF vRentaFamiliar BETWEEN 5000 AND 10000 THEN 
        vRentaNuevo:= '2';
    ELSE
         vRentaNuevo:= '3';
    END IF;
    
    -- Se debe actualizar el tipo de ayuda en la tabla SOCIOS:
    UPDATE SOCIOS S SET ayuda = vRentaNuevo WHERE S.DNI = vDNI;
    
    -- Por último, imprimimos la información:
    DBMS_OUTPUT.PUT_LINE('El socio con DNI: ' || vDNI || ' se llama ' || vNombre || ' ' || vApellidos);
    DBMS_OUTPUT.PUT_LINE('Tiene una renta de: ' || vRenta || ' y tiene ' || vNumfam || ' familiares a su cargo');
    DBMS_OUTPUT.PUT_LINE('El íncide calculado es: ' || vRentaFamiliar || ' y se actualiza el tipo de ayuda a ' || vRentaNuevo); 

END tipo_ayuda;