/* Morales Jim�nez, Ana Bel�n */

/* ######## BBDD_TAREA 6_APARTADO A ######## */
/* Crear un procedimiento que reciba como par�metro el n�mero de cesta y muestre por pantalla un listado 
con la informaci�n referente a la propia cesta (ID, nombre y apellidos del voluntario que la prepara, 
fecha de preparaci�n, tipo de cesta y valor total de la misma). Cada uno de estos datos aparecer� 
en una l�nea diferente. A continuaci�n, hay que mostrar el detalle de lo que contiene la cesta 
con el nombre del producto, la cantidad y la unidad de medida. */

CREATE OR REPLACE PROCEDURE listado_cesta(pIdCesta NUMBER)
AS
    -- Declaraci�n de variables:
    vNombreVol VARCHAR2 (20);
    vApellidos VARCHAR2 (50);
    vFecha DATE;
    vTipo VARCHAR2 (10);
    vValor NUMBER(4,2);
    
    vNomProd VARCHAR2 (10);
    vCantidad NUMBER (3,0);
    vMedida VARCHAR2 (3);
    
    -- Declaraci�n del cursor:
    CURSOR cDetalle IS
    SELECT P.nombre, D.cantidad, P.medida FROM PRODUCTOS P, DETALLE_CESTA D
    WHERE D.ref_p = P.referencia
    AND D.id_cesta = pIdCesta;
    
    -- Declaraci�n de la variable para almacenar recorrido del cursor:
    vProducto cDetalle%ROWTYPE;
    
BEGIN
    -- Primero mostramos el listado con informaci�n de la propia cesta:
    SELECT V.nombre, V.apellidos, C.fechaprepara, C.tipo, C.valor_total
    INTO vNombreVol, vApellidos, vFecha, vTipo, vValor
    FROM VOLUNTARIOS V, CESTA C
    WHERE V.DNI = C.DNIV
    AND C.id = pIdCesta;
    
    DBMS_OUTPUT.PUT_LINE('ID Cesta: ' || pIdCesta);
    DBMS_OUTPUT.PUT_LINE('Voluntario que prepara: ' || vNombreVol || ' ' || vApellidos);
    DBMS_OUTPUT.PUT_LINE('Fecha de preparaci�n: ' || vFecha);
    DBMS_OUTPUT.PUT_LINE('Valor Total de la cesta: ' || vValor);
    DBMS_OUTPUT.PUT_LINE('');
    
    DBMS_OUTPUT.PUT_LINE('DETALLE DE LA CESTA');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    DBMS_OUTPUT.PUT_LINE (RPAD('PRODUCTO',20) || LPAD('CANTIDAD',10) || LPAD('MEDIDA',10));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    
    -- A continuaci�n, se debe imprimir el detalle de la cesta:
    -- Abrimos el cursor:
    OPEN cDetalle;
    
    -- Lee la primera fila y la almacena en la variable vProducto
    FETCH cDetalle INTO vProducto;
    
    -- Bucle de control. Mientras el cursor devuelva resultados, se mostrar� por pantalla el valor
    -- recuperado y se leer� la siguiente fila del cursor.
    WHILE cDetalle%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(vProducto.nombre, 20) || 
                            LPAD(vProducto.cantidad, 10) || 
                            LPAD(vProducto.medida, 10));
        FETCH cDetalle INTO vProducto;
    END LOOP;
    
    CLOSE cDetalle;
    
END listado_cesta;





