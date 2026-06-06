-- ============================================================
--  SISTEMA DE MONITOREO - ALERTAS DBA
--  Base de datos: bolsa_trabajo (MySQL 8.0)
--  Descripción : Tabla de registro de alertas + 5 procedimientos
--                almacenados que evalúan umbrales críticos y
--                registran alertas accionables para el DBA.
--  Umbrales     : WARNING = 85 %   |   CRÍTICO = 95 %
-- ============================================================

USE bolsa_trabajo;

-- ------------------------------------------------------------
-- 1. TABLA CENTRAL DE ALERTAS
--    Repositorio donde todos los procedimientos escriben sus
--    hallazgos. El DBA la consulta (o la monitorea externamente)
--    para ver el estado del sistema.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS dba_alertas (
    alerta_id     INT          NOT NULL AUTO_INCREMENT,
    tipo_alerta   VARCHAR(50)  NOT NULL COMMENT 'Categoría: ESPACIO, BLOQUEO, ACCESO, SESIONES, TABLA_GRANDE',
    nivel         VARCHAR(10)  NOT NULL COMMENT 'INFO | WARNING | CRITICO',
    mensaje       TEXT         NOT NULL COMMENT 'Descripción legible del problema',
    detalle       TEXT             NULL COMMENT 'JSON o texto extra con métricas',
    fecha_alerta  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atendida      TINYINT(1)   NOT NULL DEFAULT 0 COMMENT '0=pendiente, 1=atendida',
    atendida_por  VARCHAR(100)     NULL,
    fecha_atencion DATETIME        NULL,
    PRIMARY KEY (alerta_id),
    INDEX idx_nivel       (nivel),
    INDEX idx_tipo        (tipo_alerta),
    INDEX idx_fecha       (fecha_alerta),
    INDEX idx_atendida    (atendida)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COMMENT='Registro centralizado de alertas DBA - bolsa_trabajo';


-- ============================================================
-- ALERTA 1 – USO DE DISCO POR BASE DE DATOS
--   Evalúa el tamaño total de la BD contra un límite configurable.
--   En MySQL puro no existe acceso directo a la partición del SO,
--   pero sí podemos medir el crecimiento de datos e índices en
--   information_schema, que es la fuente disponible dentro del motor.
-- ============================================================
DROP PROCEDURE IF EXISTS sp_alerta_espacio_bd;

DELIMITER $$
CREATE PROCEDURE sp_alerta_espacio_bd()
BEGIN
    -- Límite configurado (ajustar según el servidor real)
    DECLARE v_limite_warning_mb  DECIMAL(10,2) DEFAULT 500.00;  -- 500 MB → WARNING
    DECLARE v_limite_critico_mb  DECIMAL(10,2) DEFAULT 800.00;  -- 800 MB → CRÍTICO

    DECLARE v_total_mb  DECIMAL(10,2);
    DECLARE v_pct       DECIMAL(5,2);
    DECLARE v_nivel     VARCHAR(10);
    DECLARE v_msg       TEXT;

    -- Tamaño real de datos + índices en MB
    SELECT ROUND(SUM(data_length + index_length) / 1024 / 1024, 2)
      INTO v_total_mb
      FROM information_schema.TABLES
     WHERE table_schema = 'bolsa_trabajo';

    SET v_pct = ROUND((v_total_mb / v_limite_critico_mb) * 100, 2);

    IF v_total_mb >= v_limite_critico_mb THEN
        SET v_nivel = 'CRITICO';
        SET v_msg   = CONCAT('Espacio BD crítico: ', v_total_mb, ' MB utilizados (',
                             v_pct, '% del límite de ', v_limite_critico_mb, ' MB).');
    ELSEIF v_total_mb >= v_limite_warning_mb THEN
        SET v_nivel = 'WARNING';
        SET v_pct   = ROUND((v_total_mb / v_limite_warning_mb) * 100, 2);
        SET v_msg   = CONCAT('Espacio BD en advertencia: ', v_total_mb, ' MB utilizados (',
                             v_pct, '% del límite de ', v_limite_warning_mb, ' MB).');
    ELSE
        SET v_nivel = 'INFO';
        SET v_msg   = CONCAT('Espacio BD normal: ', v_total_mb, ' MB utilizados.');
    END IF;

    -- Solo insertar si es WARNING o CRÍTICO, o si no existe alerta INFO reciente
    IF v_nivel IN ('WARNING', 'CRITICO') THEN
        INSERT INTO dba_alertas (tipo_alerta, nivel, mensaje, detalle)
        VALUES (
            'ESPACIO',
            v_nivel,
            v_msg,
            JSON_OBJECT(
                'total_mb',      v_total_mb,
                'limite_mb',     v_limite_critico_mb,
                'porcentaje',    v_pct,
                'base_datos',    'bolsa_trabajo'
            )
        );
    END IF;
END$$
DELIMITER ;


-- ============================================================
-- ALERTA 2 – TABLAS CON CRECIMIENTO EXCESIVO DE FRAGMENTACIÓN
--   Detecta tablas cuyo data_free supera el 85 % del tamaño
--   de los datos: señal de que necesitan OPTIMIZE TABLE urgente.
-- ============================================================
DROP PROCEDURE IF EXISTS sp_alerta_fragmentacion;

DELIMITER $$
CREATE PROCEDURE sp_alerta_fragmentacion()
BEGIN
    DECLARE v_tabla   VARCHAR(100);
    DECLARE v_pct     DECIMAL(5,2);
    DECLARE v_libre   BIGINT;
    DECLARE v_datos   BIGINT;
    DECLARE v_done    INT DEFAULT 0;

    DECLARE cur_frags CURSOR FOR
        SELECT table_name,
               data_free,
               data_length + index_length AS total_size,
               ROUND(data_free / NULLIF(data_length + index_length, 0) * 100, 2) AS pct_libre
          FROM information_schema.TABLES
         WHERE table_schema = 'bolsa_trabajo'
           AND engine       = 'InnoDB'
           AND (data_length + index_length) > 0
           AND ROUND(data_free / NULLIF(data_length + index_length, 0) * 100, 2) >= 85
         ORDER BY pct_libre DESC;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;

    OPEN cur_frags;
    loop_frags: LOOP
        FETCH cur_frags INTO v_tabla, v_libre, v_datos, v_pct;
        IF v_done = 1 THEN LEAVE loop_frags; END IF;

        INSERT INTO dba_alertas (tipo_alerta, nivel, mensaje, detalle)
        VALUES (
            'FRAGMENTACION',
            IF(v_pct >= 95, 'CRITICO', 'WARNING'),
            CONCAT('Tabla `', v_tabla, '` fragmentada al ', v_pct,
                   '%. Ejecutar: OPTIMIZE TABLE bolsa_trabajo.', v_tabla),
            JSON_OBJECT(
                'tabla',       v_tabla,
                'data_free_kb', ROUND(v_libre/1024, 1),
                'total_kb',     ROUND(v_datos/1024, 1),
                'pct_libre',    v_pct
            )
        );
    END LOOP;
    CLOSE cur_frags;
END$$
DELIMITER ;


-- ============================================================
-- ALERTA 3 – SESIONES BLOQUEANTES (BLOQUEOS / DEADLOCKS)
--   Detecta procesos en estado 'Locked' o 'waiting' que llevan
--   más de 60 segundos activos, señal de sesión bloqueante.
-- ============================================================
DROP PROCEDURE IF EXISTS sp_alerta_bloqueos;

DELIMITER $$
CREATE PROCEDURE sp_alerta_bloqueos()
BEGIN
    DECLARE v_count      INT;
    DECLARE v_detalle    TEXT;

    -- Sesiones bloqueantes con más de 60 s de espera
    SELECT COUNT(*),
           GROUP_CONCAT(
               CONCAT('ID:', id, ' User:', user, ' Host:', host,
                      ' DB:', IFNULL(db,'?'), ' Time:', time, 's ',
                      ' State:', IFNULL(state,''), ' Info:', LEFT(IFNULL(info,''),80))
               ORDER BY time DESC
               SEPARATOR ' || '
           )
      INTO v_count, v_detalle
      FROM information_schema.PROCESSLIST
     WHERE command != 'Sleep'
       AND time    >= 60
       AND id      != CONNECTION_ID();

    IF v_count > 0 THEN
        INSERT INTO dba_alertas (tipo_alerta, nivel, mensaje, detalle)
        VALUES (
            'BLOQUEO',
            IF(v_count >= 5, 'CRITICO', 'WARNING'),
            CONCAT(v_count, ' sesión(es) con queries lentos/bloqueantes (>= 60 s). ',
                   'Revisar y considerar KILL de procesos afectados.'),
            JSON_OBJECT('total_bloqueantes', v_count, 'procesos', v_detalle)
        );
    END IF;

    -- Detectar lock waits en InnoDB
    SELECT COUNT(*) INTO v_count
      FROM information_schema.INNODB_TRX
     WHERE trx_wait_started IS NOT NULL
       AND TIMESTAMPDIFF(SECOND, trx_wait_started, NOW()) >= 30;

    IF v_count > 0 THEN
        INSERT INTO dba_alertas (tipo_alerta, nivel, mensaje, detalle)
        VALUES (
            'BLOQUEO',
            IF(v_count >= 3, 'CRITICO', 'WARNING'),
            CONCAT(v_count, ' transacción(es) InnoDB en espera de lock >= 30 s. ',
                   'Posible deadlock en curso.'),
            JSON_OBJECT('trx_en_espera', v_count)
        );
    END IF;
END$$
DELIMITER ;


-- ============================================================
-- ALERTA 4 – ACCESOS DENEGADOS (intentos fallidos de login)
--   Consulta el historial de la tabla django_admin_log buscando
--   actividad sospechosa, y también evalúa el crecimiento de
--   sesiones de usuarios inactivos acumuladas en django_session.
-- ============================================================
DROP PROCEDURE IF EXISTS sp_alerta_accesos_denegados;

DELIMITER $$
CREATE PROCEDURE sp_alerta_accesos_denegados()
BEGIN
    DECLARE v_sesiones_expiradas INT;
    DECLARE v_logs_recientes     INT;

    -- Sesiones expiradas no depuradas (acumulación = riesgo de seguridad)
    SELECT COUNT(*)
      INTO v_sesiones_expiradas
      FROM django_session
     WHERE expire_date < NOW();

    IF v_sesiones_expiradas >= 500 THEN
        INSERT INTO dba_alertas (tipo_alerta, nivel, mensaje, detalle)
        VALUES (
            'ACCESO',
            IF(v_sesiones_expiradas >= 2000, 'CRITICO', 'WARNING'),
            CONCAT('Acumulación de sesiones expiradas: ', v_sesiones_expiradas,
                   ' registros en django_session. ',
                   'Riesgo de escalada de tamaño y vectores de ataque por sesión.'),
            JSON_OBJECT('sesiones_expiradas', v_sesiones_expiradas)
        );
    END IF;

    -- Actividad masiva en admin log (más de 200 cambios en las últimas 2 horas)
    SELECT COUNT(*)
      INTO v_logs_recientes
      FROM django_admin_log
     WHERE action_time >= NOW() - INTERVAL 2 HOUR;

    IF v_logs_recientes > 200 THEN
        INSERT INTO dba_alertas (tipo_alerta, nivel, mensaje, detalle)
        VALUES (
            'ACCESO',
            'WARNING',
            CONCAT('Actividad administrativa inusual: ', v_logs_recientes,
                   ' acciones registradas en django_admin_log en las últimas 2 horas. ',
                   'Verificar posible acceso no autorizado.'),
            JSON_OBJECT('logs_2h', v_logs_recientes)
        );
    END IF;
END$$
DELIMITER ;


-- ============================================================
-- ALERTA 5 – EXCESO DE CONEXIONES SIMULTÁNEAS
--   Compara el número de conexiones activas contra max_connections.
--   Umbrales: 85 % → WARNING, 95 % → CRÍTICO.
-- ============================================================
DROP PROCEDURE IF EXISTS sp_alerta_conexiones;

DELIMITER $$
CREATE PROCEDURE sp_alerta_conexiones()
BEGIN
    DECLARE v_max_conn    INT;
    DECLARE v_activas     INT;
    DECLARE v_pct         DECIMAL(5,2);
    DECLARE v_dormidas    INT;

    -- Máximo de conexiones configurado en el servidor
    SELECT VARIABLE_VALUE INTO v_max_conn
      FROM performance_schema.global_variables
     WHERE VARIABLE_NAME = 'max_connections';

    -- Conexiones activas actualmente
    SELECT COUNT(*) INTO v_activas
      FROM information_schema.PROCESSLIST;

    -- Conexiones dormidas (Sleep) que consumen slot pero no hacen trabajo
    SELECT COUNT(*) INTO v_dormidas
      FROM information_schema.PROCESSLIST
     WHERE command = 'Sleep';

    SET v_pct = ROUND((v_activas / v_max_conn) * 100, 2);

    IF v_pct >= 95 THEN
        INSERT INTO dba_alertas (tipo_alerta, nivel, mensaje, detalle)
        VALUES (
            'CONEXIONES',
            'CRITICO',
            CONCAT('Conexiones críticas: ', v_activas, ' de ', v_max_conn,
                   ' (', v_pct, '%). Riesgo de rechazo de nuevas conexiones.'),
            JSON_OBJECT('activas', v_activas, 'max', v_max_conn,
                        'porcentaje', v_pct, 'dormidas', v_dormidas)
        );
    ELSEIF v_pct >= 85 THEN
        INSERT INTO dba_alertas (tipo_alerta, nivel, mensaje, detalle)
        VALUES (
            'CONEXIONES',
            'WARNING',
            CONCAT('Conexiones en advertencia: ', v_activas, ' de ', v_max_conn,
                   ' (', v_pct, '%). Revisar conexiones dormidas: ', v_dormidas, '.'),
            JSON_OBJECT('activas', v_activas, 'max', v_max_conn,
                        'porcentaje', v_pct, 'dormidas', v_dormidas)
        );
    END IF;
END$$
DELIMITER ;


-- ============================================================
-- PROCEDIMIENTO MAESTRO: EJECUTAR TODAS LAS ALERTAS
--   Llamar desde un EVENT periódico o manualmente para obtener
--   el estado completo del sistema en un solo disparo.
-- ============================================================
DROP PROCEDURE IF EXISTS sp_evaluar_todas_alertas;

DELIMITER $$
CREATE PROCEDURE sp_evaluar_todas_alertas()
BEGIN
    CALL sp_alerta_espacio_bd();
    CALL sp_alerta_fragmentacion();
    CALL sp_alerta_bloqueos();
    CALL sp_alerta_accesos_denegados();
    CALL sp_alerta_conexiones();
END$$
DELIMITER ;


-- ============================================================
-- EVENT: EVALUACIÓN AUTOMÁTICA CADA 15 MINUTOS
--   Requiere que el Event Scheduler esté activo:
--     SET GLOBAL event_scheduler = ON;
-- ============================================================
DROP EVENT IF EXISTS evt_evaluar_alertas;

DELIMITER $$
CREATE EVENT evt_evaluar_alertas
    ON SCHEDULE EVERY 15 MINUTE
    STARTS CURRENT_TIMESTAMP
    ON COMPLETION PRESERVE
    ENABLE
    COMMENT 'Evalúa todas las alertas DBA cada 15 minutos'
DO
BEGIN
    CALL sp_evaluar_todas_alertas();
END$$
DELIMITER ;


-- ============================================================
-- CONSULTA RÁPIDA PARA EL DBA
--   Ver las últimas alertas no atendidas, ordenadas por criticidad
-- ============================================================
-- SELECT tipo_alerta, nivel, mensaje, fecha_alerta
--   FROM dba_alertas
--  WHERE atendida = 0
--  ORDER BY FIELD(nivel,'CRITICO','WARNING','INFO'), fecha_alerta DESC
--  LIMIT 50;
