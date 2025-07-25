/*CREA UN USUARIO*/
CREATE USER ACTIVIDADCLASE12 IDENTIFIED BY 1;

/*CREA PERMISOS PARA CREAR TABLAS Y OTRAS COSAS*/
GRANT CONNECT, RESOURCE TO ACTIVIDADCLASE12;

/*DA PERMISOS PARA USAR EL ESPACIO DE USERS*/
ALTER USER ACTIVIDADCLASE12 DEFAULT TABLESPACE USERS;
ALTER USER ACTIVIDADCLASE12 QUOTA UNLIMITED ON USERS;

/* otorgando al usuario ACTIVIDADCLASE12 el privilegio para crear vistas materializadas en su propio esquema.*/
GRANT CREATE MATERIALIZED VIEW TO ACTIVIDADCLASE12;
SELECT USER FROM dual;


/*CREACION DE TABLAS*/
/*TABLA USUARIOS*/
CREATE TABLE ACTIVIDADCLASE12.usuarios (
 usuario_id NUMBER PRIMARY KEY,
 nombre VARCHAR2(100),
 correo VARCHAR2(150)
);

/*TABLA INCIDENTES*/
CREATE TABLE ACTIVIDADCLASE12.incidentes (
 incidente_id NUMBER PRIMARY KEY,
 descripcion VARCHAR2(200),
 criticidad VARCHAR2(20)
);

/*TABLA TICKETS*/
CREATE TABLE ACTIVIDADCLASE12.tickets (
 ticket_id NUMBER PRIMARY KEY,
 usuario_id NUMBER,
 incidente_id NUMBER,
 fecha_apertura TIMESTAMP DEFAULT SYSTIMESTAMP,
 estado VARCHAR2(20),
 FOREIGN KEY (usuario_id) REFERENCES ACTIVIDADCLASE12.usuarios(usuario_id),
 FOREIGN KEY (incidente_id) REFERENCES ACTIVIDADCLASE12.incidentes(incidente_id)
);

CREATE SEQUENCE tickets_seq
START WITH 14           
INCREMENT BY 1;        

/*TABLA CHAT_IA*/
CREATE TABLE ACTIVIDADCLASE12.chat_ia (
 chat_id NUMBER PRIMARY KEY,
 ticket_id NUMBER,
 mensaje VARCHAR2(300),
 quien VARCHAR2(20),
 fecha TIMESTAMP DEFAULT SYSTIMESTAMP,
 FOREIGN KEY (ticket_id) REFERENCES ACTIVIDADCLASE12.tickets(ticket_id)
);
/*SECUENCIA PARA CHAT_IA*/
CREATE SEQUENCE chat_ia_seq
START WITH 11           
INCREMENT BY 1        
DROP SEQUENCE chat_ia_seq;


/*TABLA SOLUCIONES*/
CREATE TABLE ACTIVIDADCLASE12.soluciones (
 solucion_id NUMBER PRIMARY KEY,
 ticket_id NUMBER,
 solucion_texto VARCHAR2(300),
 aplicada_por VARCHAR2(20),
 fecha TIMESTAMP DEFAULT SYSTIMESTAMP,
 FOREIGN KEY (ticket_id) REFERENCES ACTIVIDADCLASE12.tickets(ticket_id)
);

CREATE SEQUENCE soluciones_seq 
START WITH 12 
INCREMENT BY 1;

