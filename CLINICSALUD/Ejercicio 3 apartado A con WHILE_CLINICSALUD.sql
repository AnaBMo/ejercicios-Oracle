/* ***************** Ana Belén Morales Jiménez ***************** */

/* ************************ EJERCICIO 3 ************************ */
/* Utilizando las mismas tablas, pero con el script que tienes para
Oracle, realiza con el lenguaje PL/SQL los siguientes apartados usando SQL
Developer: */

/* APARTADO A: Crear un procedimiento que reciba como parámetro el DNI de un 
paciente y se obtenga un listado con el nombre, apellidos, especialidad de los 
médicos junto a la fecha de consulta y el importe de la misma de todas las 
consultas que ha realizado ese paciente. En la última línea debe aparecer la 
suma total de los importes gastados por ese paciente.  */

CREATE OR REPLACE PROCEDURE consultas_paciente(pDNIpaciente VARCHAR2)
AS
    -- Declaración de variables:
    vNombreMed VARCHAR2(30);
    vApellidosMed VARCHAR2 (50);
    vEspecialidadMed VARCHAR2 (20);

    vFecha_Consulta DATE;
    vImporte_Consultas NUMBER(8,2);

    -- Declaración del cursor:
    CURSOR cConsultasPaciente IS
    SELECT M.nombre, M.apellidos, M.especialidad, CO.fecha_consulta, CO.importe
    FROM MEDICO M, CONSULTAS CO, PACIENTE P
    WHERE M.n_colegiado = CO.medico
    AND P.NSS = CO.paciente
    AND P.DNI = pDNIpaciente;

    -- Declaración de la variable para almacenar recorrido del cursor:
    vConsulta cConsultasPaciente%ROWTYPE;

BEGIN
    -- Primero mostramos la información del paciente:

    DBMS_OUTPUT.PUT_LINE('Listado de consultas del paciente: ' || pDNIpaciente);
    DBMS_OUTPUT.PUT_LINE('');

    -- Después el listado de las consultas relacionadas con ese paciente:
    DBMS_OUTPUT.PUT_LINE(RPAD('-',90,'-'));
    DBMS_OUTPUT.PUT_LINE (RPAD('NOMBRE',20) || RPAD('APELLIDOS',30) || RPAD('ESPECIALIDAD',20)|| RPAD('FECHA',9) || LPAD('IMPORTE',8) );
    DBMS_OUTPUT.PUT_LINE(RPAD('-',90,'-'));

    -- Abrimos el cursor:
    OPEN cConsultasPaciente;

    -- Lee la primera fila y la almacena en la variable vProducto
    FETCH cConsultasPaciente INTO vConsulta;

    -- Bucle de control. Mientras el cursor devuelva resultados, se mostrará por pantalla el valor
    -- recuperado y se leerá la siguiente fila del cursor.
    WHILE cConsultasPaciente%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(vConsulta.nombre, 20) || 
                            RPAD(vConsulta.apellidos, 30) || 
                            RPAD(vConsulta.especialidad, 20) ||
                            RPAD(vConsulta.fecha_consulta, 9) ||
                            LPAD(vConsulta.importe, 8));
                            
        FETCH cConsultasPaciente INTO vConsulta;
    END LOOP;

    CLOSE cConsultasPaciente;

END consultas_paciente;
