{{
  config(
    materialized='table',
    schema='fact_data'
  )
}}

with tb as (
    select
        c.date,
        r.*
    from {{ ref('int_cashu_app__recommendations_wrangled') }} r
    inner join {{ ref('dim_calendar') }} c on c.date between r.ref_date and r.recomendation_date_validity
    qualify rank() over(partition by c.date,r.id_cust,r.id_corp order by r.precedence_order, r.recomendation_date_validity desc) = 1
)
select
    date ref_date,
    id_cust,
    id_corp,
    amt_credit_limit_new,
    qty_due_days,
    tp_model_suggest
from tb