/*INSERT DE LAS TABLAS*/
/*INSERT USUARIOS*/
INSERT INTO ACTIVIDADCLASE12.usuarios VALUES (1, 'Ana López', 'ana@correo.com');
INSERT INTO ACTIVIDADCLASE12.usuarios VALUES (2, 'Carlos Ruiz', 'carlos@correo.com');
INSERT INTO ACTIVIDADCLASE12.usuarios VALUES (3, 'Diana Gómez', 'diana@correo.com');
INSERT INTO ACTIVIDADCLASE12.usuarios VALUES (4, 'Fernando Pérez', 'fernando@correo.com');
INSERT INTO ACTIVIDADCLASE12.usuarios VALUES (5, 'Lucía Torres', 'lucia@correo.com');
INSERT INTO ACTIVIDADCLASE12.usuarios VALUES (6, 'Marcos Salas', 'marcos@correo.com');
INSERT INTO ACTIVIDADCLASE12.usuarios VALUES (7, 'Patricia Vega', 'patricia@correo.com');
INSERT INTO ACTIVIDADCLASE12.usuarios VALUES (8, 'Raúl Mendoza', 'raul@correo.com');
INSERT INTO ACTIVIDADCLASE12.usuarios VALUES (9, 'Silvia Castro', 'silvia@correo.com');
INSERT INTO ACTIVIDADCLASE12.usuarios VALUES (10, 'Tomás Fuentes', 'tomas@correo.com');

/*INSERT INCIDENTES*/
INSERT INTO ACTIVIDADCLASE12.incidentes VALUES (1, 'No enciende el equipo', 'Alta');
INSERT INTO ACTIVIDADCLASE12.incidentes VALUES (2, 'No hay internet', 'Media');
INSERT INTO ACTIVIDADCLASE12.incidentes VALUES (3, 'Pantalla azul', 'Alta');
INSERT INTO ACTIVIDADCLASE12.incidentes VALUES (4, 'No imprime', 'Baja');
INSERT INTO ACTIVIDADCLASE12.incidentes VALUES (5, 'Virus detectado', 'Alta');
INSERT INTO ACTIVIDADCLASE12.incidentes VALUES (6, 'Lentitud en sistema', 'Media');
INSERT INTO ACTIVIDADCLASE12.incidentes VALUES (7, 'Error al abrir app', 'Media');
INSERT INTO ACTIVIDADCLASE12.incidentes VALUES (8, 'Mouse no responde', 'Baja');
INSERT INTO ACTIVIDADCLASE12.incidentes VALUES (9, 'Teclado da doble letra', 'Baja');
INSERT INTO ACTIVIDADCLASE12.incidentes VALUES (10, 'Desbloqueo de cuenta', 'Media');

/*INSERT TICKETS*/
INSERT INTO ACTIVIDADCLASE12.tickets VALUES (1, 1, 1, SYSTIMESTAMP, 'Abierto');
INSERT INTO ACTIVIDADCLASE12.tickets VALUES (2, 2, 2, SYSTIMESTAMP, 'Cerrado');
INSERT INTO ACTIVIDADCLASE12.tickets VALUES (3, 3, 3, SYSTIMESTAMP, 'Abierto');
INSERT INTO ACTIVIDADCLASE12.tickets VALUES (4, 4, 4, SYSTIMESTAMP, 'Abierto');
INSERT INTO ACTIVIDADCLASE12.tickets VALUES (5, 5, 5, SYSTIMESTAMP, 'Cerrado');
INSERT INTO ACTIVIDADCLASE12.tickets VALUES (6, 6, 6, SYSTIMESTAMP, 'Abierto');
INSERT INTO ACTIVIDADCLASE12.tickets VALUES (7, 7, 7, SYSTIMESTAMP, 'Cerrado');
INSERT INTO ACTIVIDADCLASE12.tickets VALUES (8, 8, 8, SYSTIMESTAMP, 'Abierto');
INSERT INTO ACTIVIDADCLASE12.tickets VALUES (9, 9, 9, SYSTIMESTAMP, 'Cerrado');
INSERT INTO ACTIVIDADCLASE12.tickets VALUES (10, 10, 10, SYSTIMESTAMP, 'Abierto');

