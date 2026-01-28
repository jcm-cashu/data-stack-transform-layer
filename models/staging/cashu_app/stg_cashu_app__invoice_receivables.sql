select
    -- Identifiers
    id as id_inv_recv,
    invoice_id as id_inv,
    identification_number as nr_id,

    -- Dates
    due_on as due_date,
    closest_business_date_for_due_on as due_date_business,

    -- Amounts
    amount as amt_recv,

    -- Timestamps
    created_at,
    updated_at

from {{ source('bronze', 'raw_cashu_app__invoice_receivables') }}
qualify rank() over(partition by id order by _etl_loaded_at desc) = 1
