-- ============================================
-- 04. TOP 3 DISCIPLINAS POR AÑO
-- Identificación de áreas científicas dominantes
-- ============================================

WITH conteo AS (
    SELECT
        anio,
        disciplina_final,
        COUNT(*) AS registros_disciplina
    FROM publicaciones_inta_limpio
    GROUP BY anio, disciplina_final
),

ranking AS (
    SELECT
        anio,
        disciplina_final,
        registros_disciplina,
        RANK() OVER (
            PARTITION BY anio
            ORDER BY registros_disciplina DESC
        ) AS ranking_anual
    FROM conteo
)

SELECT
    anio,
    disciplina_final,
    registros_disciplina,
    ranking_anual
FROM ranking
WHERE ranking_anual <= 3
ORDER BY anio, ranking_anual;