/*INSERT CHAT_IA*/
INSERT INTO ACTIVIDADCLASE12.chat_ia VALUES (1, 1, 'Hola, ¿puedes describir el problema?', 'IA', SYSTIMESTAMP);
INSERT INTO ACTIVIDADCLASE12.chat_ia VALUES (2, 1, 'No enciende mi computadora', 'usuario', SYSTIMESTAMP);
INSERT INTO ACTIVIDADCLASE12.chat_ia VALUES (3, 2, '¿Tienes el router conectado?', 'IA', SYSTIMESTAMP);
INSERT INTO ACTIVIDADCLASE12.chat_ia VALUES (4, 2, 'Sí, pero no hay señal', 'usuario', SYSTIMESTAMP);
INSERT INTO ACTIVIDADCLASE12.chat_ia VALUES (5, 3, '¿Te sale algún código de error?', 'IA', SYSTIMESTAMP);
INSERT INTO ACTIVIDADCLASE12.chat_ia VALUES (6, 4, '¿Ya revisaste el papel en la impresora?', 'IA', SYSTIMESTAMP);
INSERT INTO ACTIVIDADCLASE12.chat_ia VALUES (7, 5, 'Se detectó un virus, actualizando antivirus.', 'IA', SYSTIMESTAMP);
INSERT INTO ACTIVIDADCLASE12.chat_ia VALUES (8, 6, '¿Qué aplicación va lenta?', 'IA', SYSTIMESTAMP);
INSERT INTO ACTIVIDADCLASE12.chat_ia VALUES (9, 7, 'Reinstala la app y reinicia.', 'IA', SYSTIMESTAMP);
INSERT INTO ACTIVIDADCLASE12.chat_ia VALUES (10, 8, 'Prueba otro puerto USB.', 'IA', SYSTIMESTAMP);

/*INSERT SOLUCIONES*/
INSERT INTO ACTIVIDADCLASE12.soluciones VALUES (1, 1, 'Se cambió la fuente de poder.', 'Técnico', SYSTIMESTAMP);
INSERT INTO ACTIVIDADCLASE12.soluciones VALUES (2, 2, 'Se reinició el módem.', 'IA', SYSTIMESTAMP);
INSERT INTO ACTIVIDADCLASE12.soluciones VALUES (3, 3, 'Actualización de drivers.', 'IA', SYSTIMESTAMP);
INSERT INTO ACTIVIDADCLASE12.soluciones VALUES (4, 4, 'Colocación de nuevo cartucho.', 'Técnico', SYSTIMESTAMP);
INSERT INTO ACTIVIDADCLASE12.soluciones VALUES (5, 5, 'Limpieza de archivos infectados.', 'IA', SYSTIMESTAMP);
INSERT INTO ACTIVIDADCLASE12.soluciones VALUES (6, 6, 'Optimización del sistema.', 'IA', SYSTIMESTAMP);
INSERT INTO ACTIVIDADCLASE12.soluciones VALUES (7, 7, 'Actualización del software.', 'Técnico', SYSTIMESTAMP);
INSERT INTO ACTIVIDADCLASE12.soluciones VALUES (8, 8, 'Cambio de puerto USB.', 'IA', SYSTIMESTAMP);
INSERT INTO ACTIVIDADCLASE12.soluciones VALUES (9, 9, 'Revisión del teclado.', 'Técnico', SYSTIMESTAMP);
INSERT INTO ACTIVIDADCLASE12.soluciones VALUES (10, 10, 'Reset de credenciales.', 'IA', SYSTIMESTAMP);
INSERT INTO ACTIVIDADCLASE12.soluciones VALUES (11, 5, 'Se restauro el sistema operativo', 'Tecnico', SYSTIMESTAMP);
INSERT INTO ACTIVIDADCLASE12.soluciones VALUES (12, 3, 'Se restauro el sistema operativo', 'IA', SYSTIMESTAMP);

