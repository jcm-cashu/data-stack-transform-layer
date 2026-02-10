with source as (
    select
        -- Dates
        $1:"sponsor_payment_date"::date as pymt_date_debtor,
        $1:"payment_info_date"::date as pymt_info_date,

        -- Identifiers
        $1:"your_number"::varchar as nr_cnab_ctrl,
        $1:"document_number"::varchar as nr_cnab_doc,
        $1:"external_id"::varchar as id_external,
        $1:"acquisition_bond_id"::varchar as id_acq_bond,
        $1:"installment_id"::varchar as id_inst,
        $1:"installment_number"::varchar as nr_inst,

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

    from {{ source('bronze', 'raw_kanastra__liquidacoes') }}
)

select *
from source
