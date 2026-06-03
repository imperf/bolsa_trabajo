-- Fix triggers for empleos_vacante - Version 2
-- This version first ensures all columns exist in hist_empleos_vacante

-- Step 1: Add missing columns to hist_empleos_vacante if they don't exist
-- Check and add requisitos
ALTER TABLE hist_empleos_vacante ADD COLUMN IF NOT EXISTS requisitos LONGTEXT AFTER descripcion;

-- Check and add experiencia  
ALTER TABLE hist_empleos_vacante ADD COLUMN IF NOT EXISTS experiencia LONGTEXT AFTER requisitos;

-- Check and add tipo_contrato
ALTER TABLE hist_empleos_vacante ADD COLUMN IF NOT EXISTS tipo_contrato VARCHAR(20) AFTER experiencia;

-- Check and add numero_vacantes
ALTER TABLE hist_empleos_vacante ADD COLUMN IF NOT EXISTS numero_vacantes INT AFTER tipo_contrato;

-- Check and add categoria_id
ALTER TABLE hist_empleos_vacante ADD COLUMN IF NOT EXISTS categoria_id BIGINT AFTER numero_vacantes;

-- Check and add empresa_id
ALTER TABLE hist_empleos_vacante ADD COLUMN IF NOT EXISTS empresa_id BIGINT AFTER categoria_id;

-- Step 2: Drop existing triggers
DROP TRIGGER IF EXISTS trg_audit_vacante_django_insert;
DROP TRIGGER IF EXISTS trg_hist_vacante_django_insert;
DROP TRIGGER IF EXISTS trg_audit_vacante_django_update;
DROP TRIGGER IF EXISTS trg_hist_vacante_django_update;
DROP TRIGGER IF EXISTS trg_hist_vacante_django_delete;

-- Step 3: Recreate triggers with proper NULL handling

-- INSERT audit trigger (BEFORE INSERT)
DELIMITER ;;
CREATE TRIGGER trg_audit_vacante_django_insert
BEFORE INSERT ON empleos_vacante
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
END;;
DELIMITER ;

-- INSERT history trigger (AFTER INSERT)
DELIMITER ;;
CREATE TRIGGER trg_hist_vacante_django_insert
AFTER INSERT ON empleos_vacante
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
END;;
DELIMITER ;

-- UPDATE audit trigger (BEFORE UPDATE)
DELIMITER ;;
CREATE TRIGGER trg_audit_vacante_django_update
BEFORE UPDATE ON empleos_vacante
FOR EACH ROW
BEGIN
  -- Set modificado_por to the Django username
  SET NEW.modificado_por = COALESCE(
    (SELECT username FROM auth_user WHERE id = NEW.creado_por_usuario_id),
    USER()
  );
  SET NEW.fecha_modificacion = NOW();
END;;
DELIMITER ;

-- UPDATE history trigger (AFTER UPDATE)
DELIMITER ;;
CREATE TRIGGER trg_hist_vacante_django_update
AFTER UPDATE ON empleos_vacante
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
END;;
DELIMITER ;

-- DELETE history trigger (BEFORE DELETE)
DELIMITER ;;
CREATE TRIGGER trg_hist_vacante_django_delete
BEFORE DELETE ON empleos_vacante
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
END;;
DELIMITER ;

-- Verify columns were added
SELECT 
  COLUMN_NAME, 
  DATA_TYPE, 
  IS_NULLABLE, 
  COLUMN_DEFAULT
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = 'bolsa_trabajo' 
  AND TABLE_NAME = 'hist_empleos_vacante'
ORDER BY ORDINAL_POSITION;