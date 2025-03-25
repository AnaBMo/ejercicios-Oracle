/* Morales Jiménez, Ana Belén */

/* ######## BBDD_TAREA 6_APARTADO D ######## */
/*Crear un disparador (trigger) que se dispare cada vez que se prepare una nueva 
cesta para que se actualice los puntos acumulados del voluntario que la ha 
preparado con el valor de los puntos de dicha cesta. */

CREATE OR REPLACE TRIGGER actualizar_puntos_voluntario
--El trigger se disparará automáticamente cuando se inserten datos en la tabla CESTA:
AFTER INSERT ON CESTA
FOR EACH ROW -- se dispara por cada fila que se actualice.

-- Declaración de variables.
DECLARE
   vSumaPuntos NUMBER(5,0);
BEGIN

    UPDATE VOLUNTARIOS
    SET puntostotal = puntostotal + :NEW.puntos 
    WHERE DNI = :NEW.DNIV;
END;


/* Insertamos un registro nuevo en cesta para comprobar que se está actualizando. */
SELECT * FROM VOLUNTARIOS;

INSERT INTO CESTA (ID, valor_total, tipo, puntos, fechaprepara, fecharecoge, DNIS, DNIV) 
VALUES ('011', 27.77, 'basica', 17, '07-MAY-2024', '09-MAY-2024', '31642798G', '22447896V');

/* Sentencia para comprobar que se han sumado los puntos. */
SELECT puntostotal 
FROM VOLUNTARIOS 
WHERE DNI = '22447896V';