/*VISTAS NORMALES 1*/
/*Crea una vista que muestre el nombre del usuario, la descripción del incidente y el
estado del ticket, solo para tickets que están abiertos*/
CREATE OR REPLACE VIEW 
ACTIVIDADCLASE12.VISTA1 AS
SELECT
/*SELECCIONAS COLUMNA NOMBRE DE TABLA USUARIO CON APODO (AS) as es el nuevo nombre de la comlumna en la vista, NOMBRE_USUARIO*/
/*I ES DE LA TABLA INCIDENTES CON COLUMNA DESCRIPCION CON APODO (AS) DESCRIPCION_INCIDENTES*/
/*T DE LA TABLA TICKET CON COLUMNA ESTADO Y APODO (AS) ESTADO_TICKET*/
u.nombre AS nombre_usuario,
i.descripcion AS descripcion_incidentes,
t.estado AS estado_ticket
/*DE LA TABLA USUARIOS SE JALA LA INFORMACION*/
FROM
ACTIVIDADCLASE12.usuarios u 
/*DE LA TABLA TICKET SE RELACIONA DE LA TABLA USUARIO (U) USUARIO_ID SEA IGUAL A LA TABLA TICKET (T) USUARIO_ID*/
JOIN
ACTIVIDADCLASE12.tickets t ON 
u.usuario_id = t.usuario_id
JOIN
ACTIVIDADCLASE12.incidentes i ON 
t.incidente_id = i.incidente_id
WHERE
t.estado = 'Abierto';

SELECT * FROM ACTIVIDADCLASE12.VISTA1;

SELECT * FROM ACTIVIDADCLASE12.chat_ia;
SELECT * FROM ACTIVIDADCLASE12.usuarios;
SELECT * FROM ACTIVIDADCLASE12.tickets;
SELECT * FROM ACTIVIDADCLASE12.incidentes;
SELECT * FROM ACTIVIDADCLASE12.soluciones;

/*VISTA NORMALES 2*/
/*Crea una vista que liste el historial del chat, mostrando el nombre del usuario, el
mensaje, quién lo dijo y la fecha.*/
CREATE OR REPLACE VIEW
ACTIVIDADCLASE12.HISTORIAL_CHAT AS
SELECT 
usuario.nombre AS nombre,
chat.mensaje AS mensaje,
chat.quien AS quien_lo_dijo,
chat.fecha AS fecha
FROM
ACTIVIDADCLASE12.usuarios usuario
JOIN 
ACTIVIDADCLASE12.tickets ticket ON
usuario.usuario_id = ticket.usuario_id
JOIN
ACTIVIDADCLASE12.chat_ia chat ON
ticket.ticket_id = chat.ticket_id;

SELECT * FROM ACTIVIDADCLASE12.HISTORIAL_CHAT;

/*VISTA NORMALES 3*/
/*Crea una vista que muestre las soluciones aplicadas por IA, con el ticket, la
descripción del incidente y el texto de la solución.*/
CREATE OR REPLACE VIEW
ACTIVIDADCLASE12.SOLUCIONES_IA AS
SELECT
ticket.ticket_id AS Numero_ticket,
incidentes.descripcion AS descripcion_indicente,
soluciones.solucion_texto AS texto_solucion,
soluciones.aplicada_por AS aplicado_por 
FROM
ACTIVIDADCLASE12.incidentes incidentes
JOIN 
ACTIVIDADCLASE12.tickets ticket ON
ticket.incidente_id = incidentes.incidente_id
JOIN 
ACTIVIDADCLASE12.soluciones soluciones ON
soluciones.ticket_id = ticket.ticket_id 
WHERE
soluciones.aplicada_por = 'IA';

SELECT * FROM ACTIVIDADCLASE12.SOLUCIONES_IA;




/*VISTAS MATERIALIZADAS 1*/
/*Crea una vista materializada que guarde los tickets cerrados con el nombre del
usuario y criticidad del incidente.*/
CREATE MATERIALIZED VIEW tickets_cerrados
REFRESH COMPLETE AS
SELECT
usuario.nombre AS nombre_usuario,
incidente.criticidad AS criticidad_incidente,
ticket.estado AS estado_ticket
FROM
ACTIVIDADCLASE12.tickets ticket
JOIN
ACTIVIDADCLASE12.usuarios usuario ON
ticket.usuario_id = usuario.usuario_id
JOIN
ACTIVIDADCLASE12.incidentes incidente ON
ticket.incidente_id = incidente.incidente_id
WHERE
ticket.estado ='Cerrado';

