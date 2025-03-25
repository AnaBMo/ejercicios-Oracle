ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;


CREATE USER CONCESIONARIO IDENTIFIED BY "1234";


GRANT "CONCESIONARIO" TO CONCESIONARIO;


/* SYSTEM - usuarios - botón derecho - editar usuario-
privilegios del sistema - desactivamos lo siguiente:

    - administer resource manager
    - keep date time
    - keep sysguid
    - 6 que comienzan por sys.
*/
