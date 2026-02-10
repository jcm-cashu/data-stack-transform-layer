select
    -- Identifiers
    id as id_cnab,

    -- Status
    status as st_cnab,

    -- Types
    cnab_type as tp_cnab,
    payment_type as tp_pymt,

    -- Dates
    processed_at,
    reference_date as ref_date,

    -- Codes
    financial_institution_slug as cd_fin_inst_slug,

    -- Amounts
    total_net_amount as amt_tot_net,
    total_gross_amount as amt_tot_gross,

    -- Timestamps
    created_at,
    updated_at

from {{ source('bronze', 'raw_cashu_app__cnabs') }}
qualify rank() over(partition by id order by _etl_loaded_at desc) = 1