SELECT * FROM ACTIVIDADCLASE12.tickets_cerrados;
SELECT * FROM ACTIVIDADCLASE12.usuarios;
SELECT * FROM ACTIVIDADCLASE12.tickets;
SELECT * FROM ACTIVIDADCLASE12.incidentes;

/*VISTAS MATERIALIZADAS 2*/
/*Crea una vista materializada que muestre todas las soluciones aplicadas por técnicos,
con su fecha y ticket asociado*/
CREATE MATERIALIZED VIEW soluciones_tecnicos
REFRESH COMPLETE AS 
SELECT 
solucion.aplicada_por AS soluciones_tecnicos,
solucion.fecha AS fecha,
ticket.ticket_id AS numero_ticket
FROM
ACTIVIDADCLASE12.soluciones solucion
JOIN 
ACTIVIDADCLASE12.tickets ticket ON
solucion.ticket_id = ticket.ticket_id
WHERE
solucion.aplicada_por = 'Técnico';

SELECT * FROM ACTIVIDADCLASE12.soluciones_tecnicos;

/*VISTAS MATERIALIZADAS 3*/
/*Crea una vista materializada que muestre el total de tickets abiertos y cerrados
agrupado por criticidad del incidente.*/
CREATE MATERIALIZED VIEW tickets_abiertos_cerrados
REFRESH COMPLETE AS 
SELECT 
ticket.estado AS total_tickets
ticket.ticket_id AS numero_ticket
FROM




SELECT * FROM ACTIVIDADCLASE12.incidentes;
SELECT * FROM ACTIVIDADCLASE12.tickets;

/*TRIGGERS 1*/
/*• Crea un trigger que al insertar una nueva solución, inserte automáticamente un
mensaje en chat_ia diciendo “Solución aplicada: texto_solución”.*/
CREATE OR REPLACE TRIGGER insert_mensaje
AFTER INSERT ON soluciones
FOR EACH ROW
BEGIN
    INSERT INTO chat_ia (chat_id, ticket_id, mensaje, quien,fecha)
    VALUES (chat_ia_seq.NEXTVAL, :NEW.ticket_id,'Solución aplicada: ' || :NEW.solucion_texto, :NEW.aplicada_por, :NEW.fecha);
END;

/*PARA CHECAR LOS ERRORES QUE TE PROVOCA*/
SELECT *
FROM user_errors
WHERE name = 'INSERT_MENSAJE'
ORDER BY sequence;

SELEC
/*TRIGGERS 2*/
/*Crea un trigger que al cambiar el estado del ticket a “Cerrado”, inserte en chat_ia un
mensaje automático diciendo “Ticket cerrado”.*/
CREATE OR REPLACE TRIGGER ticket_cerrado
AFTER UPDATE ON tickets
FOR EACH ROW
BEGIN
	 IF :NEW.estado = 'Cerrado' AND :OLD.estado <> 'Cerrado' THEN
        INSERT INTO chat_ia (chat_id, ticket_id, mensaje, quien, fecha)
        VALUES (chat_ia_seq.NEXTVAL, :NEW.ticket_id, 'Ticket cerrado', 'IA', SYSDATE);
    END IF;
	
END;
/


/*CAMBIAR EL ESTADO DEL TICKET ID 1*/
UPDATE tickets
SET estado = 'Cerrado'
WHERE ticket_id = 500;
/*HACE QUE EL UPDATE SE HAGA EFECTIVO*/
COMMIT;


SELECT * FROM ACTIVIDADCLASE12.tickets;
SELECT * FROM ACTIVIDADCLASE12.chat_ia;

/*CHECAR PROBLEMA MAS A DETALLE*/
SELECT line, position, text
FROM user_errors
WHERE name = 'TICKET_CERRADO';

