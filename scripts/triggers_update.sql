-- ============================================================================
-- empleos_triggers_update.sql
-- Tablas de auditoría (históricos) y triggers para Bolsa de Trabajo
-- Compatible con MySQL 8.0+
--
-- Uso:
--   mysql -u <usuario> -p'<password>' bolsa_trabajo < empleos_triggers_update.sql
--
-- Este script:
--   1. Agrega columnas de auditoría (creado_por, fecha_creacion, etc.) a las
--      tablas base si no existen.
--   2. Crea las tablas de historial (hist_*) si no existen.
--   3. Crea los triggers de auditoría e historial (elimina los previos).
-- ============================================================================

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- ============================================================================
-- PARTE 1: Agregar columnas de auditoría a tablas base (si no existen)
-- ============================================================================

-- auth_user
SET @col_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'auth_user' AND COLUMN_NAME = 'creado_por');
SET @sql = IF(@col_exists = 0,
    "ALTER TABLE `auth_user` ADD COLUMN `creado_por` varchar(100) DEFAULT NULL",
    "SELECT 'auth_user.creado_por ya existe' AS msg");
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'auth_user' AND COLUMN_NAME = 'fecha_creacion');
SET @sql = IF(@col_exists = 0,
    "ALTER TABLE `auth_user` ADD COLUMN `fecha_creacion` datetime DEFAULT NULL",
    "SELECT 'auth_user.fecha_creacion ya existe' AS msg");
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'auth_user' AND COLUMN_NAME = 'modificado_por');
SET @sql = IF(@col_exists = 0,
    "ALTER TABLE `auth_user` ADD COLUMN `modificado_por` varchar(100) DEFAULT NULL",
    "SELECT 'auth_user.modificado_por ya existe' AS msg");
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'auth_user' AND COLUMN_NAME = 'fecha_modificacion');
SET @sql = IF(@col_exists = 0,
    "ALTER TABLE `auth_user` ADD COLUMN `fecha_modificacion` datetime DEFAULT NULL",
    "SELECT 'auth_user.fecha_modificacion ya existe' AS msg");
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- empleos_empresa
SET @col_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'empleos_empresa' AND COLUMN_NAME = 'creado_por');
SET @sql = IF(@col_exists = 0,
    "ALTER TABLE `empleos_empresa` ADD COLUMN `creado_por` varchar(100) DEFAULT NULL",
    "SELECT 'empleos_empresa.creado_por ya existe' AS msg");
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'empleos_empresa' AND COLUMN_NAME = 'fecha_creacion');
SET @sql = IF(@col_exists = 0,
    "ALTER TABLE `empleos_empresa` ADD COLUMN `fecha_creacion` datetime DEFAULT NULL",
    "SELECT 'empleos_empresa.fecha_creacion ya existe' AS msg");
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'empleos_empresa' AND COLUMN_NAME = 'modificado_por');
SET @sql = IF(@col_exists = 0,
    "ALTER TABLE `empleos_empresa` ADD COLUMN `modificado_por` varchar(100) DEFAULT NULL",
    "SELECT 'empleos_empresa.modificado_por ya existe' AS msg");
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'empleos_empresa' AND COLUMN_NAME = 'fecha_modificacion');
SET @sql = IF(@col_exists = 0,
    "ALTER TABLE `empleos_empresa` ADD COLUMN `fecha_modificacion` datetime DEFAULT NULL",
    "SELECT 'empleos_empresa.fecha_modificacion ya existe' AS msg");
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- empleos_vacante
SET @col_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'empleos_vacante' AND COLUMN_NAME = 'creado_por');
SET @sql = IF(@col_exists = 0,
    "ALTER TABLE `empleos_vacante` ADD COLUMN `creado_por` varchar(100) DEFAULT NULL",
    "SELECT 'empleos_vacante.creado_por ya existe' AS msg");
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'empleos_vacante' AND COLUMN_NAME = 'fecha_creacion');
SET @sql = IF(@col_exists = 0,
    "ALTER TABLE `empleos_vacante` ADD COLUMN `fecha_creacion` datetime DEFAULT NULL",
    "SELECT 'empleos_vacante.fecha_creacion ya existe' AS msg");
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'empleos_vacante' AND COLUMN_NAME = 'modificado_por');
SET @sql = IF(@col_exists = 0,
    "ALTER TABLE `empleos_vacante` ADD COLUMN `modificado_por` varchar(100) DEFAULT NULL",
    "SELECT 'empleos_vacante.modificado_por ya existe' AS msg");
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'empleos_vacante' AND COLUMN_NAME = 'fecha_modificacion');
SET @sql = IF(@col_exists = 0,
    "ALTER TABLE `empleos_vacante` ADD COLUMN `fecha_modificacion` datetime DEFAULT NULL",
    "SELECT 'empleos_vacante.fecha_modificacion ya existe' AS msg");
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- empleos_candidato
SET @col_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'empleos_candidato' AND COLUMN_NAME = 'creado_por');
SET @sql = IF(@col_exists = 0,
    "ALTER TABLE `empleos_candidato` ADD COLUMN `creado_por` varchar(100) DEFAULT NULL",
    "SELECT 'empleos_candidato.creado_por ya existe' AS msg");
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'empleos_candidato' AND COLUMN_NAME = 'fecha_creacion');
SET @sql = IF(@col_exists = 0,
    "ALTER TABLE `empleos_candidato` ADD COLUMN `fecha_creacion` datetime DEFAULT NULL",
    "SELECT 'empleos_candidato.fecha_creacion ya existe' AS msg");
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'empleos_candidato' AND COLUMN_NAME = 'modificado_por');
SET @sql = IF(@col_exists = 0,
    "ALTER TABLE `empleos_candidato` ADD COLUMN `modificado_por` varchar(100) DEFAULT NULL",
    "SELECT 'empleos_candidato.modificado_por ya existe' AS msg");
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'empleos_candidato' AND COLUMN_NAME = 'fecha_modificacion');
SET @sql = IF(@col_exists = 0,
    "ALTER TABLE `empleos_candidato` ADD COLUMN `fecha_modificacion` datetime DEFAULT NULL",
    "SELECT 'empleos_candidato.fecha_modificacion ya existe' AS msg");
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- empleos_postulacion
SET @col_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'empleos_postulacion' AND COLUMN_NAME = 'creado_por');
SET @sql = IF(@col_exists = 0,
    "ALTER TABLE `empleos_postulacion` ADD COLUMN `creado_por` varchar(100) DEFAULT NULL",
    "SELECT 'empleos_postulacion.creado_por ya existe' AS msg");
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'empleos_postulacion' AND COLUMN_NAME = 'fecha_creacion');
SET @sql = IF(@col_exists = 0,
    "ALTER TABLE `empleos_postulacion` ADD COLUMN `fecha_creacion` datetime DEFAULT NULL",
    "SELECT 'empleos_postulacion.fecha_creacion ya existe' AS msg");
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'empleos_postulacion' AND COLUMN_NAME = 'modificado_por');
SET @sql = IF(@col_exists = 0,
    "ALTER TABLE `empleos_postulacion` ADD COLUMN `modificado_por` varchar(100) DEFAULT NULL",
    "SELECT 'empleos_postulacion.modificado_por ya existe' AS msg");
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @col_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'empleos_postulacion' AND COLUMN_NAME = 'fecha_modificacion');
SET @sql = IF(@col_exists = 0,
    "ALTER TABLE `empleos_postulacion` ADD COLUMN `fecha_modificacion` datetime DEFAULT NULL",
    "SELECT 'empleos_postulacion.fecha_modificacion ya existe' AS msg");
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;


