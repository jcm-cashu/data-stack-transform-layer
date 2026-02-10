{{
  config(
    materialized='table',
    schema='fact_data'
  )
}}

WITH first_date AS (
	SELECT 
		least_ignore_nulls(min(x.ref_date),min(y.ttl_issue_at))::date first_date,
		COALESCE(y.id_cust,x.id_cust) id_cust,
		COALESCE(y.id_corp,x.id_corp) id_corp
	FROM {{ ref('fact_daily_credit_recommendations') }} x
	FULL JOIN {{ ref('int_cashu_app__integration_receivables_valid') }} y ON x.id_cust = y.id_cust AND x.ID_CORP = y.ID_CORP
GROUP BY ALL
), base AS (
	SELECT 
		c.date::date date,
		id_cust,
		id_corp,
		f.first_date,
		--c.rank_next rank_du
	from {{ ref('dim_calendar') }} c
	cross join first_date f
	where c.date between f.first_date and CURRENT_TIMESTAMP()::date -- AND ID_CUST = '284169'
), tb AS (
	SELECT
		YEAR(b.date) yr,
		month(b.date) mth,
		b.date,
		r.ID_RECV,
		r.NR_GOV_ID_ISSUER,
		r.CD_NAME_SLUG,
		b.id_corp,
		b.id_cust,
		last_value(rf.amt_credit_limit_new ignore nulls) OVER(PARTITION BY b.id_cust ORDER BY b.date ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) amt_credit_limit,
		last_value(rf.qty_due_days::float ignore nulls) OVER(PARTITION BY b.id_cust ORDER BY b.date ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) qty_due_days,
		r.ttl_issue_at::date ttl_issue_date,
		r.ttl_due_date_curr::date ttl_due_date_curr,
		r.ttl_due_date_orig::date ttl_due_date_orig,
		r.ttl_due_date_curr::date - r.ttl_issue_at::date ttl_due_days_curr,
		r.ttl_due_date_orig::date - r.ttl_issue_at::date ttl_due_days_orig,
		r.ttl_pymt_at::date ttl_pymt_date,
		r.amt_ttl_gross,
		r.amt_ttl_net,
		iff(b.date = ttl_issue_date,r.amt_ttl_gross,0.0) amt_sell,
		iff(b.date = ttl_pymt_date,r.amt_ttl_gross,0.0) amt_received,
		iff(b.date = ttl_pymt_date,r.amt_ttl_int_pnlt,0.0) amt_received_int_pnlt,
		iff(b.date = ttl_pymt_date,r.amt_ttl_disc,0.0) amt_received_disc,
		iff(b.date < ttl_pymt_date OR ttl_pymt_date IS NULL, TRUE, FALSE) is_purchase_active,
		tp_ttl_pymt,
		is_credit_purchase,
		iff(b.date = ttl_pymt_date, TRUE, FALSE ) is_pymt_day,
		iff(b.date = ttl_issue_date, TRUE, FALSE) is_sell_day,
		iff(is_pymt_day, ttl_pymt_date - ttl_due_date_curr::date,null) qty_pymt_due_delta_days,
		coalesce(ttl_pymt_date,current_timestamp()::date) pymt_date_aux,
		iff(pymt_date_aux - ttl_due_date_curr::date > 2 AND tp_ttl_pymt='BOL',TRUE,False) is_pymt_delayed,
		iff(pymt_date_aux - ttl_due_date_curr::date >= 30 AND tp_ttl_pymt='BOL',TRUE,False) is_over_30,
		iff(pymt_date_aux - ttl_due_date_curr::date >= 60 AND tp_ttl_pymt='BOL',TRUE,False) is_over_60,
		iff(pymt_date_aux - ttl_due_date_curr::date >= 90 AND tp_ttl_pymt='BOL',TRUE,False) is_over_90,
		iff(pymt_date_aux - ttl_due_date_curr::date > 180 AND tp_ttl_pymt='BOL',TRUE,False) is_over_180,
		b.date - lag(iff(is_sell_day,ttl_issue_date,null)) ignore nulls over(PARTITION BY b.id_cust ORDER BY b.date ASC, r.ID_RECV) qty_days_last_purchase,
		iff(qty_days_last_purchase IS NULL AND ttl_issue_date IS NOT NULL, TRUE, False) is_first_purchase,
		b.date - lag(iff(is_sell_day,ttl_issue_date,null)) ignore nulls over(PARTITION BY b.id_cust, tp_ttl_pymt ORDER BY b.date ASC, r.ID_RECV) qty_days_last_purchase_tp_pymt,
		iff(qty_days_last_purchase IS NULL AND ttl_issue_date IS NOT NULL, TRUE, False) is_first_purchase_tp_pymt,
		sum(is_sell_day::int) OVER(PARTITION BY mth,yr,b.id_cust ORDER BY id_recv) qty_purchase_mth,
		qty_purchase_mth*iff(is_sell_day AND qty_purchase_mth=1,1,0) is_first_purchase_mth,
		iff(amt_credit_limit IS NOT NULL,TRUE,false) has_credit_limit,
		iff(qty_days_last_purchase>60,TRUE,false) is_cust_inactive,
		iff(qty_days_last_purchase_tp_pymt>60,TRUE,false) is_cust_inactive_tp_pymt
	FROM base b
	left join {{ ref('int_cashu_app__integration_receivables_valid') }} r on r.id_cust = b.id_cust and b.date between r.ttl_issue_at::date and coalesce(r.ttl_pymt_at::date,current_timestamp()::date)
	left join {{ ref('fact_daily_credit_recommendations') }} rf on rf.id_cust = b.id_cust and rf.REF_DATE  = b.date
	left join {{ ref('dim_parties') }} p on p.NR_GOV_ID = r.nr_gov_id_cust
	QUALIFY ttl_due_date_curr is not NULL OR amt_credit_limit IS NOT null
)
SELECT 
	*,
	greatest_ignore_nulls(date - first_value(iff(has_credit_limit,date,null) ignore nulls) over(PARTITION BY id_cust ORDER BY date),0) qty_days_relationship_cashu,
	greatest_ignore_nulls(date - first_value(date ignore nulls) over(PARTITION BY id_cust ORDER BY date),0) qty_days_relationship_slug
FROM tb
