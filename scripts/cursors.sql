-- =============================================================
-- CURSORS - bolsa_trabajo
-- Ejecutar en una BD viva; no recrea tablas ni datos.
-- Requiere MySQL 8.0+
-- =============================================================

USE bolsa_trabajo;

DELIMITER $$

-- -------------------------------------------------------------
-- 1. cur_candidatos_sin_postulacion
--    Recorre candidatos que nunca han postulado a ninguna oferta
--    y registra una notificación de seguimiento.
-- -------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_notificar_candidatos_inactivos$$
CREATE PROCEDURE sp_notificar_candidatos_inactivos()
BEGIN
    DECLARE done        INT DEFAULT FALSE;
    DECLARE v_cand_id   INT;
    DECLARE v_usr_id    INT;
    DECLARE v_nombre    VARCHAR(100);

    -- Cursor: candidatos sin ninguna postulación registrada
    DECLARE cur_candidatos_sin_postulacion CURSOR FOR
        SELECT c.candidato_id, c.usuario_id, c.nombre_completo
        FROM   candidato c
        WHERE  c.candidato_id NOT IN (
                   SELECT DISTINCT candidato_id
                   FROM   postulacion
                   WHERE  candidato_id IS NOT NULL
               )
          AND  c.usuario_id IS NOT NULL;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_candidatos_sin_postulacion;

    leer_candidatos: LOOP
        FETCH cur_candidatos_sin_postulacion INTO v_cand_id, v_usr_id, v_nombre;
        IF done THEN
            LEAVE leer_candidatos;
        END IF;

        -- Insertar notificación sólo si no existe una igual del día de hoy
        INSERT INTO notificacion (usuario_id, mensaje, fecha, leido)
        SELECT v_usr_id,
               CONCAT('Hola ', v_nombre, ', ¡hay nuevas ofertas disponibles para ti!'),
               CURDATE(),
               0
        WHERE NOT EXISTS (
            SELECT 1
            FROM   notificacion
            WHERE  usuario_id = v_usr_id
              AND  fecha      = CURDATE()
              AND  mensaje LIKE '%nuevas ofertas disponibles%'
        );

    END LOOP leer_candidatos;

    CLOSE cur_candidatos_sin_postulacion;
END$$


-- -------------------------------------------------------------
-- 2. cur_vacantes_vencidas
--    Recorre vacantes cuya fecha_limite ya pasó y siguen activas,
--    las marca como 'cerrado' y genera una alerta DBA informativa.
-- -------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_cerrar_vacantes_vencidas$$
CREATE PROCEDURE sp_cerrar_vacantes_vencidas()
BEGIN
    DECLARE done          INT DEFAULT FALSE;
    DECLARE v_vac_id      BIGINT;
    DECLARE v_titulo      VARCHAR(200);
    DECLARE v_empresa_id  BIGINT;
    DECLARE v_total       INT DEFAULT 0;

    DECLARE cur_vacantes_vencidas CURSOR FOR
        SELECT id, titulo, empresa_id
        FROM   empleos_vacante
        WHERE  estado       = 'activo'
          AND  fecha_limite < CURDATE();

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_vacantes_vencidas;

    leer_vacantes: LOOP
        FETCH cur_vacantes_vencidas INTO v_vac_id, v_titulo, v_empresa_id;
        IF done THEN
            LEAVE leer_vacantes;
        END IF;

        UPDATE empleos_vacante
        SET    estado            = 'cerrado',
               modificado_por   = 'sp_cerrar_vacantes_vencidas',
               fecha_modificacion = NOW()
        WHERE  id = v_vac_id;

        SET v_total = v_total + 1;

    END LOOP leer_vacantes;

    CLOSE cur_vacantes_vencidas;

    -- Registrar en dba_alertas si se cerró al menos una vacante
    IF v_total > 0 THEN
        INSERT INTO dba_alertas (tipo_alerta, nivel, mensaje, detalle, fecha_alerta, atendida)
        VALUES ('MANTENIMIENTO', 'INFO',
                CONCAT('Vacantes vencidas cerradas automáticamente: ', v_total),
                JSON_OBJECT('total_cerradas', v_total, 'ejecutado_por', 'sp_cerrar_vacantes_vencidas'),
                NOW(), 0);
    END IF;
END$$


-- -------------------------------------------------------------
-- 3. cur_postulaciones_por_empresa
--    Genera un resumen de postulaciones agrupadas por empresa
--    y lo imprime como result-set (útil para reportes ad-hoc).
-- -------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_resumen_postulaciones_empresa$$
CREATE PROCEDURE sp_resumen_postulaciones_empresa()
BEGIN
    DECLARE done             INT DEFAULT FALSE;
    DECLARE v_empresa        VARCHAR(100);
    DECLARE v_total_post     INT;
    DECLARE v_pendientes     INT;
    DECLARE v_aceptadas      INT;
    DECLARE v_rechazadas     INT;

    DECLARE cur_postulaciones_por_empresa CURSOR FOR
        SELECT ee.nombre                                          AS empresa,
               COUNT(ep.id)                                       AS total,
               SUM(ep.estado = 'pendiente')                       AS pendientes,
               SUM(ep.estado = 'aceptado')                        AS aceptadas,
               SUM(ep.estado = 'rechazado')                       AS rechazadas
        FROM   empleos_postulacion ep
        JOIN   empleos_vacante     ev ON ev.id        = ep.vacante_id
        JOIN   empleos_empresa     ee ON ee.id        = ev.empresa_id
        GROUP  BY ee.nombre
        ORDER  BY total DESC;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Tabla temporal para el resultado
    DROP TEMPORARY TABLE IF EXISTS tmp_resumen_empresas;
    CREATE TEMPORARY TABLE tmp_resumen_empresas (
        empresa     VARCHAR(100),
        total       INT,
        pendientes  INT,
        aceptadas   INT,
        rechazadas  INT
    );

    OPEN cur_postulaciones_por_empresa;

    leer_empresas: LOOP
        FETCH cur_postulaciones_por_empresa
          INTO v_empresa, v_total_post, v_pendientes, v_aceptadas, v_rechazadas;
        IF done THEN
            LEAVE leer_empresas;
        END IF;

        INSERT INTO tmp_resumen_empresas
        VALUES (v_empresa, v_total_post, v_pendientes, v_aceptadas, v_rechazadas);

    END LOOP leer_empresas;

    CLOSE cur_postulaciones_por_empresa;

    SELECT * FROM tmp_resumen_empresas;
    DROP TEMPORARY TABLE IF EXISTS tmp_resumen_empresas;
END$$

DELIMITER ;
