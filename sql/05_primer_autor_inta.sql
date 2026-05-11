-- ============================================
-- 05. LIDERAZGO INSTITUCIONAL
-- Publicaciones con primer autor INTA
-- ============================================

SELECT
    anio,
    primer_autor_inta,
    COUNT(DISTINCT titulo) AS publicaciones,
    ROUND(
        COUNT(DISTINCT titulo) * 100.0 
        / SUM(COUNT(DISTINCT titulo)) OVER (PARTITION BY anio),
        2
    ) AS porcentaje_anual
FROM publicaciones_inta_limpio
WHERE primer_autor_inta IS NOT NULL
GROUP BY anio, primer_autor_inta
ORDER BY anio, primer_autor_inta;