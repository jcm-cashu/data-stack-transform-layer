{{
  config(
    materialized='table',
    schema='fact_data'
  )
}}

select
    ttl_issue_at::date ttl_issue_date,
	cd_name_slug,
	id_corp,
	nr_gov_id_cust,
	nr_gov_id_issuer,
	nr_nfe_doc id_ord,
	rank() over(partition by id_ord order by ttl_due_date_curr) id_installment,
	max(ttl_due_date_curr::Date) over(partition by id_ord order by ttl_due_date_curr) - ttl_issue_date qty_due_days,
	ttl_due_date_curr::date ttl_due_date_curr,
	amt_ttl_gross amt_installment,
	iff(ttl_pymt_at is null, null, amt_ttl_net) amt_paid,
	ttl_pymt_at::date ttl_pymt_date,
	tp_ttl_pymt,
	iff(len(nr_gov_id_cust)=14,'pj','pf') tp_person_cust
from {{ref('int_cashu_app__integration_receivables_valid')}}
where tp_ttl_pymt = 'BOL' and st_ttl_oper  = 'ativo_antecipado'
