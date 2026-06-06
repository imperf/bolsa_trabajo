-- ============================================================================
-- empleos_jobs.sql
-- Stored procedures y eventos programados (jobs) para Bolsa de Trabajo
-- Compatible con MySQL 8.0+
--
-- Uso (requiere root):
--   mysql -u root -p bolsa_trabajo < empleos_jobs.sql
--
-- Nota: Ejecutar este script como root. Sin cláusula DEFINER, los objetos
--       se crearán con el definer del usuario que ejecuta el script.
--       El event scheduler se activa automáticamente con SET GLOBAL.
-- ============================================================================

SET NAMES utf8mb4;

-- Activar el event scheduler (requiere privilegios de SUPER)
-- Si falla por falta de permisos, ejecutar manualmente como root:
--   SET GLOBAL event_scheduler = ON;
-- O agregar en my.cnf: event_scheduler = ON
-- SET GLOBAL event_scheduler = ON;


-- ============================================================================
-- PARTE 1: Stored procedure para matar conexiones dormidas
-- ============================================================================

DROP PROCEDURE IF EXISTS `sp_kill_sleeping_connections`;

DELIMITER $$

CREATE PROCEDURE `sp_kill_sleeping_connections`()
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
END
$$

-- ============================================================================
-- PARTE 2: Eventos programados
-- ============================================================================

-- Actualizar estadisticas de tablas (diario a las 4:00 AM)
DROP EVENT IF EXISTS `job_actualizar_estadisticas`$$

CREATE EVENT `job_actualizar_estadisticas`
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_DATE + INTERVAL 1 DAY + INTERVAL 4 HOUR
ON COMPLETION NOT PRESERVE
ENABLE
DO BEGIN
  ANALYZE TABLE auth_user;
  ANALYZE TABLE empleos_candidato;
  ANALYZE TABLE empleos_vacante;
  ANALYZE TABLE empleos_postulacion;
  ANALYZE TABLE empleos_empresa;
  ANALYZE TABLE empleos_notificacion;
  ANALYZE TABLE hist_auth_user;
  ANALYZE TABLE hist_empleos_candidato;
  ANALYZE TABLE hist_empleos_vacante;
  ANALYZE TABLE hist_empleos_postulacion;
  ANALYZE TABLE hist_empleos_empresa;
END
$$

-- Matar conexiones dormidas (cada 30 minutos)
DROP EVENT IF EXISTS `job_matar_conexiones_dormidas`$$

CREATE EVENT `job_matar_conexiones_dormidas`
ON SCHEDULE EVERY 30 MINUTE
STARTS CURRENT_TIMESTAMP
ON COMPLETION NOT PRESERVE
ENABLE
DO BEGIN
  CALL sp_kill_sleeping_connections();
END
$$

-- Optimizar tablas (semanalmente, sabados a las 3:00 AM)
DROP EVENT IF EXISTS `job_optimizar_tablas`$$

CREATE EVENT `job_optimizar_tablas`
ON SCHEDULE EVERY 1 WEEK
STARTS CURRENT_DATE + INTERVAL (7 - DAYOFWEEK(CURRENT_DATE)) DAY + INTERVAL 3 HOUR
ON COMPLETION NOT PRESERVE
ENABLE
DO BEGIN
  OPTIMIZE TABLE empleos_notificacion;
  OPTIMIZE TABLE empleos_postulacion;
  OPTIMIZE TABLE hist_empleos_postulacion;
  OPTIMIZE TABLE hist_empleos_vacante;
  OPTIMIZE TABLE hist_auth_user;
END
$$

-- Purgar registros historicos antiguos (mensualmente, dia 1 a las 2:00 AM)
DROP EVENT IF EXISTS `job_purgar_historicos`$$

CREATE EVENT `job_purgar_historicos`
ON SCHEDULE EVERY 1 MONTH
STARTS CURRENT_DATE + INTERVAL 1 MONTH + INTERVAL 2 HOUR
ON COMPLETION NOT PRESERVE
ENABLE
DO BEGIN
  DELETE FROM hist_auth_user           WHERE fecha_accion < (NOW() - INTERVAL 2 YEAR);
  DELETE FROM hist_empleos_candidato   WHERE fecha_accion < (NOW() - INTERVAL 2 YEAR);
  DELETE FROM hist_empleos_vacante     WHERE fecha_accion < (NOW() - INTERVAL 2 YEAR);
  DELETE FROM hist_empleos_postulacion WHERE fecha_accion < (NOW() - INTERVAL 2 YEAR);
  DELETE FROM hist_empleos_empresa     WHERE fecha_accion < (NOW() - INTERVAL 2 YEAR);
END
$$

-- Purgar notificaciones leidas antiguas (diario a la 1:00 AM)
DROP EVENT IF EXISTS `job_purgar_notificaciones`$$

CREATE EVENT `job_purgar_notificaciones`
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_DATE + INTERVAL 1 DAY + INTERVAL 1 HOUR
ON COMPLETION NOT PRESERVE
ENABLE
DO BEGIN
  DELETE FROM empleos_notificacion
  WHERE leida = 1
    AND fecha_creacion < (CURDATE() - INTERVAL 60 DAY);
END
$$

DELIMITER ;

-- ============================================================================
-- Fin del script
-- ============================================================================