/*TRIGGERS 3*/
/*Crea un trigger que prohíba (usando RAISE_APPLICATION_ERROR) insertar tickets
con estado diferente a “Abierto” o “Cerrado”.*/
CREATE OR REPLACE TRIGGER validar_estado_ticket
BEFORE INSERT ON tickets
FOR EACH ROW
BEGIN
    IF :NEW.estado NOT IN ('Abierto', 'Cerrado') THEN
        RAISE_APPLICATION_ERROR(-20001, 'El estado del ticket debe ser "Abierto" o "Cerrado".');
    END IF;
END;

SELECT * FROM ACTIVIDADCLASE12.validar_estado_ticket;
/*funciona*/
INSERT INTO tickets (ticket_id, usuario_id, incidente_id, fecha_apertura, estado) VALUES (13, 10, 5, SYSDATE, 'Abierto');

/*lanzará un error*/
INSERT INTO tickets (ticket_id, usuario_id, incidente_id, fecha_apertura, estado) VALUES (14, 11, 6, SYSDATE, 'En progreso');

SELECT * FROM tickets;

/*FUNCIONES 1*/
/*Crea una función que reciba un ticket_id y devuelva el estado actual del ticket*/
CREATE OR REPLACE FUNCTION estado_actual_ticket(p_ticket_id IN NUMBER)
RETURN VARCHAR2
IS
  v_estado VARCHAR2(100);
BEGIN
  SELECT estado
  INTO v_estado
  FROM tickets
  WHERE ticket_id = p_ticket_id;

  RETURN v_estado;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'Ticket no encontrado';
END;

SELECT estado_actual_ticket(1) FROM dual;

/*FUNCIONES 2*/
/*Crea una función que reciba un usuario_id y devuelva el total de tickets que ha
reportado ese usuario.*/
CREATE OR REPLACE FUNCTION total_tickets_usuario(p_usuario_id IN NUMBER)
RETURN NUMBER
IS
  v_total NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_total
  FROM tickets
  WHERE usuario_id = p_usuario_id;

  RETURN v_total;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 0;  -- Esto no se activará con COUNT(*), pero lo dejamos por buenas prácticas
END;


/*FUNCIONES 3*/
/*Crea una función que reciba un ticket_id y regrese un texto concatenado que diga:
"Usuario: nombre - Incidente: descripción - Estado: estado"*/
CREATE OR REPLACE FUNCTION obtener_info_ticket(p_ticket_id IN NUMBER)
RETURN VARCHAR2
IS
    v_nombre      VARCHAR2(100);
    v_descripcion VARCHAR2(1000);
    v_estado      VARCHAR2(50);
    v_resultado   VARCHAR2(1200);
BEGIN
    SELECT u.nombre, i.descripcion, t.estado
    INTO v_nombre, v_descripcion, v_estado
    FROM tickets t
    JOIN usuarios u ON t.usuario_id = u.usuario_id
    JOIN incidentes i ON t.incidente_id = i.incidente_id
    WHERE t.ticket_id = p_ticket_id;

    v_resultado := 'Usuario: ' || v_nombre ||
                   ' - Incidente: ' || v_descripcion ||
                   ' - Estado: ' || v_estado;

    RETURN v_resultado;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Ticket no encontrado';
    WHEN OTHERS THEN
        RETURN 'Error al obtener el ticket';
END;

SELECT obtener_info_ticket(1) FROM dual;

/*PROCEDIMIENTOS*/
/*Crea un procedimiento que reciba el usuario_id, incidente_id y estado, e inserte un
nuevo ticket en la tabla tickets.*/
CREATE OR REPLACE PROCEDURE insertar_nuevo_ticket(
    p_usuario_id   IN NUMBER,
    p_incidente_id IN NUMBER,
    p_estado       IN VARCHAR2
)
IS
BEGIN
    INSERT INTO tickets (ticket_id, usuario_id, incidente_id, fecha_apertura, estado)
    VALUES (
        tickets_seq.NEXTVAL,  -- Suponiendo que usas una secuencia llamada tickets_seq
        p_usuario_id,
        p_incidente_id,
        SYSDATE,
        p_estado
    );
    
    COMMIT;
END;

BEGIN
    insertar_nuevo_ticket(10, 6, 'Abierto');
