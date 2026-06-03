-- Fix triggers for empleos_vacante to properly track Django users
-- and include all new fields

-- First, drop the existing triggers
DROP TRIGGER IF EXISTS trg_audit_vacante_django_insert;
DROP TRIGGER IF EXISTS trg_hist_vacante_django_insert;
DROP TRIGGER IF EXISTS trg_audit_vacante_django_update;
DROP TRIGGER IF EXISTS trg_hist_vacante_django_update;
DROP TRIGGER IF EXISTS trg_hist_vacante_django_delete;

-- Recreate the INSERT audit trigger (BEFORE INSERT)
DELIMITER ;;
CREATE TRIGGER trg_audit_vacante_django_insert
BEFORE INSERT ON empleos_vacante
FOR EACH ROW
BEGIN
  -- Only set created_by if not already set
  IF NEW.creado_por IS NULL OR NEW.creado_por = '' THEN
    SET NEW.creado_por = USER();
  END IF;
  -- Only set created_date if not already set
  IF NEW.fecha_creacion IS NULL THEN
    SET NEW.fecha_creacion = NOW();
  END IF;
END;;
DELIMITER ;

-- Recreate the INSERT history trigger (AFTER INSERT)
DELIMITER ;;
CREATE TRIGGER trg_hist_vacante_django_insert
AFTER INSERT ON empleos_vacante
FOR EACH ROW
BEGIN
  INSERT INTO hist_empleos_vacante (
    accion, 
    fecha_accion, 
    usuario_accion, 
    vacante_id, 
    titulo, 
    descripcion, 
    requisitos,
    experiencia,
    ubicacion,
    tipo_contrato,
    numero_vacantes,
    salario, 
    estado, 
    fecha_limite,
    categoria_id,
    empresa_id,
    creado_por, 
    fecha_creacion,
    modificado_por,
    fecha_modificacion
  )
  VALUES (
    'INSERT', 
    NOW(), 
    COALESCE(NEW.creado_por_usuario_id, NEW.creado_por, USER()), 
    NEW.id, 
    NEW.titulo, 
    NEW.descripcion, 
    NEW.requisitos,
    NEW.experiencia,
    NEW.ubicacion,
    NEW.tipo_contrato,
    NEW.numero_vacantes,
    NEW.salario, 
    NEW.estado, 
    NEW.fecha_limite,
    NEW.categoria_id,
    NEW.empresa_id,
    NEW.creado_por, 
    NEW.fecha_creacion,
    NEW.modificado_por,
    NEW.fecha_modificacion
  );
END;;
DELIMITER ;

-- Recreate the UPDATE audit trigger (BEFORE UPDATE)
DELIMITER ;;
CREATE TRIGGER trg_audit_vacante_django_update
BEFORE UPDATE ON empleos_vacante
FOR EACH ROW
BEGIN
  -- Set the modified_by to the Django user if available, otherwise the DB user
  IF NEW.creado_por_usuario_id IS NOT NULL THEN
    -- Use the username of the Django user
    SET NEW.modificado_por = (SELECT username FROM auth_user WHERE id = NEW.creado_por_usuario_id);
  ELSE
    SET NEW.modificado_por = USER();
  END IF;
  SET NEW.fecha_modificacion = NOW();
END;;
DELIMITER ;

-- Recreate the UPDATE history trigger (AFTER UPDATE)
DELIMITER ;;
CREATE TRIGGER trg_hist_vacante_django_update
AFTER UPDATE ON empleos_vacante
FOR EACH ROW
BEGIN
  INSERT INTO hist_empleos_vacante (
    accion, 
    fecha_accion, 
    usuario_accion, 
    vacante_id, 
    titulo, 
    descripcion, 
    requisitos,
    experiencia,
    ubicacion,
    tipo_contrato,
    numero_vacantes,
    salario, 
    estado, 
    fecha_limite,
    categoria_id,
    empresa_id,
    creado_por, 
    fecha_creacion,
    modificado_por,
    fecha_modificacion
  )
  VALUES (
    'UPDATE', 
    NOW(), 
    COALESCE(NEW.creado_por_usuario_id, OLD.creado_por, USER()), 
    OLD.id, 
    NEW.titulo, 
    NEW.descripcion, 
    NEW.requisitos,
    NEW.experiencia,
    NEW.ubicacion,
    NEW.tipo_contrato,
    NEW.numero_vacantes,
    NEW.salario, 
    NEW.estado, 
    NEW.fecha_limite,
    NEW.categoria_id,
    NEW.empresa_id,
    OLD.creado_por, 
    OLD.fecha_creacion,
    NEW.modificado_por,
    NEW.fecha_modificacion
  );
