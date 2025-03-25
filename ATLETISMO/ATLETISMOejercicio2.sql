
/* ###### EJERCICIO 2: ######

EJERCICIO 2: Crea un procedimiento que reciba como parámetros el nombre y apellidos de un atleta. 
El procedimiento debe de calcular el nivel del atleta que puede ser (Primer nivel, Segundo nivel ó Tercer nivel). 
Para ello si el atleta ha obtenido 3 o más podio será de Primer nivel, si ha obtenido al menos 1 podio 
será de segundo nivel y en otro caso será de Tercer Nivel.

El procedimiento debe actualizar el campo “nivel” de la tabla atleta (siempre y cuando 
el nivel del atleta sea distinto al anterior nivel que tuviera) y debe mostrar 
por pantalla el número de podios obtenidos por el atleta y el nivel actualizado. */

/* El enunciado habla de la devolución de datos de un único registro, por tanto es un CURSOR IMPLÍCITO */

/* ############ Paso 1, montar el select para comprobar que devulve lo que pide el enunciado. */
SELECT COUNT(*)
FROM ATLETA A, COMPETIR C
WHERE A.dorsal = C.dorsal_atl
AND A.nombre = 'Lucía'
AND A.apellidos = 'Gil Martínez'
AND C.posicion IN (1, 2, 3);
-- hasta aquí vemos que Lucía ha conseguido podio 3 veces. 


/* ############ Extra
En caso de querer ver todos los atletas que han conseguido podio, hay que deficir qué info devuelve además 
-- de agrupar. CUANDO PONES COUNT DE VARIOS REGISTROS, TIENES QUE GROUP BY: */
SELECT A.nombre, COUNT(*)
FROM ATLETA A, COMPETIR C
WHERE A.dorsal = C.dorsal_atl
AND C.posicion IN (1, 2, 3)
GROUP BY A.nombre;


/* ############ Paso 2, creamos procedimiento con CURSOR IMPLÍCITO. */
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
/* hasta aquí hace la actualización en todos los registros. Ojo que en el enunciado pone que sólo se actualizará 
     si el resultado es distinto. */

/* Necesitamos tener una variable que controle el nivel que se va teniendo para que a la hora de actualizar, 
no lo haga sobre los registros sin cambios. */

/* ############ Paso 3, repetimos sin actualización de registros sin cambios. */
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
    
    DBMS_OUTPUT.PUT_LINE('El número de podios de ' || pNom || ' ' || pApe || ' es: ' || vPodio || ' y su nivel es: ' || vNivelNew);
    
END actualiza_nivel;


