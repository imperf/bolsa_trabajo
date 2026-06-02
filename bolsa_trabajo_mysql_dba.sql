-- ============================================================
-- BOLSA DE TRABAJO — TRIGGERS Y JOBS
-- ============================================================
-- CONTENIDO:
--   1 — Columnas de auditoría en 5 tablas críticas
--   2 — Tablas históricas (5 tablas críticas)
--   3 — Triggers de auditoría (creado_por / modificado_por)
--   4 — Triggers históricos (UPDATE / DELETE → histórico)
--   5 — Eventos de mantenimiento DBA
-- ============================================================

USE bolsa_trabajo;

-- ============================================================
-- 1 — COLUMNAS DE AUDITORÍA
-- Tablas críticas: usuarios, candidato, oferta, postulacion, empresa
-- ============================================================

ALTER TABLE `usuarios`
  ADD COLUMN `creado_por`          VARCHAR(100) DEFAULT NULL,
  ADD COLUMN `fecha_creacion`       DATETIME     DEFAULT NULL,
  ADD COLUMN `modificado_por`       VARCHAR(100) DEFAULT NULL,
  ADD COLUMN `fecha_modificacion`   DATETIME     DEFAULT NULL;

ALTER TABLE `candidato`
  ADD COLUMN `creado_por`          VARCHAR(100) DEFAULT NULL,
  ADD COLUMN `fecha_creacion`       DATETIME     DEFAULT NULL,
  ADD COLUMN `modificado_por`       VARCHAR(100) DEFAULT NULL,
  ADD COLUMN `fecha_modificacion`   DATETIME     DEFAULT NULL;

ALTER TABLE `oferta`
  ADD COLUMN `creado_por`          VARCHAR(100) DEFAULT NULL,
  ADD COLUMN `fecha_creacion`       DATETIME     DEFAULT NULL,
  ADD COLUMN `modificado_por`       VARCHAR(100) DEFAULT NULL,
  ADD COLUMN `fecha_modificacion`   DATETIME     DEFAULT NULL;

ALTER TABLE `postulacion`
  ADD COLUMN `creado_por`          VARCHAR(100) DEFAULT NULL,
  ADD COLUMN `fecha_creacion`       DATETIME     DEFAULT NULL,
  ADD COLUMN `modificado_por`       VARCHAR(100) DEFAULT NULL,
  ADD COLUMN `fecha_modificacion`   DATETIME     DEFAULT NULL;

ALTER TABLE `empresa`
  ADD COLUMN `creado_por`          VARCHAR(100) DEFAULT NULL,
  ADD COLUMN `fecha_creacion`       DATETIME     DEFAULT NULL,
  ADD COLUMN `modificado_por`       VARCHAR(100) DEFAULT NULL,
  ADD COLUMN `fecha_modificacion`   DATETIME     DEFAULT NULL;


-- ============================================================
-- 2 — TABLAS HISTÓRICAS
-- ============================================================

