/* ###### EJERCICIO 5: ######

EJERCICIO 5: Crear un disparador (trigger) que almacene en una tabla, llamada
AUDITORIA_NIVEL_ATLETAS, los valores: usuario (con el que estamos autenticados en Oracle),
dorsal, nombre, apellidos, fecha en la que se produce la actualizaci�n del nivel del atleta, nivel
anterior, nivel posterior. Ese disparador se disparar� cuando se detecte una modificaci�n en el
campo "nivel" de la tabla ATLETA */

/* ############ Paso 1, crear la nueva tabla. */
CREATE TABLE AUDITORIA_NIVEL_ATLETAS(
usuario VARCHAR2(12),
dorsal VARCHAR2(6),
nombre VARCHAR2(20),
apellidos VARCHAR2(20),
fecha DATE,
nivel_ant VARCHAR2(20),
nivel_pos VARCHAR2(20)
);

/* ############ Paso 2, configurar el trigger. */
CREATE OR REPLACE TRIGGER trig_auditoria
/*El trigger se dispara despu�s de modificaciones en el campo NIVEL de la tabla ATLETA */
AFTER UPDATE OF NIVEL ON ATLETA
/*Se dispara por cada fila que se actualice */
FOR EACH ROW
/*Declaramos la variable donde se almacenar� el usuario */
DECLARE
usuario VARCHAR2(30);
BEGIN
/*Obtenemos el usuario que ha iniciado la sesi�n*/
SELECT SYS_CONTEXT('userenv','current_user') INTO usuario FROM
dual;
/*Inserta en la tabla de auditor�a */
INSERT INTO auditoria_nivel_atletas
VALUES(usuario, :old.dorsal,:old.nombre,:old.apellidos, sysdate, :old.nivel, :new.nivel);
END;

/* ##### realizamos una actualizaci�n de nivel para comprobar que el TRIGGER funciona. */
UPDATE atleta a SET nivel = 'Nivelazo'
WHERE a.dorsal = 0151;

