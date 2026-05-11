-- ============================================
-- 07. DISTRIBUCIÓN DE CUARTILES POR AÑO
-- Análisis de calidad científica por paper único
-- ============================================

WITH papers_unicos AS (
    SELECT
        titulo,
        anio,
        MAX(q) AS cuartil
    FROM publicaciones_inta_limpio
    GROUP BY titulo, anio
)

SELECT
    anio,
    cuartil,
    COUNT(*) AS total_papers,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY anio),
        2
    ) AS porcentaje_anual
FROM papers_unicos
WHERE cuartil IS NOT NULL
GROUP BY anio, cuartil
ORDER BY anio, cuartil;