END;;
DELIMITER ;

-- Recreate the DELETE history trigger (BEFORE DELETE)
DELIMITER ;;
CREATE TRIGGER trg_hist_vacante_django_delete
BEFORE DELETE ON empleos_vacante
FOR EACH ROW
BEGIN
  INSERT INTO hist_empleos_vacante (
    accion, 
    fecha_accion, 
    usuario_accion, 
    vacante_id, 
    titulo, 
    descripcion, 
    requisitos,
    experiencia,
    ubicacion,
    tipo_contrato,
    numero_vacantes,
    salario, 
    estado, 
    fecha_limite,
    categoria_id,
    empresa_id,
    creado_por, 
    fecha_creacion,
    modificado_por,
    fecha_modificacion
  )
  VALUES (
    'DELETE', 
    NOW(), 
    COALESCE(OLD.creado_por_usuario_id, OLD.creado_por, USER()), 
    OLD.id, 
    OLD.titulo, 
    OLD.descripcion, 
    OLD.requisitos,
    OLD.experiencia,
    OLD.ubicacion,
    OLD.tipo_contrato,
    OLD.numero_vacantes,
    OLD.salario, 
    OLD.estado, 
    OLD.fecha_limite,
    OLD.categoria_id,
    OLD.empresa_id,
    OLD.creado_por, 
    OLD.fecha_creacion,
    OLD.modificado_por,
    OLD.fecha_modificacion
  );
END;;
DELIMITER ;

-- Add missing columns to hist_empleos_vacante table if they don't exist
-- These columns are needed to properly track all changes

-- Add requisitos column
SET @column_exists = (SELECT COUNT(*) FROM information_schema.columns 
                      WHERE table_name = 'hist_empleos_vacante' AND column_name = 'requisitos');
SET @sql = IF(@column_exists = 0,
    'ALTER TABLE hist_empleos_vacante ADD COLUMN requisitos LONGTEXT AFTER descripcion',
    'SELECT "Column requisitos already exists"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add experiencia column
SET @column_exists = (SELECT COUNT(*) FROM information_schema.columns 
                      WHERE table_name = 'hist_empleos_vacante' AND column_name = 'experiencia');
SET @sql = IF(@column_exists = 0,
    'ALTER TABLE hist_empleos_vacante ADD COLUMN experiencia LONGTEXT AFTER requisitos',
    'SELECT "Column experiencia already exists"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add tipo_contrato column
SET @column_exists = (SELECT COUNT(*) FROM information_schema.columns 
                      WHERE table_name = 'hist_empleos_vacante' AND column_name = 'tipo_contrato');
SET @sql = IF(@column_exists = 0,
    'ALTER TABLE hist_empleos_vacante ADD COLUMN tipo_contrato VARCHAR(20) AFTER experiencia',
    'SELECT "Column tipo_contrato already exists"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add numero_vacantes column
SET @column_exists = (SELECT COUNT(*) FROM information_schema.columns 
                      WHERE table_name = 'hist_empleos_vacante' AND column_name = 'numero_vacantes');
SET @sql = IF(@column_exists = 0,
    'ALTER TABLE hist_empleos_vacante ADD COLUMN numero_vacantes INT AFTER tipo_contrato',
    'SELECT "Column numero_vacantes already exists"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add categoria_id column
SET @column_exists = (SELECT COUNT(*) FROM information_schema.columns 
                      WHERE table_name = 'hist_empleos_vacante' AND column_name = 'categoria_id');
SET @sql = IF(@column_exists = 0,
    'ALTER TABLE hist_empleos_vacante ADD COLUMN categoria_id BIGINT AFTER numero_vacantes',
    'SELECT "Column categoria_id already exists"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Add empresa_id column
SET @column_exists = (SELECT COUNT(*) FROM information_schema.columns 
                      WHERE table_name = 'hist_empleos_vacante' AND column_name = 'empresa_id');
SET @sql = IF(@column_exists = 0,
    'ALTER TABLE hist_empleos_vacante ADD COLUMN empresa_id BIGINT AFTER categoria_id',
    'SELECT "Column empresa_id already exists"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