-- ============================================================================
-- PARTE 2: Crear tablas de historial (si no existen)
-- ============================================================================

CREATE TABLE IF NOT EXISTS `hist_auth_user` (
  `hist_id` int NOT NULL AUTO_INCREMENT,
  `accion` varchar(10) NOT NULL COMMENT 'INSERT, UPDATE o DELETE',
  `fecha_accion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_accion` varchar(100) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `username` varchar(150) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `is_superuser` tinyint(1) DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`hist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `hist_empleos_empresa` (
  `hist_id` int NOT NULL AUTO_INCREMENT,
  `accion` varchar(10) NOT NULL COMMENT 'INSERT, UPDATE o DELETE',
  `fecha_accion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_accion` varchar(100) DEFAULT NULL,
  `empresa_id` bigint DEFAULT NULL,
  `nombre` varchar(150) DEFAULT NULL,
  `correo` varchar(254) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`hist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `hist_empleos_vacante` (
  `hist_id` int NOT NULL AUTO_INCREMENT,
  `accion` varchar(10) NOT NULL COMMENT 'INSERT, UPDATE o DELETE',
  `fecha_accion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_accion` varchar(100) DEFAULT NULL,
  `vacante_id` bigint DEFAULT NULL,
  `titulo` varchar(200) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `requisitos` longtext DEFAULT NULL,
  `experiencia` longtext DEFAULT NULL,
  `tipo_contrato` varchar(20) DEFAULT NULL,
  `numero_vacantes` int DEFAULT NULL,
  `categoria_id` bigint DEFAULT NULL,
  `empresa_id` bigint DEFAULT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  `ubicacion` varchar(150) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  `fecha_limite` date DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`hist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `hist_empleos_candidato` (
  `hist_id` int NOT NULL AUTO_INCREMENT,
  `accion` varchar(10) NOT NULL COMMENT 'INSERT, UPDATE o DELETE',
  `fecha_accion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_accion` varchar(100) DEFAULT NULL,
  `candidato_id` bigint DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `experiencia` text DEFAULT NULL,
  `dui` varchar(20) DEFAULT NULL,
  `area_interes` varchar(100) DEFAULT NULL,
  `estudios` text DEFAULT NULL,
  `habilidades` text DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`hist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `hist_empleos_postulacion` (
  `hist_id` int NOT NULL AUTO_INCREMENT,
  `accion` varchar(10) NOT NULL COMMENT 'INSERT, UPDATE o DELETE',
  `fecha_accion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_accion` varchar(100) DEFAULT NULL,
  `postulacion_id` bigint DEFAULT NULL,
  `candidato_id` bigint DEFAULT NULL,
  `vacante_id` bigint DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  `mensaje` text DEFAULT NULL,
  `fecha_postulacion` datetime(6) DEFAULT NULL,
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `modificado_por` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`hist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================================
-- PARTE 3: Crear triggers
-- ============================================================================

DELIMITER $$

-- ============================================================================
-- AUTH_USER: Triggers de auditoría (BEFORE)
-- ============================================================================

DROP TRIGGER IF EXISTS `trg_audit_auth_user_insert`$$
CREATE TRIGGER `trg_audit_auth_user_insert`
BEFORE INSERT ON `auth_user`
FOR EACH ROW
BEGIN
  SET NEW.creado_por = USER();
  SET NEW.fecha_creacion = NOW();
END
$$

DROP TRIGGER IF EXISTS `trg_audit_auth_user_update`$$
CREATE TRIGGER `trg_audit_auth_user_update`
BEFORE UPDATE ON `auth_user`
FOR EACH ROW
BEGIN
  SET NEW.modificado_por = USER();
  SET NEW.fecha_modificacion = NOW();
END
$$

-- ============================================================================
-- AUTH_USER: Triggers de historial (AFTER INSERT, AFTER UPDATE, BEFORE DELETE)
-- ============================================================================

DROP TRIGGER IF EXISTS `trg_hist_auth_user_insert`$$
CREATE TRIGGER `trg_hist_auth_user_insert`
AFTER INSERT ON `auth_user`
FOR EACH ROW
BEGIN
  INSERT INTO hist_auth_user (accion, fecha_accion, usuario_accion, user_id, username, email, is_active, is_superuser, creado_por, fecha_creacion)
  VALUES ('INSERT', NOW(), USER(), NEW.id, NEW.username, NEW.email, NEW.is_active, NEW.is_superuser, NEW.creado_por, NEW.fecha_creacion);
END
$$

DROP TRIGGER IF EXISTS `trg_hist_auth_user_update`$$
CREATE TRIGGER `trg_hist_auth_user_update`
AFTER UPDATE ON `auth_user`
FOR EACH ROW
BEGIN
  INSERT INTO hist_auth_user (accion, fecha_accion, usuario_accion, user_id, username, email, is_active, is_superuser, creado_por, fecha_creacion, modificado_por, fecha_modificacion)
  VALUES ('UPDATE', NOW(), USER(), OLD.id, OLD.username, OLD.email, OLD.is_active, OLD.is_superuser, OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion);
END
$$

DROP TRIGGER IF EXISTS `trg_hist_auth_user_delete`$$
CREATE TRIGGER `trg_hist_auth_user_delete`
BEFORE DELETE ON `auth_user`
FOR EACH ROW
BEGIN
  INSERT INTO hist_auth_user (accion, fecha_accion, usuario_accion, user_id, username, email, is_active, is_superuser, creado_por, fecha_creacion, modificado_por, fecha_modificacion)
  VALUES ('DELETE', NOW(), USER(), OLD.id, OLD.username, OLD.email, OLD.is_active, OLD.is_superuser, OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion);
END
$$

-- ============================================================================
-- EMPLEOS_EMPRESA: Triggers de auditoría (BEFORE)
-- ============================================================================

DROP TRIGGER IF EXISTS `trg_audit_empresa_django_insert`$$
CREATE TRIGGER `trg_audit_empresa_django_insert`
BEFORE INSERT ON `empleos_empresa`
FOR EACH ROW
BEGIN
  SET NEW.creado_por = USER();
  SET NEW.fecha_creacion = NOW();
END
$$

DROP TRIGGER IF EXISTS `trg_audit_empresa_django_update`$$
CREATE TRIGGER `trg_audit_empresa_django_update`
BEFORE UPDATE ON `empleos_empresa`
FOR EACH ROW
BEGIN
  SET NEW.modificado_por = USER();
  SET NEW.fecha_modificacion = NOW();
END
$$

-- ============================================================================
-- EMPLEOS_EMPRESA: Triggers de historial
-- ============================================================================

DROP TRIGGER IF EXISTS `trg_hist_empresa_django_insert`$$
CREATE TRIGGER `trg_hist_empresa_django_insert`
AFTER INSERT ON `empleos_empresa`
FOR EACH ROW
BEGIN
  INSERT INTO hist_empleos_empresa (accion, fecha_accion, usuario_accion, empresa_id, nombre, correo, telefono, direccion, creado_por, fecha_creacion)
  VALUES ('INSERT', NOW(), USER(), NEW.id, NEW.nombre, NEW.correo, NEW.telefono, NEW.direccion, NEW.creado_por, NEW.fecha_creacion);
END
$$

DROP TRIGGER IF EXISTS `trg_hist_empresa_django_update`$$
CREATE TRIGGER `trg_hist_empresa_django_update`
AFTER UPDATE ON `empleos_empresa`
FOR EACH ROW
BEGIN
  INSERT INTO hist_empleos_empresa (accion, fecha_accion, usuario_accion, empresa_id, nombre, correo, telefono, direccion, creado_por, fecha_creacion, modificado_por, fecha_modificacion)
  VALUES ('UPDATE', NOW(), USER(), OLD.id, OLD.nombre, OLD.correo, OLD.telefono, OLD.direccion, OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion);
END
$$

DROP TRIGGER IF EXISTS `trg_hist_empresa_django_delete`$$
CREATE TRIGGER `trg_hist_empresa_django_delete`
BEFORE DELETE ON `empleos_empresa`
FOR EACH ROW
BEGIN
  INSERT INTO hist_empleos_empresa (accion, fecha_accion, usuario_accion, empresa_id, nombre, correo, telefono, direccion, creado_por, fecha_creacion, modificado_por, fecha_modificacion)
  VALUES ('DELETE', NOW(), USER(), OLD.id, OLD.nombre, OLD.correo, OLD.telefono, OLD.direccion, OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion);
END
$$

-- ============================================================================
-- EMPLEOS_VACANTE: Triggers de auditoría (BEFORE)
-- ============================================================================

DROP TRIGGER IF EXISTS `trg_audit_vacante_django_insert`$$
CREATE TRIGGER `trg_audit_vacante_django_insert`
BEFORE INSERT ON `empleos_vacante`
FOR EACH ROW
BEGIN
  IF NEW.creado_por IS NULL OR NEW.creado_por = '' THEN
    SET NEW.creado_por = COALESCE(
      (SELECT username FROM auth_user WHERE id = NEW.creado_por_usuario_id),
      USER()
    );
  END IF;
  IF NEW.fecha_creacion IS NULL THEN
    SET NEW.fecha_creacion = NOW();
  END IF;
END
$$

DROP TRIGGER IF EXISTS `trg_audit_vacante_django_update`$$
CREATE TRIGGER `trg_audit_vacante_django_update`
BEFORE UPDATE ON `empleos_vacante`
FOR EACH ROW
BEGIN
  SET NEW.modificado_por = COALESCE(
    (SELECT username FROM auth_user WHERE id = NEW.creado_por_usuario_id),
    USER()
  );
  SET NEW.fecha_modificacion = NOW();
END
$$

-- ============================================================================
-- EMPLEOS_VACANTE: Triggers de historial
-- ============================================================================

DROP TRIGGER IF EXISTS `trg_hist_vacante_django_insert`$$
CREATE TRIGGER `trg_hist_vacante_django_insert`
AFTER INSERT ON `empleos_vacante`
FOR EACH ROW
BEGIN
  INSERT INTO hist_empleos_vacante (
    accion, fecha_accion, usuario_accion, vacante_id,
    titulo, descripcion, requisitos, experiencia,
    ubicacion, tipo_contrato, numero_vacantes,
    salario, estado, fecha_limite,
    categoria_id, empresa_id,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  )
  VALUES (
    'INSERT', NOW(),
    COALESCE(
      NEW.creado_por_usuario_id,
      NEW.creado_por,
      USER()
    ),
    NEW.id,
    COALESCE(NEW.titulo, ''),
    COALESCE(NEW.descripcion, ''),
    COALESCE(NEW.requisitos, ''),
    COALESCE(NEW.experiencia, ''),
    COALESCE(NEW.ubicacion, ''),
    COALESCE(NEW.tipo_contrato, 'TIEMPO_COMPLETO'),
    COALESCE(NEW.numero_vacantes, 1),
    NEW.salario,
    COALESCE(NEW.estado, 'ACTIVA'),
    NEW.fecha_limite,
    NEW.categoria_id,
    NEW.empresa_id,
    NEW.creado_por,
    NEW.fecha_creacion,
    NULL, NULL
  );
END
$$

DROP TRIGGER IF EXISTS `trg_hist_vacante_django_update`$$
CREATE TRIGGER `trg_hist_vacante_django_update`
AFTER UPDATE ON `empleos_vacante`
FOR EACH ROW
BEGIN
  INSERT INTO hist_empleos_vacante (
    accion, fecha_accion, usuario_accion, vacante_id,
    titulo, descripcion, requisitos, experiencia,
    ubicacion, tipo_contrato, numero_vacantes,
    salario, estado, fecha_limite,
    categoria_id, empresa_id,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  )
  VALUES (
    'UPDATE', NOW(),
    COALESCE(
      NEW.creado_por_usuario_id,
      OLD.creado_por,
      USER()
    ),
    OLD.id,
    COALESCE(NEW.titulo, ''),
    COALESCE(NEW.descripcion, ''),
    COALESCE(NEW.requisitos, ''),
    COALESCE(NEW.experiencia, ''),
    COALESCE(NEW.ubicacion, ''),
    COALESCE(NEW.tipo_contrato, 'TIEMPO_COMPLETO'),
    COALESCE(NEW.numero_vacantes, 1),
    NEW.salario,
    COALESCE(NEW.estado, 'ACTIVA'),
    NEW.fecha_limite,
    NEW.categoria_id,
    NEW.empresa_id,
    OLD.creado_por,
    OLD.fecha_creacion,
    NEW.modificado_por,
    NEW.fecha_modificacion
  );
END
$$

DROP TRIGGER IF EXISTS `trg_hist_vacante_django_delete`$$
CREATE TRIGGER `trg_hist_vacante_django_delete`
BEFORE DELETE ON `empleos_vacante`
FOR EACH ROW
BEGIN
  INSERT INTO hist_empleos_vacante (
    accion, fecha_accion, usuario_accion, vacante_id,
    titulo, descripcion, requisitos, experiencia,
    ubicacion, tipo_contrato, numero_vacantes,
    salario, estado, fecha_limite,
    categoria_id, empresa_id,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  )
  VALUES (
    'DELETE', NOW(),
    COALESCE(
      OLD.creado_por_usuario_id,
      OLD.creado_por,
      USER()
    ),
    OLD.id,
    COALESCE(OLD.titulo, ''),
    COALESCE(OLD.descripcion, ''),
    COALESCE(OLD.requisitos, ''),
    COALESCE(OLD.experiencia, ''),
    COALESCE(OLD.ubicacion, ''),
    COALESCE(OLD.tipo_contrato, 'TIEMPO_COMPLETO'),
    COALESCE(OLD.numero_vacantes, 1),
    OLD.salario,
    COALESCE(OLD.estado, 'ACTIVA'),
    OLD.fecha_limite,
    OLD.categoria_id,
    OLD.empresa_id,
    OLD.creado_por,
    OLD.fecha_creacion,
    OLD.modificado_por,
    OLD.fecha_modificacion
  );
END
$$

-- ============================================================================
-- EMPLEOS_CANDIDATO: Triggers de auditoría (BEFORE)
-- ============================================================================

DROP TRIGGER IF EXISTS `trg_audit_candidato_django_insert`$$
CREATE TRIGGER `trg_audit_candidato_django_insert`
BEFORE INSERT ON `empleos_candidato`
FOR EACH ROW
BEGIN
  SET NEW.creado_por = COALESCE(
    (SELECT username FROM auth_user WHERE id = NEW.user_id),
    USER()
  );
  SET NEW.fecha_creacion = NOW();
END
$$

DROP TRIGGER IF EXISTS `trg_audit_candidato_django_update`$$
CREATE TRIGGER `trg_audit_candidato_django_update`
BEFORE UPDATE ON `empleos_candidato`
FOR EACH ROW
BEGIN
  SET NEW.modificado_por = COALESCE(
    (SELECT username FROM auth_user WHERE id = NEW.user_id),
    USER()
  );
  SET NEW.fecha_modificacion = NOW();
END
$$

-- ============================================================================
-- EMPLEOS_CANDIDATO: Triggers de historial
-- ============================================================================

DROP TRIGGER IF EXISTS `trg_hist_candidato_django_insert`$$
CREATE TRIGGER `trg_hist_candidato_django_insert`
AFTER INSERT ON `empleos_candidato`
FOR EACH ROW
BEGIN
  INSERT INTO hist_empleos_candidato (
    accion, fecha_accion, usuario_accion,
    candidato_id, user_id, telefono, direccion, experiencia,
    dui, area_interes, estudios, habilidades,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  ) VALUES (
    'INSERT', NOW(),
    COALESCE((SELECT username FROM auth_user WHERE id = NEW.user_id), USER()),
    NEW.id, NEW.user_id, NEW.telefono, NEW.direccion, NEW.experiencia,
    NEW.dui, NEW.area_interes, NEW.estudios, NEW.habilidades,
    NEW.creado_por, NEW.fecha_creacion, NEW.modificado_por, NEW.fecha_modificacion
  );
END
$$

DROP TRIGGER IF EXISTS `trg_hist_candidato_django_update`$$
CREATE TRIGGER `trg_hist_candidato_django_update`
AFTER UPDATE ON `empleos_candidato`
FOR EACH ROW
BEGIN
  INSERT INTO hist_empleos_candidato (
    accion, fecha_accion, usuario_accion,
    candidato_id, user_id, telefono, direccion, experiencia,
    dui, area_interes, estudios, habilidades,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  ) VALUES (
    'UPDATE', NOW(),
    COALESCE((SELECT username FROM auth_user WHERE id = OLD.user_id), USER()),
    OLD.id, OLD.user_id, OLD.telefono, OLD.direccion, OLD.experiencia,
    OLD.dui, OLD.area_interes, OLD.estudios, OLD.habilidades,
    OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion
  );
END
$$

DROP TRIGGER IF EXISTS `trg_hist_candidato_django_delete`$$
CREATE TRIGGER `trg_hist_candidato_django_delete`
BEFORE DELETE ON `empleos_candidato`
FOR EACH ROW
BEGIN
  INSERT INTO hist_empleos_candidato (
    accion, fecha_accion, usuario_accion,
    candidato_id, user_id, telefono, direccion, experiencia,
    dui, area_interes, estudios, habilidades,
    creado_por, fecha_creacion, modificado_por, fecha_modificacion
  ) VALUES (
    'DELETE', NOW(),
    COALESCE((SELECT username FROM auth_user WHERE id = OLD.user_id), USER()),
    OLD.id, OLD.user_id, OLD.telefono, OLD.direccion, OLD.experiencia,
    OLD.dui, OLD.area_interes, OLD.estudios, OLD.habilidades,
    OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion
  );
END
$$

-- ============================================================================
-- EMPLEOS_POSTULACION: Triggers de auditoría (BEFORE)
-- ============================================================================

DROP TRIGGER IF EXISTS `trg_audit_postulacion_django_insert`$$
CREATE TRIGGER `trg_audit_postulacion_django_insert`
BEFORE INSERT ON `empleos_postulacion`
FOR EACH ROW
BEGIN
  SET NEW.creado_por = USER();
  SET NEW.fecha_creacion = NOW();
END
$$

DROP TRIGGER IF EXISTS `trg_audit_postulacion_django_update`$$
CREATE TRIGGER `trg_audit_postulacion_django_update`
BEFORE UPDATE ON `empleos_postulacion`
FOR EACH ROW
BEGIN
  SET NEW.modificado_por = USER();
  SET NEW.fecha_modificacion = NOW();
END
$$

-- ============================================================================
-- EMPLEOS_POSTULACION: Triggers de historial
-- ============================================================================

DROP TRIGGER IF EXISTS `trg_hist_postulacion_django_insert`$$
CREATE TRIGGER `trg_hist_postulacion_django_insert`
AFTER INSERT ON `empleos_postulacion`
FOR EACH ROW
BEGIN
  INSERT INTO hist_empleos_postulacion (
    accion, fecha_accion, usuario_accion,
    postulacion_id, candidato_id, vacante_id, estado, mensaje,
    fecha_postulacion, creado_por, fecha_creacion
  ) VALUES (
    'INSERT', NOW(), USER(),
    NEW.id, NEW.candidato_id, NEW.vacante_id, NEW.estado, NEW.mensaje,
    NEW.fecha_postulacion, NEW.creado_por, NEW.fecha_creacion
  );
END
$$

DROP TRIGGER IF EXISTS `trg_hist_postulacion_django_update`$$
CREATE TRIGGER `trg_hist_postulacion_django_update`
AFTER UPDATE ON `empleos_postulacion`
FOR EACH ROW
BEGIN
  INSERT INTO hist_empleos_postulacion (
    accion, fecha_accion, usuario_accion,
    postulacion_id, candidato_id, vacante_id, estado, mensaje,
    fecha_postulacion, creado_por, fecha_creacion, modificado_por, fecha_modificacion
  ) VALUES (
    'UPDATE', NOW(), USER(),
    OLD.id, OLD.candidato_id, OLD.vacante_id, OLD.estado, OLD.mensaje,
    OLD.fecha_postulacion, OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion
  );
END
$$

DROP TRIGGER IF EXISTS `trg_hist_postulacion_django_delete`$$
CREATE TRIGGER `trg_hist_postulacion_django_delete`
BEFORE DELETE ON `empleos_postulacion`
FOR EACH ROW
BEGIN
  INSERT INTO hist_empleos_postulacion (
    accion, fecha_accion, usuario_accion,
    postulacion_id, candidato_id, vacante_id, estado, mensaje,
    fecha_postulacion, creado_por, fecha_creacion, modificado_por, fecha_modificacion
  ) VALUES (
    'DELETE', NOW(), USER(),
    OLD.id, OLD.candidato_id, OLD.vacante_id, OLD.estado, OLD.mensaje,
    OLD.fecha_postulacion, OLD.creado_por, OLD.fecha_creacion, OLD.modificado_por, OLD.fecha_modificacion
  );
END
$$

DELIMITER ;

-- ============================================================================
-- Fin del script
-- ============================================================================