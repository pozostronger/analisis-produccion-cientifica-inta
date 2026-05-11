-- ============================================
-- 06. FACTOR DE IMPACTO ANUAL
-- Evolución de publicaciones con IF
-- ============================================

-- ============================================
-- 06. FACTOR DE IMPACTO ANUAL POR PAPER ÚNICO
-- Evita duplicación generada por múltiples disciplinas
-- ============================================

WITH papers_unicos AS (
    SELECT
        titulo,
        anio,
        MAX(CAST("if" AS REAL)) AS factor_impacto,
        MAX(CAST(if_5y AS REAL)) AS factor_impacto_5y,
        MAX(q) AS cuartil
    FROM publicaciones_inta_limpio
    GROUP BY titulo, anio
)

SELECT
    anio,
    COUNT(*) AS total_papers_unicos,

    SUM(CASE 
        WHEN factor_impacto IS NOT NULL THEN 1 
        ELSE 0 
    END) AS papers_con_if,

    ROUND(
        SUM(CASE WHEN factor_impacto IS NOT NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS porcentaje_con_if,

    ROUND(AVG(factor_impacto), 2) AS promedio_if,
    ROUND(MAX(factor_impacto), 2) AS maximo_if,

    ROUND(AVG(factor_impacto_5y), 2) AS promedio_if_5y

FROM papers_unicos
GROUP BY anio
ORDER BY anio;