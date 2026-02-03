SELECT
	*
FROM {{ ref('int_cashu_app__modelos_experimentos_dedup') }}
where IS_APPROVED = TRUE
