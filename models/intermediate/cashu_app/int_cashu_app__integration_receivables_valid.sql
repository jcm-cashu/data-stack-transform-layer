/*with cashu_boleto as (
    select
        distinct
        cd_nfe_key,
        'BOL CASHU' as tp_ttl_pymt
    from {{ ref('int_cashu__invoice_receivables_curated') }}
)*/
select
    c.id_cust,
    i.*-- exclude(tp_ttl_pymt),
--    coalesce(b.tp_ttl_pymt,i.tp_ttl_pymt) as tp_ttl_pymt
from {{ ref('stg_cashu_app__integration_receivables') }} i
inner join {{ref('stg_cashu_app__customers')}} c on i.nr_gov_id_cust = c.nr_doc and i.id_corp = c.id_corp
--left join cashu_boleto b on b.cd_nfe_key = i.nr_nfe_doc
where i.st_ttl <> 'CANCELADO'
qualify rank() over(partition by i.id_recv order by c.created_at desc) = 1