END;

/*PROCEDIMIENTOS 2*/
/*Crea un procedimiento que reciba un ticket_id y cambie su estado a “Cerrado”*/
CREATE OR REPLACE PROCEDURE cerrar_ticket(p_ticket_id IN NUMBER)
IS
BEGIN
    UPDATE tickets
    SET estado = 'Cerrado'
    WHERE ticket_id = p_ticket_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20001,'No se encontró el ticket con ID ' || TO_CHAR(p_ticket_id));
    END IF;

    COMMIT;
END;

BEGIN
    cerrar_ticket(10);
END;
SELECT * FROM ACTIVIDADCLASE12.tickets;

/*PROCEDIMIENTO 3*/
/*Crea un procedimiento que inserte una nueva solución recibiendo: ticket_id,
solucion_texto y aplicada_por.*/
CREATE OR REPLACE PROCEDURE insertar_solucion_nueva(
    p_ticket_id      IN NUMBER,
    p_solucion_texto IN VARCHAR2,
    p_aplicada_por   IN VARCHAR2
)
IS
BEGIN
    INSERT INTO soluciones (
        solucion_id,
        ticket_id,
        solucion_texto,
        aplicada_por,
        fecha
    )
    VALUES (
        soluciones_seq.NEXTVAL,  -- Usa tu secuencia
        p_ticket_id,
        p_solucion_texto,
        p_aplicada_por,
        SYSDATE
    );

    COMMIT;
END;

BEGIN
    insertar_solucion_nueva(12, 'Actualización del software aplicada correctamente.', 'tecnico1');
END;
SELECT * FROM ACTIVIDADCLASE12.soluciones;

/*INNER JOIN*/
/*Muestra el nombre del usuario y el estado del ticket, solo para los tickets que tienen
usuario asignado.*/
SELECT 
u.nombre AS nombre_usuario,
t.estado AS estado_ticket
FROM 
ACTIVIDADCLASE12.tickets t
INNER JOIN 
ACTIVIDADCLASE12.usuarios u ON 
t.usuario_id = u.usuario_id;

/*Muestra el ticket_id, la criticidad del incidente y el nombre del usuario de todos los
tickets que tienen incidente y usuario registrado*/
SELECT 
t.ticket_id AS Numero_ticket,
i.criticidad AS criticidad,
u.nombre AS nombre_usuario
FROM
ACTIVIDADCLASE12.tickets t
INNER JOIN
ACTIVIDADCLASE12.usuarios u ON
t.usuario_id = u.usuario_id
INNER JOIN 
ACTIVIDADCLASE12.incidentes i ON
t.incidente_id = i.incidente_id;

/*Muestra el mensaje del chat, quién lo dijo y la solución aplicada solo si existe una
solución para ese ticket.*/
SELECT 
c.mensaje AS mensaje_chat,
c.quien AS quien_lo_dijo,
s.aplicada_por AS solucion_aplicada
FROM 
ACTIVIDADCLASE12.tickets t
INNER JOIN
ACTIVIDADCLASE12.chat_ia c ON
c.ticket_id = t.ticket_id
INNER JOIN 
ACTIVIDADCLASE12.soluciones s ON
s.ticket_id = t.ticket_id;


/*LEF JOIN*/
/*Lista todos los usuarios con su estado del ticket, aunque no tengan tickets abiertos o
cerrados.*/
SELECT 
u.usuario_id AS usuario_ticket,
u.nombre AS nombre_usuario,
t.estado AS estado_ticket
FROM 
ACTIVIDADCLASE12.usuarios u
LEFT JOIN 
tickets t ON u.usuario_id = t.usuario_id;

/*Muestra la descripción del incidente junto con el estado del ticket, asegurándote que
se muestren todos los incidentes, tengan o no ticket asociado.*/
SELECT 
i.descripcion AS descripcion_incidente,
t.estado AS estado_ticket
FROM 
ACTIVIDADCLASE12.incidentes i
LEFT JOIN 
ACTIVIDADCLASE12.tickets t ON 
i.incidente_id = t.incidente_id;


