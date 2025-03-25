/* ******************** Ana Belén Morales Jiménez ******************** */

/* *************************** Ejercicio 3 *************************** */
/* EJERCICIO 3. Utilizando las mismas tablas, realiza con el lenguaje PL/SQL los siguientes apartados
teniendo en cuenta que en este caso tienes que utilizar SQL Developer y cargar el script de BD correspondiente. */

/* a) Crear un procedimiento que reciba como parámetro la matrícula de un vehículo y muestre por pantalla
el DNI, nombre y apellidos, fecha de alquiler y kilómetros recorridos de los clientes que han
alquilado dicho vehículo. */

CREATE OR REPLACE PROCEDURE detalle_alquiler(pMatricula VARCHAR2)
AS
    -- Declaración de variables:
    vDNI VARCHAR2(10);
    vNombre VARCHAR2 (30);
    vApellidos VARCHAR2 (30);
    
    vFecha_Alquiler DATE;
    vKilometrosReco NUMBER;
    

    -- Declaración del cursor:
    CURSOR cDetalleAlquiler IS
    SELECT C.DNI, C.nombre, C.apellidos, A.fec_alquiler, A.KMS_recorre
    FROM ALQUILAR A, VEHICULO V, CLIENTE C
    WHERE A.DNI = C.DNI
    AND A.matricula = V.matricula
    AND V.matricula = pMatricula;

    -- Declaración de la variable para almacenar recorrido del cursor:
    vConsulta cDetalleAlquiler%ROWTYPE;

BEGIN
    -- Primero mostramos la información del paciente:

    DBMS_OUTPUT.PUT_LINE('El vehículo con matrícula: ' || pMatricula);
    DBMS_OUTPUT.PUT_LINE('');

    -- Después el listado de las consultas relacionadas con ese paciente:
    DBMS_OUTPUT.PUT_LINE(RPAD('-',90,'-'));
    DBMS_OUTPUT.PUT_LINE (RPAD('NOMBRE',20) || RPAD('APELLIDOS',30) || 
                          RPAD('DNI',20)|| RPAD('FECHA',9) || LPAD('KILOMETROS',8));
    DBMS_OUTPUT.PUT_LINE(RPAD('-',90,'-'));

    FOR vConsulta IN cDetalleAlquiler LOOP
    DBMS_OUTPUT.PUT_LINE (RPAD(vConsulta.nombre,20) || RPAD(vConsulta.apellidos,30) || 
                          RPAD(vConsulta.DNI,20)|| RPAD(vConsulta.fec_alquiler,9) || LPAD(vConsulta.kms_recorre,8));
    
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(RPAD('-',90,'-'));

END detalle_alquiler;