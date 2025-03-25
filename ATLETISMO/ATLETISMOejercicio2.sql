
/* ###### EJERCICIO 2: ######

EJERCICIO 2: Crea un procedimiento que reciba como par�metros el nombre y apellidos de un atleta. 
El procedimiento debe de calcular el nivel del atleta que puede ser (Primer nivel, Segundo nivel � Tercer nivel). 
Para ello si el atleta ha obtenido 3 o m�s podio ser� de Primer nivel, si ha obtenido al menos 1 podio 
ser� de segundo nivel y en otro caso ser� de Tercer Nivel.

El procedimiento debe actualizar el campo �nivel� de la tabla atleta (siempre y cuando 
el nivel del atleta sea distinto al anterior nivel que tuviera) y debe mostrar 
por pantalla el n�mero de podios obtenidos por el atleta y el nivel actualizado. */

/* El enunciado habla de la devoluci�n de datos de un �nico registro, por tanto es un CURSOR IMPL�CITO */

/* ############ Paso 1, montar el select para comprobar que devulve lo que pide el enunciado. */
SELECT COUNT(*)
FROM ATLETA A, COMPETIR C
WHERE A.dorsal = C.dorsal_atl
AND A.nombre = 'Luc�a'
AND A.apellidos = 'Gil Mart�nez'
AND C.posicion IN (1, 2, 3);
-- hasta aqu� vemos que Luc�a ha conseguido podio 3 veces. 


/* ############ Extra
En caso de querer ver todos los atletas que han conseguido podio, hay que deficir qu� info devuelve adem�s 
-- de agrupar. CUANDO PONES COUNT DE VARIOS REGISTROS, TIENES QUE GROUP BY: */
SELECT A.nombre, COUNT(*)
FROM ATLETA A, COMPETIR C
WHERE A.dorsal = C.dorsal_atl
AND C.posicion IN (1, 2, 3)
GROUP BY A.nombre;


/* ############ Paso 2, creamos procedimiento con CURSOR IMPL�CITO. */
CREATE OR REPLACE PROCEDURE actualiza_nivel (pNom VARCHAR2, pApe VARCHAR2)
AS
    vPodio NUMBER(3);
    vNivel VARCHAR2 (15);
    
BEGIN
    SELECT COUNT(*)
    INTO vPodio
    FROM ATLETA A, COMPETIR C
    WHERE A.dorsal = C.dorsal_atl
    AND UPPER(A.nombre) = UPPER(pNom)
    AND UPPER (A.apellidos) = UPPER(pApe)
    AND C.posicion IN (1, 2, 3);

    IF (vPodio>=3) THEN 
        vNivel := 'Primer Nivel';  
    ELSIF (vPodio>=1) THEN
        vNivel := 'Segundo Nivel';  
    ELSE
        vNivel := 'Tercer Nivel';  
    END IF;
    
    UPDATE ATLETA A SET NIVEL=vNivel WHERE UPPER(A.nombre) = UPPER(pNom) AND UPPER (A.apellidos) = UPPER(pApe);
    
END actualiza_nivel;
/* hasta aqu� hace la actualizaci�n en todos los registros. Ojo que en el enunciado pone que s�lo se actualizar� 
     si el resultado es distinto. */

/* Necesitamos tener una variable que controle el nivel que se va teniendo para que a la hora de actualizar, 
no lo haga sobre los registros sin cambios. */

/* ############ Paso 3, repetimos sin actualizaci�n de registros sin cambios. */
CREATE OR REPLACE PROCEDURE actualiza_nivel (pNom VARCHAR2, pApe VARCHAR2)
AS
    vPodio NUMBER(3);
    vNivelNew VARCHAR2(15);
    vNivelAnt VARCHAR2(15);
    
BEGIN
    SELECT COUNT(*)
    INTO vPodio
    FROM ATLETA A, COMPETIR C
    WHERE A.dorsal = C.dorsal_atl
    AND UPPER(A.nombre) = UPPER(pNom)
    AND UPPER(A.apellidos) = UPPER(pApe)
    AND C.posicion IN (1, 2, 3);

    IF (vPodio>=3) THEN 
        vNivelNew := 'Primer Nivel';  
    ELSIF (vPodio>=1) THEN
        vNivelNew := 'Segundo Nivel';  
    ELSE
        vNivelNew := 'Tercer Nivel';  
    END IF;
    
    -- guardamos nivel anterior para comparar con nuevo.
    SELECT nivel 
    INTO vNivelAnt
    FROM ATLETA A
    WHERE UPPER(A.nombre) = UPPER(pNom)
    AND UPPER (A.apellidos) = UPPER(pApe);
    
    IF (vNivelAnt <> vNivelNew OR vNivelAnt IS NULL ) THEN
    UPDATE ATLETA A SET nivel=vNivelNew WHERE UPPER(A.nombre) = UPPER(pNom) AND UPPER(A.apellidos) = UPPER(pApe);
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('El n�mero de podios de ' || pNom || ' ' || pApe || ' es: ' || vPodio || ' y su nivel es: ' || vNivelNew);
    
END actualiza_nivel;


