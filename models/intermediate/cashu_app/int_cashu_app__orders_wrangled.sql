SELECT
	oi.*,
	c.name_slug cd_slug_corp,
	p1.nm_legal nm_seller,
	p2.nm_legal nm_buyer,
FROM {{ ref('stg_cashu_app__orders') }} o
inner join {{ ref('stg_cashu_app__order_installments') }} oi on o.id_ord  = oi.id_ord
left join {{ ref('dim_parties') }} p1 on p1.nr_gov_id = o.nr_doc_seller
left join {{ ref('dim_parties') }} p2 on p2.nr_gov_id = o.nr_doc_buyer 
left join {{ source('bronze', 'raw_cashu_app__corporates') }} c on c.id = o.id_corp 