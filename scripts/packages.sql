-- =============================================================
-- PACKAGES - bolsa_trabajo
-- MySQL no tiene paquetes nativos; se simulan agrupando
-- procedimientos con prefijos de paquete y una tabla de registro.
-- Ejecutar en una BD viva; no recrea tablas ni datos.
-- Requiere MySQL 8.0+
-- =============================================================

USE bolsa_trabajo;

-- Tabla de metadatos de paquetes (registro central)
CREATE TABLE IF NOT EXISTS pkg_registro (
    pkg_id       INT         NOT NULL AUTO_INCREMENT,
    paquete      VARCHAR(50) NOT NULL COMMENT 'Nombre lógico del paquete',
    procedimiento VARCHAR(100) NOT NULL COMMENT 'Nombre completo del SP',
    descripcion  VARCHAR(255),
    version      VARCHAR(10)  DEFAULT '1.0',
    fecha_deploy DATETIME     DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY  (pkg_id),
    UNIQUE KEY uq_proc (procedimiento)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Registro de paquetes simulados';

DELIMITER $$

-- =============================================================
-- PAQUETE: pkg_candidatos
-- Gestión integral del candidato: registro, perfil, historial
-- =============================================================

-- pkg_candidatos.registrar
DROP PROCEDURE IF EXISTS pkg_candidatos__registrar$$
CREATE PROCEDURE pkg_candidatos__registrar(
    IN  p_usuario_id        INT,
    IN  p_nombre_completo   VARCHAR(100),
    IN  p_dui               VARCHAR(20),
    IN  p_telefono          VARCHAR(20),
    IN  p_area_interes      VARCHAR(100),
    IN  p_creado_por        VARCHAR(100),
    OUT p_candidato_id      INT,
    OUT p_mensaje           VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 p_mensaje = MESSAGE_TEXT;
        SET p_candidato_id = -1;
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Validar que el usuario no tenga ya un candidato
    IF EXISTS (SELECT 1 FROM candidato WHERE usuario_id = p_usuario_id) THEN
        SET p_candidato_id = 0;
        SET p_mensaje = 'El usuario ya tiene un perfil de candidato registrado.';
        ROLLBACK;
    ELSE
        INSERT INTO candidato (
            usuario_id, nombre_completo, dui, telefono,
            area_interes, creado_por, fecha_creacion
        )
        VALUES (
            p_usuario_id, p_nombre_completo, p_dui, p_telefono,
            p_area_interes, p_creado_por, NOW()
        );

        SET p_candidato_id = LAST_INSERT_ID();
        SET p_mensaje = CONCAT('Candidato registrado con ID ', p_candidato_id);
        COMMIT;
    END IF;
END$$

-- pkg_candidatos.obtener_perfil_completo
DROP PROCEDURE IF EXISTS pkg_candidatos__obtener_perfil_completo$$
CREATE PROCEDURE pkg_candidatos__obtener_perfil_completo(
    IN p_candidato_id INT
)
BEGIN
    -- Datos base del candidato
    SELECT c.candidato_id,
           c.nombre_completo,
           c.dui,
           c.telefono,
           c.area_interes,
           u.correo,
           tu.nombre AS tipo_usuario
    FROM   candidato    c
    JOIN   usuarios     u  ON u.usuario_id = c.usuario_id
    JOIN   tipo_usuario tu ON tu.tipo_id   = u.tipo_id
    WHERE  c.candidato_id = p_candidato_id;

    -- Formación académica
    SELECT titulo, institucion, fecha_inicio, fecha_fin
    FROM   formacion_academica
    WHERE  candidato_id = p_candidato_id
    ORDER  BY fecha_fin DESC;

    -- Experiencia laboral
    SELECT empresa, puesto, fecha_inicio, fecha_fin, descripcion
    FROM   experiencia
    WHERE  candidato_id = p_candidato_id
    ORDER  BY fecha_fin DESC;

    -- Habilidades
    SELECT h.nombre
    FROM   candidato_habilidad ch
    JOIN   habilidad h ON h.habilidad_id = ch.habilidad_id
    WHERE  ch.candidato_id = p_candidato_id;

    -- Certificaciones
    SELECT cert.nombre, cc.institucion, cc.fecha_obtencion
    FROM   candidato_certificacion cc
    JOIN   certificacion cert ON cert.certificacion_id = cc.certificacion_id
    WHERE  cc.candidato_id = p_candidato_id;
END$$

-- pkg_candidatos.estadisticas
DROP PROCEDURE IF EXISTS pkg_candidatos__estadisticas$$
CREATE PROCEDURE pkg_candidatos__estadisticas(
    IN p_candidato_id INT
)
BEGIN
    SELECT
        fn_total_postulaciones_candidato(p_candidato_id)   AS total_postulaciones,
        SUM(p.estado_id = 2)                               AS aceptadas,   -- ajustar IDs según cat.
        SUM(p.estado_id = 3)                               AS rechazadas,
        SUM(p.estado_id = 1)                               AS pendientes,
        MIN(p.fecha_postulacion)                           AS primera_postulacion,
        MAX(p.fecha_postulacion)                           AS ultima_postulacion
    FROM   postulacion p
    WHERE  p.candidato_id = p_candidato_id;
END$$


-- =============================================================
-- PAQUETE: pkg_ofertas
-- Ciclo de vida de ofertas/vacantes: publicar, cerrar, buscar
-- =============================================================

-- pkg_ofertas.publicar
DROP PROCEDURE IF EXISTS pkg_ofertas__publicar$$
CREATE PROCEDURE pkg_ofertas__publicar(
    IN  p_empresa_id        BIGINT,
    IN  p_titulo            VARCHAR(200),
    IN  p_descripcion       LONGTEXT,
    IN  p_requisitos        LONGTEXT,
    IN  p_salario           DECIMAL(10,2),
    IN  p_ubicacion         VARCHAR(150),
    IN  p_fecha_limite      DATE,
    IN  p_categoria_id      BIGINT,
    IN  p_num_vacantes      INT UNSIGNED,
    IN  p_tipo_contrato     VARCHAR(20),
    IN  p_nivel_experiencia VARCHAR(20),
    IN  p_experiencia_desc  LONGTEXT,
    IN  p_creado_por        VARCHAR(100),
    IN  p_usuario_id        INT,
    OUT p_vacante_id        BIGINT,
    OUT p_mensaje           VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 p_mensaje = MESSAGE_TEXT;
        SET p_vacante_id = -1;
        ROLLBACK;
    END;

    sp_publicar: BEGIN

    -- Validaciones básicas
    IF p_fecha_limite <= CURDATE() THEN
        SET p_vacante_id = 0;
        SET p_mensaje = 'La fecha límite debe ser posterior a hoy.';
        LEAVE sp_publicar;
    END IF;

    START TRANSACTION;

    INSERT INTO empleos_vacante (
        titulo, descripcion, requisitos, salario, ubicacion,
        estado, fecha_publicacion, fecha_limite,
        categoria_id, empresa_id,
        numero_vacantes, tipo_contrato, nivel_experiencia, experiencia,
        creado_por, fecha_creacion, creado_por_usuario_id
    )
    VALUES (
        p_titulo, p_descripcion, p_requisitos, p_salario, p_ubicacion,
        'activo', NOW(), p_fecha_limite,
        p_categoria_id, p_empresa_id,
        p_num_vacantes, p_tipo_contrato, p_nivel_experiencia, p_experiencia_desc,
        p_creado_por, NOW(), p_usuario_id
    );

    SET p_vacante_id = LAST_INSERT_ID();
    SET p_mensaje    = CONCAT('Vacante publicada con ID ', p_vacante_id);
    COMMIT;

    END sp_publicar;
END$$

-- pkg_ofertas.buscar
DROP PROCEDURE IF EXISTS pkg_ofertas__buscar$$
CREATE PROCEDURE pkg_ofertas__buscar(
    IN p_keyword        VARCHAR(100),
    IN p_categoria_id   BIGINT,
    IN p_ubicacion      VARCHAR(100),
    IN p_salario_min    DECIMAL(10,2),
    IN p_tipo_contrato  VARCHAR(20)
)
BEGIN
    SELECT
        ev.id,
        ev.titulo,
        ev.descripcion,
        ev.salario,
        ev.ubicacion,
        ev.tipo_contrato,
        ev.nivel_experiencia,
        ev.fecha_limite,
        fn_dias_restantes_vacante(ev.id)      AS dias_restantes,
        fn_estado_vacante_label(ev.estado)    AS estado_label,
        fn_porcentaje_ocupacion_vacante(ev.id) AS pct_ocupacion,
        ee.nombre                             AS empresa,
        ec.nombre                             AS categoria
    FROM   empleos_vacante   ev
    JOIN   empleos_empresa   ee ON ee.id = ev.empresa_id
    LEFT   JOIN empleos_categoria ec ON ec.id = ev.categoria_id
    WHERE  ev.estado = 'activo'
      AND  ev.fecha_limite >= CURDATE()
      AND  (p_keyword       IS NULL OR ev.titulo    LIKE CONCAT('%', p_keyword, '%')
                                    OR ev.descripcion LIKE CONCAT('%', p_keyword, '%'))
      AND  (p_categoria_id  IS NULL OR ev.categoria_id = p_categoria_id)
      AND  (p_ubicacion     IS NULL OR ev.ubicacion LIKE CONCAT('%', p_ubicacion, '%'))
      AND  (p_salario_min   IS NULL OR ev.salario >= p_salario_min)
      AND  (p_tipo_contrato IS NULL OR ev.tipo_contrato = p_tipo_contrato)
    ORDER  BY ev.fecha_publicacion DESC;
END$$

-- pkg_ofertas.dashboard_empresa
DROP PROCEDURE IF EXISTS pkg_ofertas__dashboard_empresa$$
CREATE PROCEDURE pkg_ofertas__dashboard_empresa(
    IN p_empresa_id BIGINT
)
BEGIN
    SELECT
        ev.id                                          AS vacante_id,
        ev.titulo,
        fn_estado_vacante_label(ev.estado)             AS estado,
        ev.numero_vacantes                             AS plazas,
        fn_porcentaje_ocupacion_vacante(ev.id)         AS pct_ocupacion,
        fn_dias_restantes_vacante(ev.id)               AS dias_restantes,
        COUNT(ep.id)                                   AS total_postulaciones,
        SUM(ep.estado = 'pendiente')                   AS pendientes,
        SUM(ep.estado = 'aceptado')                    AS aceptadas,
        SUM(ep.estado = 'rechazado')                   AS rechazadas
    FROM   empleos_vacante     ev
    LEFT   JOIN empleos_postulacion ep ON ep.vacante_id = ev.id
    WHERE  ev.empresa_id = p_empresa_id
    GROUP  BY ev.id, ev.titulo, ev.estado, ev.numero_vacantes, ev.fecha_limite
    ORDER  BY ev.fecha_publicacion DESC;
END$$


-- =============================================================
-- PAQUETE: pkg_reportes
-- Reportes ejecutivos y operativos de la plataforma
-- =============================================================

-- pkg_reportes.kpis_generales
DROP PROCEDURE IF EXISTS pkg_reportes__kpis_generales$$
CREATE PROCEDURE pkg_reportes__kpis_generales()
BEGIN
    SELECT
        (SELECT COUNT(*) FROM candidato)                         AS total_candidatos,
        (SELECT COUNT(*) FROM empresa)                           AS total_empresas,
        (SELECT COUNT(*) FROM empleos_vacante WHERE estado='activo') AS vacantes_activas,
        (SELECT COUNT(*) FROM empleos_vacante WHERE estado='cerrado') AS vacantes_cerradas,
        (SELECT COUNT(*) FROM empleos_postulacion)               AS total_postulaciones,
        (SELECT COUNT(*) FROM empleos_postulacion WHERE estado='aceptado') AS postulaciones_aceptadas,
        (SELECT ROUND(AVG(salario),2) FROM empleos_vacante
         WHERE salario IS NOT NULL AND estado='activo')          AS salario_promedio_activo,
        (SELECT COUNT(*) FROM notificacion WHERE leido=0)        AS notificaciones_pendientes;
END$$

-- pkg_reportes.top_candidatos
DROP PROCEDURE IF EXISTS pkg_reportes__top_candidatos$$
CREATE PROCEDURE pkg_reportes__top_candidatos(
    IN p_limite INT
)
BEGIN
    SET p_limite = IFNULL(p_limite, 10);

    SELECT
        c.candidato_id,
        c.nombre_completo,
        c.area_interes,
        fn_total_postulaciones_candidato(c.candidato_id) AS total_postulaciones,
        (SELECT COUNT(*) FROM candidato_habilidad
         WHERE candidato_id = c.candidato_id)            AS num_habilidades,
        (SELECT COUNT(*) FROM candidato_certificacion
         WHERE candidato_id = c.candidato_id)            AS num_certificaciones,
        (SELECT COUNT(*) FROM experiencia
         WHERE candidato_id = c.candidato_id)            AS num_experiencias
    FROM candidato c
    ORDER BY total_postulaciones DESC, num_habilidades DESC
    LIMIT p_limite;
END$$

-- pkg_reportes.actividad_mensual
DROP PROCEDURE IF EXISTS pkg_reportes__actividad_mensual$$
CREATE PROCEDURE pkg_reportes__actividad_mensual(
    IN p_anio  INT,
    IN p_mes   INT
)
BEGIN
    SET p_anio = IFNULL(p_anio, YEAR(CURDATE()));
    SET p_mes  = IFNULL(p_mes,  MONTH(CURDATE()));

    -- Vacantes publicadas en el periodo
    SELECT 'vacantes_publicadas' AS metrica,
           COUNT(*)              AS valor
    FROM   empleos_vacante
    WHERE  YEAR(fecha_publicacion) = p_anio
      AND  MONTH(fecha_publicacion) = p_mes

    UNION ALL

    -- Postulaciones recibidas en el periodo
    SELECT 'postulaciones_recibidas',
           COUNT(*)
    FROM   empleos_postulacion
    WHERE  YEAR(fecha_postulacion) = p_anio
      AND  MONTH(fecha_postulacion) = p_mes

    UNION ALL

    -- Candidatos nuevos registrados en el periodo
    SELECT 'candidatos_nuevos',
           COUNT(*)
    FROM   candidato
    WHERE  YEAR(fecha_creacion) = p_anio
      AND  MONTH(fecha_creacion) = p_mes

    UNION ALL

    -- Empresas nuevas registradas en el periodo
    SELECT 'empresas_nuevas',
           COUNT(*)
    FROM   empresa
    WHERE  YEAR(fecha_creacion) = p_anio
      AND  MONTH(fecha_creacion) = p_mes;
END$$

DELIMITER ;

-- -----------------------------------------------------------------
-- Registrar paquetes en tabla de metadatos
-- -----------------------------------------------------------------
INSERT IGNORE INTO pkg_registro (paquete, procedimiento, descripcion, version) VALUES
  ('pkg_candidatos', 'pkg_candidatos__registrar',              'Registra un nuevo candidato validando duplicados', '1.0'),
  ('pkg_candidatos', 'pkg_candidatos__obtener_perfil_completo','Devuelve 5 result-sets con el perfil completo',    '1.0'),
  ('pkg_candidatos', 'pkg_candidatos__estadisticas',           'Estadísticas de postulaciones de un candidato',   '1.0'),
  ('pkg_ofertas',    'pkg_ofertas__publicar',                  'Publica una vacante con validaciones de negocio',  '1.0'),
  ('pkg_ofertas',    'pkg_ofertas__buscar',                    'Búsqueda filtrada de vacantes activas',            '1.0'),
  ('pkg_ofertas',    'pkg_ofertas__dashboard_empresa',         'Dashboard de vacantes y postulaciones por empresa','1.0'),
  ('pkg_reportes',   'pkg_reportes__kpis_generales',           'KPIs generales de la plataforma',                 '1.0'),
  ('pkg_reportes',   'pkg_reportes__top_candidatos',           'Top N candidatos por actividad',                  '1.0'),
  ('pkg_reportes',   'pkg_reportes__actividad_mensual',        'Métricas de actividad de un mes específico',      '1.0');
