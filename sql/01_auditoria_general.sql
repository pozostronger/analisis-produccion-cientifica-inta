-- ============================================
-- 01. AUDITORÍA GENERAL DEL DATASET
-- Proyecto: Producción Científica INTA 2015-2025
-- ============================================

SELECT
    COUNT(*) AS total_registros,
    COUNT(DISTINCT titulo) AS titulos_unicos,
    COUNT(DISTINCT anio) AS años_cubiertos,
    MIN(anio) AS primer_año,
    MAX(anio) AS ultimo_año,

    COUNT(DISTINCT disciplina_final) AS disciplinas_unicas,

    SUM(CASE WHEN disciplina_final = 'unclassified' THEN 1 ELSE 0 END) AS registros_unclassified,

    ROUND(
        SUM(CASE WHEN disciplina_final = 'unclassified' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS porcentaje_unclassified,

    SUM(CASE WHEN primer_autor_inta = 'si' THEN 1 ELSE 0 END) AS registros_primer_autor_inta,

    ROUND(
        SUM(CASE WHEN primer_autor_inta = 'si' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS porcentaje_primer_autor_inta,

    SUM(CASE WHEN "if" IS NOT NULL THEN 1 ELSE 0 END) AS registros_con_if,

    ROUND(
        SUM(CASE WHEN "if" IS NOT NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS porcentaje_con_if

FROM publicaciones_inta_limpio;