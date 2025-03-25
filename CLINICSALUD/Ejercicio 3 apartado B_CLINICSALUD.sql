/* ***************** Ana Belén Morales Jiménez ***************** */

/* ************************ EJERCICIO 3 ************************ */
/* Utilizando las mismas tablas, pero con el script que tienes para
Oracle, realiza con el lenguaje PL/SQL los siguientes apartados usando SQL
Developer: */

/* APARTADO B: Crea una función que reciba como parámetro el nombre de una 
provincia y nos devuelva el total de consultas que se han realizado a partir 
del 2022 en cualquier clínica de dicha provincia. */


                    SELECT COUNT(*)
                    FROM CONSULTAS CO, CLINICA C, MEDICO M
                    WHERE CO.medico = M.n_colegiado
                    AND M.clinica = C.codigo
                    AND C.provincia = 'Málaga'
                    AND CO.fecha_consulta >= '01-01-2022';


CREATE OR REPLACE FUNCTION totalConsultas (pProvincia VARCHAR2) RETURN NUMBER
IS
    vTotal NUMBER(6);

BEGIN
    SELECT COUNT(*) INTO vTotal
    FROM CONSULTAS CO, CLINICA C, MEDICO M
    WHERE CO.medico = M.n_colegiado
    AND M.clinica = C.codigo
    AND C.provincia = pProvincia
    AND CO.fecha_consulta >= '01-01-2022';
    
    RETURN vTotal;
END totalConsultas;
