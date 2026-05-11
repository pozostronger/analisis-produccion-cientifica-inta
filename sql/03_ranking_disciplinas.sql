-- ============================================
-- 03. RANKING DE DISCIPLINAS
-- Distribución de publicaciones por disciplina
-- ============================================

WITH total_general AS (
    SELECT COUNT(*) AS total_registros
    FROM publicaciones_inta_limpio
),

ranking AS (
    SELECT
        disciplina_final,
        COUNT(*) AS total_registros,
        COUNT(DISTINCT titulo) AS titulos_unicos,
        RANK() OVER (ORDER BY COUNT(*) DESC) AS ranking_disciplina
    FROM publicaciones_inta_limpio
    GROUP BY disciplina_final
)

SELECT
    r.ranking_disciplina,
    r.disciplina_final,
    r.total_registros,
    r.titulos_unicos,
    ROUND(r.total_registros * 100.0 / tg.total_registros, 2) AS porcentaje_total
FROM ranking r
CROSS JOIN total_general tg
ORDER BY r.ranking_disciplina;