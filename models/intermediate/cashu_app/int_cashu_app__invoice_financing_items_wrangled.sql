with tb as (
SELECT 
	t7.CD_NAME_SLUG,
	t7.ID_CORP,
	t8.ID_BILLET,
    t4.id_business,
	t2.nr_gov_id_seller,
	t2.nm_seller,
	t2.nr_gov_id_buyer,
	t2.nm_buyer,
	t1.*,
	t3.PYMT_DATE::date pymt_date,
	t3.AMT_PAID,
	t3.AMT_INT,
	t3.AMT_PNLT,
	t3.ST_BILLET,
	t6.CD_NFE_KEY,
	t2.st_inst
FROM {{ ref('stg_cashu_app__invoice_financing_items') }} t1
LEFT JOIN {{ ref('stg_cashu_app__invoice_receivables') }} t5 ON t5.ID_INV_RECV  = t1.ID_RECV 
LEFT JOIN {{ ref('int_cashu_app__orders_wrangled') }} t2 ON t1.ID_ORD_INST = t2.ID_ORD_INST
LEFT JOIN {{ ref('stg_cashu_app__bank_billets') }} t3 ON t2.ID_BILLET  = t3.ID_BILLET 
left join {{ ref('stg_cashu_app__invoice_financings') }} t4 on t4.id_inv_fin = t1.ID_INV_FIN
left join {{ ref('stg_cashu_app__corporates') }} t7 on t7.id_corp = t4.ID_CORP
LEFT JOIN {{ ref('stg_cashu_app__invoices') }} t6 ON t6.id_inv = t5.ID_INV
left join {{ ref('stg_cashu_app__bank_billets') }} t8 on t8.id_billet = t2.ID_BILLET
)
select * from tb
union all
select * from {{ ref('int_cashu_app__cnab_operations_like_financing_items') }}