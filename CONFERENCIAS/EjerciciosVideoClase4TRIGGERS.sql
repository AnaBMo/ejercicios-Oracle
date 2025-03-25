/* *********************** */
/* DISPARADORES O TRIGGERS */
/* *********************** */

/* ------------------------------------------------------------------------------------------------------------------------------------------------ */
/* DISPARADOR 1: Crear un disparador que cuando se actualice el precio de una conferencia se
guarde en una tabla de históricos llamadas HISTORICO_CONFERENCIAS la referencia, el nombre, el
precio anterior y el precio nuevo de la conferencia actualizada. */

-- Primero se crea la tabla mencionada, ya que no existe.
CREATE TABLE HISTORICO_CONFERENCIAS (
    ref CHAR(7),
    NOMBRE VARCHAR2 (60),
    PRECIO_ANTES NUMBER(5,2),
    PRECIO_NUEVO NUMBER(5,2),
    FECHA DATE
);

-- Ahora creamos el TRIGGER:
CREATE OR REPLACE TRIGGER guardar_precio_conferencias
AFTER UPDATE OF PRECIO ON CONFERENCIA -- El trigger me está bloqueando la tabla CONFERENCIA, tengo que usar :OLD y :NEW
FOR EACH ROW

BEGIN
    INSERT INTO HISTORICO_CONFERENCIAS VALUES(:OLD.REFERENCIA, :OLD.TEMA, :OLD.PRECIO, :NEW.PRECIO, SYSDATE);
END;

-- Tras compilar y comprobar que está en la carpeta de Disparadores, tendríamos que hacer algún cambio en la tabla para verificar que funciona.
UPDATE CONFERENCIA SET PRECIO = PRECIO + 5 WHERE TURNO = 'T';

SELECT * FROM HISTORICO_CONFERENCIAS; 

 
/* ------------------------------------------------------------------------------------------------------------------------------------------------ */
/* DISPARADOR 2: Crear un disparador que actualice un campo nuevo creado en la tabla PONENTE y
que se llame “cantidadIngresada” para que añada la gratificación que se le asigne a un ponente en
una conferencia. */

-- Primero creamos el nuevo campo en la tabla PONENTE:
ALTER TABLE PONENTE ADD CANTIDADINGRESADA NUMBER(5,2);

-- Seguimos con la suma de gratificaciones por ponente: 
SELECT CODPONENTE, SUM(GRATIFICACION)
FROM PARTICIPAR
GROUP BY CODPONENTE;


SELECT * FROM PONENTE; 

UPDATE PONENTE -- ESTO ESTÁ DANDO FALLO Y FASTIDIANDO TODO EL EJERCICIO :-(
SET CANTIDADINGRESADA = (SELECT SUM(GRATIFICACION)
                                FROM PARTICIPAR
                                WHERE CODIGO = CODPONENTE
                                GROUP BY CODPONENTE);

-- Creamos el disparador que actualizará la cantidad ingresada al introducir nuevos ingresos en un ponente:
INSERT INTO PARTICIPAR VALUES ('ESP001', 'PWB1314', 5, 500);

CREATE OR REPLACE TRIGGER incrementa_cantidad_ingresada
AFTER INSERT ON PARTICIPAR
FOR EACH ROW

BEGIN
    UPDATE PONENTE SET CANTIDADINGRESADA = CANTIDADINGRESADA + :NEW.GRATIFICACION
    WHERE CODIGO = :NEW.CODPONENTE;
END;


/* ------------------------------------------------------------------------------------------------------------------------------------------------ */
/* DISPARADOR 3: Crear un disparador que cuando se produzca una baja de asistencia de uno de los
asistentes en alguna de las conferencias se guarde en una tabla BAJAS_ASISTENCIA el código del
asistente, la referencia de la conferencia a la que asistía, fecha en la que se da de baja y usuario
que lo ha eliminado. */
-- Primero se crea la tabla mencionada, ya que no existe.
CREATE TABLE BAJAS_ASISTENCIA(
    codasistente CHAR(6),
    ref_conferencia VARCHAR2(7),
    FECHA TIMESTAMP,
    USUARIO VARCHAR2(20)
);

-- La forma de recuperar el usuario que lo ha borrado sería: 
SELECT SYS_CONTEXT('userenv', 'current_user') FROM DUAL;      
-- para meter el usuario en el TRIGGER, debo declaralo y ponerlo en una variable.

-- El TRIGGER afecta a la tabla ASISTIR. 
CREATE OR REPLACE TRIGGER auditar_bajas_asistencia
AFTER DELETE ON ASISTIR
FOR EACH ROW

DECLARE
    usuario VARCHAR2(20);
BEGIN

    SELECT SYS_CONTEXT('userenv', 'current_user') INTO usuario FROM DUAL;  
    INSERT INTO BAJA_ASISTENTE VALUES (:OLD.CODASISTENTE, :OLD.REFCONFERENCIA, CURRENT_TIMESTAMP, usuario);

END;

-- Para comprobar que funciona, borramos un registro de la tabla ASISTIR
DELETE FROM ASISTIR WHERE codasistente = 'AS0013' AND refconferencia = 'BDO1314';