/*Muestra todos los tickets con la posible solución aplicada, aunque algunos tickets aún
no tengan solución.*/
SELECT 
t.ticket_id,
s.solucion_texto,
s.aplicada_por
FROM 
ACTIVIDADCLASE12.tickets t
LEFT JOIN 
ACTIVIDADCLASE12.soluciones s ON 
t.ticket_id = s.ticket_id;

/*RIGHT JOIN */
/*Muestra todos los tickets con el nombre del usuario, incluyendo aquellos tickets que
pueden existir sin tener usuario asignado (simulado)*/
SELECT 
t.ticket_id AS Numero_ticket,
u.nombre AS nombre_usuario,
t.estado AS ,
NVL(u.nombre, 'Sin asignar') AS nombre_usuario
FROM 
ACTIVIDADCLASE12.usuarios u
RIGHT JOIN 
ACTIVIDADCLASE12.tickets t ON 
u.usuario_id = t.usuario_id;

/*Lista todos los chats y muestra el mensaje junto con el estado del ticket, asegurando
que aparezcan todos los chats, incluso si algún ticket estuviera eliminado.*/
SELECT 
c.chat_id,
c.mensaje,
t.estado
FROM 
ACTIVIDADCLASE12.tickets t
RIGHT JOIN 
ACTIVIDADCLASE12.chat_ia c ON 
t.ticket_id = c.ticket_id;

/*Muestra las soluciones junto con el nombre del usuario, asegurando que aparezcan
todas las soluciones, aunque el usuario no exista (caso teórico).*/
SELECT 
s.solucion_id AS todas_las_soluciones,
s.solucion_texto AS descripcion_solucion,
u.nombre AS nombre_usuario
FROM 
ACTIVIDADCLASE12.soluciones s
RIGHT JOIN 
ACTIVIDADCLASE12.tickets t ON
t.usuario_id = t.ticket_id
RIGHT JOIN 
ACTIVIDADCLASE12.usuarios u ON 
s.solucion_id = t.ticket_id;

/*FULL OUTER JOIN*/
/*Muestra todos los usuarios y tickets, aunque no existan registros relacionados entre ellos.*/
SELECT 
u.usuario_id AS numero_usuario,
u.nombre AS nombre_usuario,
u.correo AS ,
t.ticket_id,
t.incidente_id,
t.fecha_apertura,
t.estado
FROM 
ACTIVIDADCLASE12.usuarios u
FULL OUTER JOIN 
ACTIVIDADCLASE12.tickets t ON 
u.usuario_id = t.usuario_id;

/*Muestra todos los incidentes y tickets, para ver qué incidentes tienen tickets y cuáles
no, o qué tickets están asociados a incidentes que podrían no existir.*/
SELECT 
i.incidente_id,
i.descripcion,
i.criticidad,
t.ticket_id,
t.usuario_id,
t.fecha_apertura,
t.estado
FROM 
ACTIVIDADCLASE12.incidentes i
FULL OUTER JOIN 
ACTIVIDADCLASE12.tickets t ON 
i.incidente_id = t.incidente_id;

/*Muestra todas las soluciones y chats, aunque no tengan relación directa, para
revisar integridad.*/
SELECT 
    s.solucion_id,
    s.solucion_texto AS descripcion_solucion,
    s.aplicada_por,
    s.fecha,
    c.chat_id,
    c.mensaje,
    c.quien,
    c.fecha
FROM 
ACTIVIDADCLASE12.soluciones s
FULL OUTER JOIN 
ACTIVIDADCLASE12.tickets t ON 
s.ticket_id = t.ticket_id
FULL OUTER JOIN
ACTIVIDADCLASE12.chat_ia c ON
c.ticket_id = t.ticket_id;

SELECT * FROM ACTIVIDADCLASE12.chat_ia;
SELECT * FROM ACTIVIDADCLASE12.soluciones;

SELECT * FROM ACTIVIDADCLASE12.tickets;