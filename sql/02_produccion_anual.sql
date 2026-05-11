-- ============================================
-- 02. PRODUCCIÓN CIENTÍFICA ANUAL
-- Evolución de publicaciones por año
-- ============================================

WITH produccion_anual AS (
    SELECT
        anio,
        COUNT(DISTINCT titulo) AS publicaciones
    FROM publicaciones_inta_limpio
    GROUP BY anio
),

variacion AS (
    SELECT
        anio,
        publicaciones,
        LAG(publicaciones) OVER (ORDER BY anio) AS publicaciones_anio_anterior
    FROM produccion_anual
)

SELECT
    anio,
    publicaciones,
    publicaciones_anio_anterior,
    publicaciones - publicaciones_anio_anterior AS variacion_absoluta,
    ROUND(
        (publicaciones - publicaciones_anio_anterior) * 100.0 / publicaciones_anio_anterior,
        2
    ) AS variacion_porcentual
FROM variacion
ORDER BY anio;