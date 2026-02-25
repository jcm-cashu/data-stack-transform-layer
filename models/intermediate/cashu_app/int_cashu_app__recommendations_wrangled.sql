with tb as (
select
    r.ref_date,
    r.id_cust,
    r.nr_doc,
    c.id_corp,
    amt_credit_limit_new,
    qty_due_days,
    tp_model_suggest,
    case
        when tp_model_suggest = 'manual_recommendation' then 3
        when tp_model_suggest in ('behavioural_based_rule','acceptance_based_rule') then 3
        when tp_model_suggest = ('behavioural_model') then 5
        when tp_model_suggest = 'acceptance_model' then 30
    end as due_days_validity,
    case
        when tp_model_suggest = 'manual_recommendation' then 1
        when tp_model_suggest = 'behavioural_model' then 2
        when tp_model_suggest = 'acceptance_model' then 3
        when tp_model_suggest = 'acceptance_based_rule' then 4
        when tp_model_suggest = 'behavioural_based_rule' then 5
    end as precedence_order
from {{ ref('int_cashu_app__recommendations_dedup') }} r
inner join {{ ref('stg_cashu_app__customers') }} c on r.id_cust = c.id_cust
)
select
    distinct
    r.*,
    dateadd(day, due_days_validity, r.ref_date) as recomendation_date_validity
from tb r
--inner join {{ref('dim_calendar')}} du on r.ref_date = du.date
--inner join {{ref('dim_calendar')}} du1 on du.rank_next + r.due_days_validity = du1.rank_prev
--where du.is_business_day and du1.is_business_day and amt_credit_limit_new > 0
where amt_credit_limit_new > 0