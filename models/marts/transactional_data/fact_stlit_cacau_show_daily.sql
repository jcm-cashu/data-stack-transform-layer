{{
  config(
    materialized='table',
    schema='fact_data'
  )
}}

SELECT
	tb.*,
	cs.TP_STORE,
	iff(cs.IS_OPERABLE, COALESCE(cs.OPERABLE_AT,'2000-01-01'::Date),null) store_operable_date,
	COALESCE(cs.CD_TIER,'Sem Tier') cd_store_tier,
	iff(store_operable_date <= date,TRUE,false) is_store_operable
FROM {{ref('fact_cashu_customer_daily')}} tb
LEFT JOIN {{ref('stg_cashu_ops__cacau_show_stores')}} cs ON tb.NR_GOV_ID_ISSUER = cs.NR_GOV_ID_ISSUER 
WHERE CD_NAME_SLUG = 'cacau_show'