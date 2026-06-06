-- =============================================================
-- FUNCTIONS - bolsa_trabajo
-- Ejecutar en una BD viva; no recrea tablas ni datos.
-- Requiere MySQL 8.0+  |  SET GLOBAL log_bin_trust_function_creators=1
--   (o usar DETERMINISTIC / NO SQL / READS SQL DATA según aplique)
-- =============================================================

USE bolsa_trabajo;

DELIMITER $$

-- -------------------------------------------------------------
-- 1. fn_edad_laboral
--    Devuelve la categoría de experiencia según años trabajados.
--    Entrada : años de experiencia (INT)
--    Salida  : VARCHAR  'Sin experiencia' | 'Junior' | 'Semi-Senior' | 'Senior'
-- -------------------------------------------------------------
DROP FUNCTION IF EXISTS fn_edad_laboral$$
CREATE FUNCTION fn_edad_laboral(p_anios INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    RETURN CASE
        WHEN p_anios IS NULL OR p_anios < 0 THEN 'Sin experiencia'
        WHEN p_anios = 0                    THEN 'Sin experiencia'
        WHEN p_anios BETWEEN 1 AND 2        THEN 'Junior'
        WHEN p_anios BETWEEN 3 AND 5        THEN 'Semi-Senior'
        ELSE                                     'Senior'
    END;
END$$


-- -------------------------------------------------------------
-- 2. fn_total_postulaciones_candidato
--    Devuelve el número total de postulaciones de un candidato
--    (tabla empleos_postulacion + tabla postulacion legacy).
--    Entrada : candidato.candidato_id (INT)
--    Salida  : INT
-- -------------------------------------------------------------
DROP FUNCTION IF EXISTS fn_total_postulaciones_candidato$$
CREATE FUNCTION fn_total_postulaciones_candidato(p_candidato_id INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_total INT DEFAULT 0;
    DECLARE v_django INT DEFAULT 0;

    -- Tabla legacy
    SELECT COUNT(*) INTO v_total
    FROM   postulacion
    WHERE  candidato_id = p_candidato_id;

    -- Tabla Django (empleos_candidato.id difiere del candidato clásico;
    -- se busca por la relación usuario_id)
    SELECT COUNT(*) INTO v_django
    FROM   empleos_postulacion ep
    JOIN   empleos_candidato   ec ON ec.id = ep.candidato_id
    JOIN   candidato            c  ON c.usuario_id = ec.user_id
    WHERE  c.candidato_id = p_candidato_id;

    RETURN v_total + v_django;
END$$


-- -------------------------------------------------------------
-- 3. fn_estado_vacante_label
--    Traduce el código de estado de una vacante a una etiqueta
--    amigable en español con emoji de semáforo.
--    Entrada : estado VARCHAR (ej. 'activo', 'cerrado', 'borrador')
--    Salida  : VARCHAR con etiqueta
-- -------------------------------------------------------------
DROP FUNCTION IF EXISTS fn_estado_vacante_label$$
CREATE FUNCTION fn_estado_vacante_label(p_estado VARCHAR(20))
RETURNS VARCHAR(40)
DETERMINISTIC
BEGIN
    RETURN CASE LOWER(TRIM(p_estado))
        WHEN 'activo'    THEN '🟢 Activa'
        WHEN 'cerrado'   THEN '🔴 Cerrada'
        WHEN 'borrador'  THEN '🟡 Borrador'
        WHEN 'pausado'   THEN '🟠 Pausada'
        ELSE                  '⚪ Desconocido'
    END;
END$$


-- -------------------------------------------------------------
-- 4. fn_porcentaje_ocupacion_vacante
--    Calcula qué porcentaje de las plazas de una vacante ya
--    tienen postulaciones aceptadas.
--    Entrada : empleos_vacante.id (BIGINT)
--    Salida  : DECIMAL(5,2)  — 0.00 a 100.00
-- -------------------------------------------------------------
DROP FUNCTION IF EXISTS fn_porcentaje_ocupacion_vacante$$
CREATE FUNCTION fn_porcentaje_ocupacion_vacante(p_vacante_id BIGINT)
RETURNS DECIMAL(5,2)
READS SQL DATA
BEGIN
    DECLARE v_plazas   INT     DEFAULT 0;
    DECLARE v_acept    INT     DEFAULT 0;
    DECLARE v_pct      DECIMAL(5,2) DEFAULT 0.00;

    SELECT numero_vacantes INTO v_plazas
    FROM   empleos_vacante
    WHERE  id = p_vacante_id;

    SELECT COUNT(*) INTO v_acept
    FROM   empleos_postulacion
    WHERE  vacante_id = p_vacante_id
      AND  estado     = 'aceptado';

    IF v_plazas > 0 THEN
        SET v_pct = LEAST(ROUND((v_acept / v_plazas) * 100, 2), 100.00);
    END IF;

    RETURN v_pct;
END$$


-- -------------------------------------------------------------
-- 5. fn_dias_restantes_vacante
--    Días calendario que quedan hasta el cierre de una vacante.
--    Devuelve 0 si ya venció, NULL si no se encuentra.
--    Entrada : empleos_vacante.id (BIGINT)
--    Salida  : INT
-- -------------------------------------------------------------
DROP FUNCTION IF EXISTS fn_dias_restantes_vacante$$
CREATE FUNCTION fn_dias_restantes_vacante(p_vacante_id BIGINT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_fecha_limite DATE;
    DECLARE v_dias         INT;

    SELECT fecha_limite INTO v_fecha_limite
    FROM   empleos_vacante
    WHERE  id = p_vacante_id;

    IF v_fecha_limite IS NULL THEN
        RETURN NULL;
    END IF;

    SET v_dias = DATEDIFF(v_fecha_limite, CURDATE());
    RETURN GREATEST(v_dias, 0);
END$$

DELIMITER ;
