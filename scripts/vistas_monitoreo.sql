-- ============================================================
--  SISTEMA DE MONITOREO - VISTAS DBA
--  Base de datos: bolsa_trabajo (MySQL 8.0)
--  Descripción : 5 vistas orientadas a que el DBA identifique
--                de un vistazo los puntos calientes del sistema.
-- ============================================================

USE bolsa_trabajo;

-- ------------------------------------------------------------
-- VISTA 1 – TOP 10 QUERIES MÁS LENTOS (Performance Schema)
--   Muestra las 10 consultas con mayor tiempo de ejecución
--   promedio registradas por performance_schema.
--   Requiere: performance_schema=ON (activo por defecto en MySQL 8).
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_top10_queries_lentos AS
SELECT
    ROUND(avg_timer_wait / 1e12, 4)          AS avg_seg,
    ROUND(max_timer_wait / 1e12, 4)          AS max_seg,
    count_star                               AS ejecuciones,
    ROUND(sum_rows_examined / count_star, 0) AS filas_examinadas_prom,
    ROUND(sum_rows_sent    / count_star, 0)  AS filas_enviadas_prom,
    LEFT(digest_text, 200)                   AS query_resumen,
    schema_name                              AS base_datos,
    last_seen                                AS ultima_ejecucion
FROM performance_schema.events_statements_summary_by_digest
WHERE schema_name = 'bolsa_trabajo'
  AND count_star  > 0
ORDER BY avg_timer_wait DESC
LIMIT 10;


-- ------------------------------------------------------------
-- VISTA 2 – TOP 10 QUERIES QUE MÁS FILAS EXAMINAN
--   Queries con alto ratio examinadas/enviadas son candidatos
--   a optimización de índices.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_top10_queries_costosos AS
SELECT
    count_star                                             AS ejecuciones,
    ROUND(sum_rows_examined / count_star, 0)               AS filas_examinadas_prom,
    ROUND(sum_rows_sent     / count_star, 0)               AS filas_enviadas_prom,
    ROUND((sum_rows_examined - sum_rows_sent)
          / NULLIF(sum_rows_examined, 0) * 100, 1)         AS pct_desperdicio,
    ROUND(sum_timer_wait / 1e12, 4)                        AS tiempo_total_seg,
    LEFT(digest_text, 200)                                 AS query_resumen,
    last_seen                                              AS ultima_ejecucion
FROM performance_schema.events_statements_summary_by_digest
WHERE schema_name = 'bolsa_trabajo'
  AND count_star  > 0
  AND sum_rows_examined > 0
ORDER BY filas_examinadas_prom DESC
LIMIT 10;


-- ------------------------------------------------------------
-- VISTA 3 – TOP 10 USUARIOS CON MÁS SESIONES ACTIVAS
--   Combina usuario, host y número de conexiones actuales.
--   Ayuda a detectar connection pools mal configurados o
--   usuarios con demasiadas conexiones abiertas.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_top10_usuarios_sesiones AS
SELECT
    p.user                                      AS usuario,
    p.host                                      AS host_cliente,
    COUNT(*)                                    AS sesiones_totales,
    SUM(p.command = 'Sleep')                    AS sesiones_dormidas,
    SUM(p.command != 'Sleep')                   AS sesiones_activas,
    MAX(p.time)                                 AS tiempo_max_seg,
    ROUND(AVG(p.time), 1)                       AS tiempo_prom_seg
FROM information_schema.PROCESSLIST AS p
WHERE p.user IS NOT NULL
GROUP BY p.user, p.host
ORDER BY sesiones_totales DESC
LIMIT 10;


-- ------------------------------------------------------------
-- VISTA 4 – ESTADO DE POSTULACIONES POR VACANTE
--   Vista de negocio + operaciones: muestra el embudo de
--   selección para cada vacante activa. Útil para detectar
--   vacantes con alta carga de inserts/updates concurrentes.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_estado_postulaciones_vacante AS
SELECT
    v.id                                                   AS vacante_id,
    v.titulo                                               AS titulo_vacante,
    e.nombre                                               AS empresa,
    v.estado                                               AS estado_vacante,
    v.fecha_limite,
    COUNT(p.id)                                            AS total_postulaciones,
    SUM(p.estado = 'PENDIENTE')                            AS pendientes,
    SUM(p.estado = 'REVISADO')                             AS revisadas,
    SUM(p.estado = 'ENTREVISTA')                           AS en_entrevista,
    SUM(p.estado = 'ACEPTADO')                             AS aceptadas,
    SUM(p.estado = 'RECHAZADO')                            AS rechazadas,
    MAX(p.fecha_postulacion)                               AS ultima_postulacion
FROM empleos_vacante  AS v
JOIN empleos_empresa  AS e  ON e.id = v.empresa_id
LEFT JOIN empleos_postulacion AS p ON p.vacante_id = v.id
GROUP BY v.id, v.titulo, e.nombre, v.estado, v.fecha_limite
ORDER BY total_postulaciones DESC;


-- ------------------------------------------------------------
-- VISTA 5 – RESUMEN DE SALUD DE TABLAS (tamaño + fragmentación)
--   Muestra todas las tablas con sus métricas de disco, número
--   de filas estimado y porcentaje de espacio desperdiciado.
--   El DBA la usa para planificar OPTIMIZE TABLE y backups.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW vw_salud_tablas AS
SELECT
    table_name                                             AS tabla,
    table_rows                                             AS filas_estimadas,
    ROUND(data_length  / 1024, 1)                          AS datos_kb,
    ROUND(index_length / 1024, 1)                          AS indices_kb,
    ROUND((data_length + index_length) / 1024, 1)          AS total_kb,
    ROUND(data_free    / 1024, 1)                          AS libre_kb,
    ROUND(data_free / NULLIF(data_length + index_length, 0) * 100, 1) AS pct_fragmentacion,
    CASE
        WHEN ROUND(data_free / NULLIF(data_length + index_length, 0) * 100, 1) >= 95
             THEN '🔴 CRÍTICO'
        WHEN ROUND(data_free / NULLIF(data_length + index_length, 0) * 100, 1) >= 85
             THEN '🟡 WARNING'
        ELSE      '🟢 OK'
    END                                                    AS estado,
    engine                                                 AS motor,
    create_time                                            AS creada,
    update_time                                            AS ultima_modificacion
FROM information_schema.TABLES
WHERE table_schema = 'bolsa_trabajo'
ORDER BY pct_fragmentacion DESC, total_kb DESC;


-- ============================================================
-- GUÍA DE USO RÁPIDO
-- ============================================================
--  Queries más lentos en ejecución:
--    SELECT * FROM vw_top10_queries_lentos;
--
--  Queries que más filas escanean (candidatos a índices):
--    SELECT * FROM vw_top10_queries_costosos;
--
--  Usuarios con muchas conexiones abiertas:
--    SELECT * FROM vw_top10_usuarios_sesiones;
--
--  Embudo de postulaciones por vacante:
--    SELECT * FROM vw_estado_postulaciones_vacante;
--
--  Salud de todas las tablas:
--    SELECT * FROM vw_salud_tablas;
