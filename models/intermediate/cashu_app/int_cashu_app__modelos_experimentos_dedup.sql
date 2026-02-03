SELECT
	*
FROM {{ ref('stg_cashu_app__movimentacao_modelos_experimentos') }}
QUALIFY RANK() over(PARTITION BY ID_MODEL_EXP, ID_MODEL, NR_DOC ORDER BY CREATED_AT DESC) = 1