/* ******************** Ana Bel�n Morales Jim�nez ******************** */

/* *************************** Ejercicio 3 *************************** */
/* EJERCICIO 3. Utilizando las mismas tablas, realiza con el lenguaje PL/SQL los siguientes apartados
teniendo en cuenta que en este caso tienes que utilizar SQL Developer y cargar el script de BD correspondiente. */

/* b) Crear un disparador que actualice los kil�metros de un veh�culo cuando se actualice el campo de los
kil�metros recorridos en un alquiler cuando el veh�culo ha sido devuelto a las instalaciones. */
CREATE OR REPLACE TRIGGER incrementa_kilometros
AFTER UPDATE OF kms_recorre ON ALQUILAR 
FOR EACH ROW

BEGIN

    UPDATE VEHICULO
    SET kilometros = kilometros + :NEW.kms_recorre 
    WHERE matricula = :OLD.matricula;
    
END; 
    -- Tanto :NEW como :OLD se refieren a campos de ALQUILAR. 
    -- Aqu� que no se usan los alias de las tablas, hay que aprender a leerlo sabiendo esto.
    -- Sin nada son campos de VEHICULO y con :NEW/:OLD son campos de ALQUILAR (tabla "bloqueada por el trigger).
    

/* Comprobamos que funciona insertando un nuevo alquiler. */
INSERT INTO ALQUILAR VALUES('4848DRB','85858585H','07-07-2017',NULL,NULL,NULL,NULL); --null xq todav�a no lo ha devuelto.

UPDATE ALQUILAR
SET kms_recorre=200, fec_entrega='07-09-2017'
WHERE matricula = '4848DRB' AND DNI = '85858585H' AND fec_alquiler='07-07-2017';         
              /* Tras este UPDATE de entrega de veh�culo, el TRIGGER tiene que actuar y sumar los 200 kms. */

