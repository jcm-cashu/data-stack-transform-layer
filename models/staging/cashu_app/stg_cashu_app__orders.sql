select
    id as id_ord,
    customer_id as id_cust,
    external_id as id_external,
    order_date,
    {{standardize_bz_gov_id('seller_document')}} as nr_doc_seller,
    {{standardize_bz_gov_id('buyer_document')}} as nr_doc_buyer,
    created_at,
    updated_at,
    corporate_id as id_corp,
    status as st_ord,
    order_group as cd_ord_group,
    processing_set_at as proc_set_at,
    invoiced_set_at as inv_set_at,
    canceled_set_at,
    freezing as is_freezing,
    pre_invoiced_set_at as pre_inv_set_at
from {{ source('bronze', 'raw_cashu_app__orders') }}
qualify rank() over(partition by id order by _etl_loaded_at desc) = 1