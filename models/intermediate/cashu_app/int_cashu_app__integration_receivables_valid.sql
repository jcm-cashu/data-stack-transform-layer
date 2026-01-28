select
c.id_cust,
i.*
from {{ ref('stg_cashu_app__integration_receivables') }} i
inner join {{ref('stg_cashu_app__customers')}} c on i.nr_gov_id_cust = c.nr_doc
where i.st_ttl <> 'CANCELADO'