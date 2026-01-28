select
    -- Identifiers
    id as id_inv_fin,
    invoice_group_id as id_inv_group,
    business_id as id_business,
    corporate_id as id_corp,

    -- Names
    name as nm_inv_fin,

    -- Amounts
    total_invoice_value_without_fees as amt_tot_net,

    -- Status
    status as st_inv_fin,
    resale_status as st_resale,

    -- Descriptions
    resale_message as desc_resale,

    -- Timestamps
    created_at,
    updated_at

from {{ source('bronze', 'raw_cashu_app__invoice_financings') }}
qualify rank() over(partition by id order by _etl_loaded_at desc) = 1
