with source as (
    select
        -- Dates
        $1:"reference_date"::date as ref_date,
        $1:"payment_info_date"::date as pymt_info_date,

        -- Identifiers
        $1:"external_id"::varchar as id_external,

        -- Parties - Fund/Operation
        {{ standardize_bz_gov_id('$1:"operation_government_id"::varchar') }} as nr_gov_id_fund,
        $1:"operation_slug"::varchar as cd_slug_oper,

        -- Type
        $1:"liquidation_type"::varchar as tp_liquidation,

        -- Amounts
        $1:"payment_amount"::float as amt_pymt,
        $1:"future_amount"::float as amt_future,

        -- Metadata
        $1:"_loaded_at"::timestamp as created_at,
        $1:"_execution_id"::varchar as cd_repl_key,
        $1:"_slug"::varchar as cd_slug

    from {{ source('bronze', 'raw_kanastra__recompras') }}
)

select *
from source

