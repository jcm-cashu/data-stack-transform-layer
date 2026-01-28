{{ config(schema='master_data', materialized='table',name='dim_anbima_calendar') }}

with tb as (
SELECT 
	last_value(a.id ignore nulls) over (order by c.date rows between unbounded preceding and current row) rank_prev,
	last_value(a.id ignore nulls) over (order by c.date desc rows between unbounded preceding and current row) rank_next,
	iff(rank_next = rank_prev,true,false) is_business_day,
	c.*
from {{ ref('dim_calendar') }} c
left join {{ source('bronze', 'raw_cashu_app__calendario_anbima') }} a on c.date = a.date
where c.date > '2001-01-01'
order by c.date
)
select
rank_prev,
min(date) over(partition by rank_prev order by date) date_adj_prev,
rank_next,
max(date) over(partition by rank_next order by date desc) date_adj_next,
* exclude(rank_prev,rank_next),
from tb