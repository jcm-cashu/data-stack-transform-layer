{{
  config(
    materialized='table',
    schema='silver'
  )
}}


WITH old_base_tmp AS (
	SELECT
		t1.cd_name_slug,
		t1.CD_NFE_KEY,
		t2.id_corp,
		t2.ID_INV_FIN_ITEM,
		t2.ID_RECV,
		t2.ID_INV_FIN,
		t2.ID_ORD_INST,
		t2.ID_BNK_RESALE,
		t2.nr_gov_id_seller,
		t2.nr_gov_id_buyer,
		t2.nm_seller,
		t2.nm_buyer,
		t1.DUE_DATE,
		t1.ISSUE_DATE,
		t1.anticipated_at,
		t1.PYMT_DATE,
		t2.STTL_DATE_RESALE,
		t1.CREATED_AT,
		t1.AMT_TOTAL,
		t1.AMT_NET,
		t1.AMT_PAID,
		t1.AMT_INT,
		t1.AMT_PNLT,
		t2.AMT_COST_TRANSF,
		t2.AMT_FEE_PROC,
		t2.AMT_FEE_FIN,
		t2.AMT_FEE_MDR,
		t2.TP_RATE,
		TRUE is_antcp
	FROM {{ ref('stg_cashu_ops__estoque_conciliado') }} t1
	LEFT JOIN {{ ref('int_cashu_app__invoice_financing_items_wrangled') }} t2 ON t1.id_inv_fin_item = t2.ID_INV_FIN_ITEM
), old_base_freeze_paid AS (
	SELECT
		*
	FROM old_base_tmp
	WHERE pymt_date IS NOT NULL
), old_base_freeze_not_paid AS (
	SELECT
		t1.cd_name_slug,
		t1.CD_NFE_KEY,
		t2.id_corp,
		t2.ID_INV_FIN_ITEM,
		t2.ID_RECV,
		t2.ID_INV_FIN,
		t2.ID_ORD_INST,
		t2.ID_BNK_RESALE,
		t2.nr_gov_id_seller,
		t2.nr_gov_id_buyer,
		t2.nm_seller,
		t2.nm_buyer,
		t1.DUE_DATE,
		t2.ISSUE_DATE,
		t1.ANTICIPATED_AT::Date anticipated_at,
		t2.PYMT_DATE,
		t2.STTL_DATE_RESALE,
		t2.CREATED_AT,
		t2.AMT_TOTAL,
		t2.AMT_NET,
		t2.AMT_PAID,
		t2.AMT_INT,
		t2.AMT_PNLT,
		t2.AMT_COST_TRANSF,
		t2.AMT_FEE_PROC,
		t2.AMT_FEE_FIN,
		t2.AMT_FEE_MDR,
		t2.TP_RATE,
		TRUE is_antcp
	FROM old_base_tmp t1
	LEFT JOIN {{ ref('int_cashu_app__invoice_financing_items_wrangled') }} t2 ON t1.ID_INV_FIN_ITEM = t2.ID_INV_FIN_ITEM
	WHERE t1.pymt_date IS NULL
), old_base_freeze AS (
	SELECT
		*
	FROM old_base_freeze_paid
	UNION ALL
	SELECT
		*
	FROM old_base_freeze_not_paid
), kanastra AS (
	SELECT
		t1.cd_name_slug,
		t1.CD_NFE_KEY,
		t2.id_corp,
		t2.ID_INV_FIN_ITEM,
		t2.ID_RECV,
		t2.ID_INV_FIN,
		t2.ID_ORD_INST,
		t2.ID_BNK_RESALE,
		t2.nr_gov_id_seller,
		t2.nr_gov_id_buyer,
		t2.nm_seller,
		t2.nm_buyer,
		t1.DUE_DATE,
		t2.ISSUE_DATE,
		t1.ref_date::Date anticipated_at,
		t2.PYMT_DATE,
		t2.STTL_DATE_RESALE,
		t2.CREATED_AT,
		t2.AMT_TOTAL,
		t2.AMT_NET,
		t2.AMT_PAID,
		t2.AMT_INT,
		t2.AMT_PNLT,
		t2.AMT_COST_TRANSF,
		t2.AMT_FEE_PROC,
		t2.AMT_FEE_FIN,
		t2.AMT_FEE_MDR,
		t2.TP_RATE,
		TRUE is_antcp
	FROM {{ ref('int_kanastra__aquisicoes_with_invoice') }} t1
	LEFT JOIN {{ ref('int_cashu_app__invoice_financing_items_wrangled') }} t2 ON t1.id_inv_fin_item = t2.ID_INV_FIN_ITEM
	LEFT JOIN old_base_freeze t3 ON t3.ID_INV_FIN_ITEM = t1.ID_INV_FIN_ITEM
	WHERE t3.id_inv_fin_item IS NULL AND t1.ref_date > '2026-01-09'
)
SELECT
*
FROM old_base_freeze
UNION ALL
SELECT
*
FROM kanastra
