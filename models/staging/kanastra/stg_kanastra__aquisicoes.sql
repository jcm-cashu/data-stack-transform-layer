with source as (
    select
        -- Dates
        $1:"reference_date"::date as ref_date,
        $1:"due_date"::date as due_date,

        -- Identifiers
        $1:"your_number"::varchar as nr_cnab_ctrl,
        $1:"document_number"::varchar as nr_cnab_doc,
        $1:"external_id"::varchar as id_external,
        $1:"installment"::varchar as nr_inst,

        -- Parties - Fund/Operation
        {{ standardize_bz_gov_id('$1:"operation_government_id"::varchar') }} as nr_gov_id_fund,
        $1:"operation_slug"::varchar as cd_slug_oper,

        -- Parties - Sponsor/Cedent
        {{ standardize_bz_gov_id('$1:"sponsor_government_id"::varchar') }} as nr_gov_id_cedent,
        $1:"sponsor_name"::varchar as nm_cedent,

        -- Parties - Seller/Debtor
        {{ standardize_bz_gov_id('$1:"seller_government_id"::varchar') }} as nr_gov_id_debtor,
        $1:"seller_name"::varchar as nm_debtor,

        -- Type
        $1:"asset_type"::varchar as tp_recv,

        -- Amounts
        $1:"acquisition_price"::float as amt_acq,
        $1:"future_amount"::float as amt_future,

        -- Rates
        $1:"document_interest_rate"::float as rate_int_doc,

        -- Booleans
        $1:"coobligation"::boolean as has_coobl,
        $1:"_loaded_at"::timestamp as created_at,
        $1:"_execution_id"::varchar as cd_repl_key,
        $1:"_slug"::varchar as cd_slug

    from {{ source('bronze', 'raw_kanastra__aquisicoes') }}
)

select *
from source
