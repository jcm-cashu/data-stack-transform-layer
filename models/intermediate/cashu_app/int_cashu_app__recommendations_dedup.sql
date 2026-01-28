select
    *
from {{ ref('stg_cashu_app__recommendations') }}
qualify row_number() over (partition by ref_date,tp_model_suggest,id_cust order by created_at desc) = 1