CREATE TABLE IF NOT EXISTS `hist_usuarios` (
  `hist_id`            INT          NOT NULL AUTO_INCREMENT,
  `accion`             VARCHAR(10)  NOT NULL COMMENT 'UPDATE o DELETE',
  `fecha_accion`       DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_accion`     VARCHAR(100) DEFAULT NULL,
  `usuario_id`         INT          DEFAULT NULL,
  `nombre`             VARCHAR(100) DEFAULT NULL,
  `correo`             VARCHAR(100) DEFAULT NULL,
  `contrasenia`        VARCHAR(255) DEFAULT NULL,
  `tipo_id`            INT          DEFAULT NULL,
  `creado_por`         VARCHAR(100) DEFAULT NULL,
  `fecha_creacion`     DATETIME     DEFAULT NULL,
  `modificado_por`     VARCHAR(100) DEFAULT NULL,
  `fecha_modificacion` DATETIME     DEFAULT NULL,
  PRIMARY KEY (`hist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `hist_candidato` (
  `hist_id`            INT          NOT NULL AUTO_INCREMENT,
  `accion`             VARCHAR(10)  NOT NULL,
  `fecha_accion`       DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_accion`     VARCHAR(100) DEFAULT NULL,
  `candidato_id`       INT          DEFAULT NULL,
  `usuario_id`         INT          DEFAULT NULL,
  `nombre_completo`    VARCHAR(100) DEFAULT NULL,
  `dui`                VARCHAR(20)  DEFAULT NULL,
  `telefono`           VARCHAR(20)  DEFAULT NULL,
  `area_interes`       VARCHAR(100) DEFAULT NULL,
  `creado_por`         VARCHAR(100) DEFAULT NULL,
  `fecha_creacion`     DATETIME     DEFAULT NULL,
  `modificado_por`     VARCHAR(100) DEFAULT NULL,
  `fecha_modificacion` DATETIME     DEFAULT NULL,
  PRIMARY KEY (`hist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `hist_oferta` (
  `hist_id`                INT           NOT NULL AUTO_INCREMENT,
  `accion`                 VARCHAR(10)   NOT NULL,
  `fecha_accion`           DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_accion`         VARCHAR(100)  DEFAULT NULL,
  `oferta_id`              INT           DEFAULT NULL,
  `empresa_id`             INT           DEFAULT NULL,
  `puesto`                 VARCHAR(100)  DEFAULT NULL,
  `descripcion`            TEXT          DEFAULT NULL,
  `requisitos`             TEXT          DEFAULT NULL,
  `experiencia_requerida`  VARCHAR(100)  DEFAULT NULL,
  `ubicacion`              VARCHAR(100)  DEFAULT NULL,
  `tipo_contrato`          VARCHAR(50)   DEFAULT NULL,
  `vacantes`               INT           DEFAULT NULL,
  `salario`                DECIMAL(10,2) DEFAULT NULL,
  `fecha_limite`           DATE          DEFAULT NULL,
  `creado_por`             VARCHAR(100)  DEFAULT NULL,
  `fecha_creacion`         DATETIME      DEFAULT NULL,
  `modificado_por`         VARCHAR(100)  DEFAULT NULL,
  `fecha_modificacion`     DATETIME      DEFAULT NULL,
  PRIMARY KEY (`hist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `hist_postulacion` (
  `hist_id`            INT          NOT NULL AUTO_INCREMENT,
  `accion`             VARCHAR(10)  NOT NULL,
  `fecha_accion`       DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_accion`     VARCHAR(100) DEFAULT NULL,
  `postulacion_id`     INT          DEFAULT NULL,
  `candidato_id`       INT          DEFAULT NULL,
  `oferta_id`          INT          DEFAULT NULL,
  `estado_id`          INT          DEFAULT NULL,
  `fecha_postulacion`  DATE         DEFAULT NULL,
  `creado_por`         VARCHAR(100) DEFAULT NULL,
  `fecha_creacion`     DATETIME     DEFAULT NULL,
  `modificado_por`     VARCHAR(100) DEFAULT NULL,
  `fecha_modificacion` DATETIME     DEFAULT NULL,
  PRIMARY KEY (`hist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `hist_empresa` (
  `hist_id`            INT          NOT NULL AUTO_INCREMENT,
  `accion`             VARCHAR(10)  NOT NULL,
  `fecha_accion`       DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_accion`     VARCHAR(100) DEFAULT NULL,
  `empresa_id`         INT          DEFAULT NULL,
  `nombre`             VARCHAR(100) DEFAULT NULL,
  `correo`             VARCHAR(100) DEFAULT NULL,
  `persona_contacto`   VARCHAR(100) DEFAULT NULL,
  `direccion`          VARCHAR(150) DEFAULT NULL,
  `sector_id`          INT          DEFAULT NULL,
  `creado_por`         VARCHAR(100) DEFAULT NULL,
  `fecha_creacion`     DATETIME     DEFAULT NULL,
  `modificado_por`     VARCHAR(100) DEFAULT NULL,
  `fecha_modificacion` DATETIME     DEFAULT NULL,
  PRIMARY KEY (`hist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ============================================================
-- 3 — TRIGGERS DE AUDITORÍA
-- BEFORE INSERT → rellena creado_por + fecha_creacion
-- BEFORE UPDATE → rellena modificado_por + fecha_modificacion
-- ============================================================

-- ----- usuarios -----
DROP TRIGGER IF EXISTS trg_audit_usuarios_insert;
DELIMITER $$
CREATE TRIGGER trg_audit_usuarios_insert
BEFORE INSERT ON usuarios
FOR EACH ROW
BEGIN
  SET NEW.creado_por     = USER();
  SET NEW.fecha_creacion = NOW();
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_audit_usuarios_update;
DELIMITER $$
CREATE TRIGGER trg_audit_usuarios_update
BEFORE UPDATE ON usuarios
FOR EACH ROW
BEGIN
  SET NEW.modificado_por     = USER();
  SET NEW.fecha_modificacion = NOW();
END$$
DELIMITER ;

-- ----- candidato -----
DROP TRIGGER IF EXISTS trg_audit_candidato_insert;
DELIMITER $$
CREATE TRIGGER trg_audit_candidato_insert
BEFORE INSERT ON candidato
FOR EACH ROW
BEGIN
  SET NEW.creado_por     = USER();
  SET NEW.fecha_creacion = NOW();
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_audit_candidato_update;
DELIMITER $$
CREATE TRIGGER trg_audit_candidato_update
BEFORE UPDATE ON candidato
FOR EACH ROW
BEGIN
  SET NEW.modificado_por     = USER();
  SET NEW.fecha_modificacion = NOW();
END$$
DELIMITER ;

-- ----- oferta -----
DROP TRIGGER IF EXISTS trg_audit_oferta_insert;
DELIMITER $$
CREATE TRIGGER trg_audit_oferta_insert
BEFORE INSERT ON oferta
FOR EACH ROW
BEGIN
  SET NEW.creado_por     = USER();
  SET NEW.fecha_creacion = NOW();
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_audit_oferta_update;
DELIMITER $$
CREATE TRIGGER trg_audit_oferta_update
BEFORE UPDATE ON oferta
FOR EACH ROW
BEGIN
  SET NEW.modificado_por     = USER();
  SET NEW.fecha_modificacion = NOW();
END$$
DELIMITER ;

-- ----- postulacion -----
DROP TRIGGER IF EXISTS trg_audit_postulacion_insert;
DELIMITER $$
CREATE TRIGGER trg_audit_postulacion_insert
BEFORE INSERT ON postulacion
FOR EACH ROW
BEGIN
  SET NEW.creado_por     = USER();
  SET NEW.fecha_creacion = NOW();
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_audit_postulacion_update;
DELIMITER $$
CREATE TRIGGER trg_audit_postulacion_update
BEFORE UPDATE ON postulacion
FOR EACH ROW
BEGIN
  SET NEW.modificado_por     = USER();
  SET NEW.fecha_modificacion = NOW();
END$$
DELIMITER ;

-- ----- empresa -----
DROP TRIGGER IF EXISTS trg_audit_empresa_insert;
DELIMITER $$
CREATE TRIGGER trg_audit_empresa_insert
BEFORE INSERT ON empresa
FOR EACH ROW
BEGIN
  SET NEW.creado_por     = USER();
  SET NEW.fecha_creacion = NOW();
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_audit_empresa_update;
DELIMITER $$
CREATE TRIGGER trg_audit_empresa_update
BEFORE UPDATE ON empresa
FOR EACH ROW
BEGIN
  SET NEW.modificado_por     = USER();
  SET NEW.fecha_modificacion = NOW();
END$$
DELIMITER ;


-- ============================================================
-- 4 — TRIGGERS HISTÓRICOS
-- AFTER UPDATE  → copia OLD a la tabla hist_*
-- BEFORE DELETE → copia OLD a la tabla hist_*
-- ============================================================

-- ----- hist_usuarios -----
DROP TRIGGER IF EXISTS trg_hist_usuarios_update;
DELIMITER $$
CREATE TRIGGER trg_hist_usuarios_update
AFTER UPDATE ON usuarios
FOR EACH ROW
BEGIN
  INSERT INTO hist_usuarios (
    accion, fecha_accion, usuario_accion,
    usuario_id, nombre, correo, contrasenia, tipo_id,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  ) VALUES (
    'UPDATE', NOW(), USER(),
    OLD.usuario_id, OLD.nombre, OLD.correo, OLD.contrasenia, OLD.tipo_id,
    OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion
  );
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_hist_usuarios_delete;
DELIMITER $$
CREATE TRIGGER trg_hist_usuarios_delete
BEFORE DELETE ON usuarios
FOR EACH ROW
BEGIN
  INSERT INTO hist_usuarios (
    accion, fecha_accion, usuario_accion,
    usuario_id, nombre, correo, contrasenia, tipo_id,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  ) VALUES (
    'DELETE', NOW(), USER(),
    OLD.usuario_id, OLD.nombre, OLD.correo, OLD.contrasenia, OLD.tipo_id,
    OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion
  );
END$$
DELIMITER ;

-- ----- hist_candidato -----
DROP TRIGGER IF EXISTS trg_hist_candidato_update;
DELIMITER $$
CREATE TRIGGER trg_hist_candidato_update
AFTER UPDATE ON candidato
FOR EACH ROW
BEGIN
  INSERT INTO hist_candidato (
    accion, fecha_accion, usuario_accion,
    candidato_id, usuario_id, nombre_completo, dui, telefono, area_interes,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  ) VALUES (
    'UPDATE', NOW(), USER(),
    OLD.candidato_id, OLD.usuario_id, OLD.nombre_completo,
    OLD.dui, OLD.telefono, OLD.area_interes,
    OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion
  );
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_hist_candidato_delete;
DELIMITER $$
CREATE TRIGGER trg_hist_candidato_delete
BEFORE DELETE ON candidato
FOR EACH ROW
BEGIN
  INSERT INTO hist_candidato (
    accion, fecha_accion, usuario_accion,
    candidato_id, usuario_id, nombre_completo, dui, telefono, area_interes,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  ) VALUES (
    'DELETE', NOW(), USER(),
    OLD.candidato_id, OLD.usuario_id, OLD.nombre_completo,
    OLD.dui, OLD.telefono, OLD.area_interes,
    OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion
  );
END$$
DELIMITER ;

-- ----- hist_oferta -----
DROP TRIGGER IF EXISTS trg_hist_oferta_update;
DELIMITER $$
CREATE TRIGGER trg_hist_oferta_update
AFTER UPDATE ON oferta
FOR EACH ROW
BEGIN
  INSERT INTO hist_oferta (
    accion, fecha_accion, usuario_accion,
    oferta_id, empresa_id, puesto, descripcion, requisitos,
    experiencia_requerida, ubicacion, tipo_contrato,
    vacantes, salario, fecha_limite,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  ) VALUES (
    'UPDATE', NOW(), USER(),
    OLD.oferta_id, OLD.empresa_id, OLD.puesto, OLD.descripcion, OLD.requisitos,
    OLD.experiencia_requerida, OLD.ubicacion, OLD.tipo_contrato,
    OLD.vacantes, OLD.salario, OLD.fecha_limite,
    OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion
  );
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_hist_oferta_delete;
DELIMITER $$
CREATE TRIGGER trg_hist_oferta_delete
BEFORE DELETE ON oferta
FOR EACH ROW
BEGIN
  INSERT INTO hist_oferta (
    accion, fecha_accion, usuario_accion,
    oferta_id, empresa_id, puesto, descripcion, requisitos,
    experiencia_requerida, ubicacion, tipo_contrato,
    vacantes, salario, fecha_limite,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  ) VALUES (
    'DELETE', NOW(), USER(),
    OLD.oferta_id, OLD.empresa_id, OLD.puesto, OLD.descripcion, OLD.requisitos,
    OLD.experiencia_requerida, OLD.ubicacion, OLD.tipo_contrato,
    OLD.vacantes, OLD.salario, OLD.fecha_limite,
    OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion
  );
END$$
DELIMITER ;

-- ----- hist_postulacion -----
DROP TRIGGER IF EXISTS trg_hist_postulacion_update;
DELIMITER $$
CREATE TRIGGER trg_hist_postulacion_update
AFTER UPDATE ON postulacion
FOR EACH ROW
BEGIN
  INSERT INTO hist_postulacion (
    accion, fecha_accion, usuario_accion,
    postulacion_id, candidato_id, oferta_id, estado_id, fecha_postulacion,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  ) VALUES (
    'UPDATE', NOW(), USER(),
    OLD.postulacion_id, OLD.candidato_id, OLD.oferta_id,
    OLD.estado_id, OLD.fecha_postulacion,
    OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion
  );
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_hist_postulacion_delete;
DELIMITER $$
CREATE TRIGGER trg_hist_postulacion_delete
BEFORE DELETE ON postulacion
FOR EACH ROW
BEGIN
  INSERT INTO hist_postulacion (
    accion, fecha_accion, usuario_accion,
    postulacion_id, candidato_id, oferta_id, estado_id, fecha_postulacion,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  ) VALUES (
    'DELETE', NOW(), USER(),
    OLD.postulacion_id, OLD.candidato_id, OLD.oferta_id,
    OLD.estado_id, OLD.fecha_postulacion,
    OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion
  );
END$$
DELIMITER ;

-- ----- hist_empresa -----
DROP TRIGGER IF EXISTS trg_hist_empresa_update;
DELIMITER $$
CREATE TRIGGER trg_hist_empresa_update
AFTER UPDATE ON empresa
FOR EACH ROW
BEGIN
  INSERT INTO hist_empresa (
    accion, fecha_accion, usuario_accion,
    empresa_id, nombre, correo, persona_contacto, direccion, sector_id,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  ) VALUES (
    'UPDATE', NOW(), USER(),
    OLD.empresa_id, OLD.nombre, OLD.correo,
    OLD.persona_contacto, OLD.direccion, OLD.sector_id,
    OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion
  );
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_hist_empresa_delete;
DELIMITER $$
CREATE TRIGGER trg_hist_empresa_delete
BEFORE DELETE ON empresa
FOR EACH ROW
BEGIN
  INSERT INTO hist_empresa (
    accion, fecha_accion, usuario_accion,
    empresa_id, nombre, correo, persona_contacto, direccion, sector_id,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  ) VALUES (
    'DELETE', NOW(), USER(),
    OLD.empresa_id, OLD.nombre, OLD.correo,
    OLD.persona_contacto, OLD.direccion, OLD.sector_id,
    OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion
  );
END$$
DELIMITER ;


-- ============================================================
-- 5 — EVENTOS DE MANTENIMIENTO DBA
-- Requisito: SET GLOBAL event_scheduler = ON;
-- Verificar: SHOW VARIABLES LIKE 'event_scheduler';
-- ============================================================

SET GLOBAL event_scheduler = ON;

-- ---------------------------------------------------------
-- JOB 1 — Purga de notificaciones leídas antiguas
-- Frecuencia : diaria a la 01:00 AM
-- Por qué    : Evita que la tabla notificacion crezca sin
--              límite; las leídas con +60 días no tienen uso.
-- ---------------------------------------------------------
DROP EVENT IF EXISTS job_purgar_notificaciones;
DELIMITER $$
CREATE EVENT job_purgar_notificaciones
ON SCHEDULE EVERY 1 DAY
STARTS (DATE(NOW()) + INTERVAL 1 DAY + INTERVAL 1 HOUR)
DO
BEGIN
  DELETE FROM notificacion
  WHERE leido = 1
    AND fecha < (CURDATE() - INTERVAL 60 DAY);
END$$
DELIMITER ;

-- ---------------------------------------------------------
-- JOB 2 — Purga de registros históricos con más de 2 años
-- Frecuencia : mensual (día 1 del mes a las 02:00 AM)
-- Por qué    : Las tablas hist_* crecen con cada UPDATE/DELETE.
--              2 años cubre cualquier auditoría razonable;
--              más allá solo consume espacio en disco.
-- ---------------------------------------------------------
DROP EVENT IF EXISTS job_purgar_historicos;
DELIMITER $$
CREATE EVENT job_purgar_historicos
ON SCHEDULE EVERY 1 MONTH
STARTS (DATE_FORMAT(NOW() + INTERVAL 1 MONTH, '%Y-%m-01 02:00:00'))
DO
BEGIN
  DELETE FROM hist_usuarios    WHERE fecha_accion < (NOW() - INTERVAL 2 YEAR);
  DELETE FROM hist_candidato   WHERE fecha_accion < (NOW() - INTERVAL 2 YEAR);
  DELETE FROM hist_oferta      WHERE fecha_accion < (NOW() - INTERVAL 2 YEAR);
  DELETE FROM hist_postulacion WHERE fecha_accion < (NOW() - INTERVAL 2 YEAR);
  DELETE FROM hist_empresa     WHERE fecha_accion < (NOW() - INTERVAL 2 YEAR);
END$$
DELIMITER ;

-- ---------------------------------------------------------
-- JOB 3 — Optimización de tablas de alta rotación
-- Frecuencia : semanal (domingo a las 03:00 AM)
-- Por qué    : InnoDB no libera espacio físico tras DELETEs
--              masivos. OPTIMIZE TABLE reconstruye el tablespace
--              y desfragmenta índices, mejorando lecturas.
-- ---------------------------------------------------------
DROP EVENT IF EXISTS job_optimizar_tablas;
DELIMITER $$
CREATE EVENT job_optimizar_tablas
ON SCHEDULE EVERY 1 WEEK
STARTS (
  DATE(NOW())
  + INTERVAL (6 - WEEKDAY(NOW())) DAY
  + INTERVAL 3 HOUR
)
DO
BEGIN
  OPTIMIZE TABLE notificacion;
  OPTIMIZE TABLE postulacion;
  OPTIMIZE TABLE hist_postulacion;
  OPTIMIZE TABLE hist_oferta;
  OPTIMIZE TABLE hist_usuarios;
END$$
DELIMITER ;

-- ---------------------------------------------------------
-- JOB 4 — Matar conexiones durmientes (sleeping) largas
-- Frecuencia : cada 30 minutos
-- Por qué    : Conexiones en estado Sleep de +10 min bloquean
--              slots de max_connections y consumen memoria de
--              sesión sin hacer nada útil.
-- ---------------------------------------------------------

-- Procedimiento auxiliar (los eventos no admiten cursores directos)
DROP PROCEDURE IF EXISTS sp_kill_sleeping_connections;
DELIMITER $$
CREATE PROCEDURE sp_kill_sleeping_connections()
BEGIN
  DECLARE done   INT DEFAULT FALSE;
  DECLARE v_id   BIGINT;

  DECLARE cur CURSOR FOR
    SELECT ID
    FROM information_schema.PROCESSLIST
    WHERE COMMAND = 'Sleep'
      AND TIME    > 600
      AND USER   <> 'event_scheduler'
      AND USER   <> 'system user';

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur;
  loop_kill: LOOP
    FETCH cur INTO v_id;
    IF done THEN LEAVE loop_kill; END IF;
    KILL CONNECTION v_id;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

DROP EVENT IF EXISTS job_matar_conexiones_dormidas;
DELIMITER $$
CREATE EVENT job_matar_conexiones_dormidas
ON SCHEDULE EVERY 30 MINUTE
STARTS NOW()
DO
BEGIN
  CALL sp_kill_sleeping_connections();
END$$
DELIMITER ;

-- ---------------------------------------------------------
-- JOB 5 — Actualizar estadísticas del optimizador
-- Frecuencia : diaria a las 04:00 AM
-- Por qué    : Las estadísticas de cardinalidad guían al
--              optimizador al elegir índices. Si quedan
--              desactualizadas tras inserciones/borrados
--              masivos, el motor elige planes lentos.
--              ANALYZE TABLE las refresca sin bloquear lecturas.
-- ---------------------------------------------------------
DROP EVENT IF EXISTS job_actualizar_estadisticas;
DELIMITER $$
CREATE EVENT job_actualizar_estadisticas
ON SCHEDULE EVERY 1 DAY
STARTS (DATE(NOW()) + INTERVAL 1 DAY + INTERVAL 4 HOUR)
DO
BEGIN
  ANALYZE TABLE usuarios;
  ANALYZE TABLE candidato;
  ANALYZE TABLE oferta;
  ANALYZE TABLE postulacion;
  ANALYZE TABLE empresa;
  ANALYZE TABLE notificacion;
  ANALYZE TABLE hist_usuarios;
  ANALYZE TABLE hist_candidato;
  ANALYZE TABLE hist_oferta;
  ANALYZE TABLE hist_postulacion;
  ANALYZE TABLE hist_empresa;
END$$
DELIMITER ;

-- ============================================================
-- FIN DEL SCRIPT
-- ============================================================
