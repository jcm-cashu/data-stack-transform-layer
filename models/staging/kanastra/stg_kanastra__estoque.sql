with source as (
    select 
        -- Dates
        $1:"reference_dt"::date as ref_date,
        $1:"emission_date"::date as issue_date,
        $1:"acquisition_date"::date as acq_date,
        $1:"fund_date"::date as fund_date,
        $1:"due_date"::date as due_date,
        $1:"adjusted_due_date"::date as due_date_adj,

        -- Identifiers
        $1:"id"::varchar as id_asset,
        $1:"uid"::varchar as id_uid,
        $1:"external_id"::bigint as id_external,
        $1:"acquisition_bond_id"::bigint as id_acq_bond,
        $1:"your_number"::varchar as nr_cnab_ctrl,
        $1:"document_number"::varchar as nr_cnab_doc,

        -- Parties - Fund/Operation
        {{ standardize_bz_gov_id('$1:"operation_government_id"::varchar') }} as nr_gov_id_fund,
        $1:"operation_slug"::varchar as cd_slug_oper,
        $1:"operation_name"::varchar as nm_oper,

        -- Parties - Sponsor/Cedent
        {{ standardize_bz_gov_id('$1:"sponsor_government_id"::varchar') }} as nr_gov_id_cedent,
        $1:"sponsor_name"::varchar as nm_cedent,
        $1:"sponsor_person_type"::varchar as tp_person_cedent,

        -- Parties - Seller/Debtor
        {{ standardize_bz_gov_id('$1:"seller_government_id"::varchar') }} as nr_gov_id_debtor,
        $1:"seller_name"::varchar as nm_debtor,
        $1:"seller_person_type"::varchar as tp_person_debtor,

        -- Type and Status
        $1:"asset_type"::varchar as tp_recv,
        $1:"status"::int as st_asset,

        -- Amounts
        $1:"future_amount"::float as amt_face,
        $1:"present_amount"::float as amt_present,
        $1:"acquisition_price"::float as amt_acq,
        $1:"pdd_value"::float as amt_prov,
        $1:"fund_originator"::float as amt_fund_orig,

        -- Rates
        $1:"interest_rate"::float as rate_int,
        $1:"assingment_rate"::float as rate_assign,

        -- Quantities
        $1:"deadline"::int as qty_tenor_days,
        $1:"current_deadline"::int as qty_tenor_days_curr,
        $1:"installment_number"::int as nr_inst,
        $1:"delay_by_document_number"::int as qty_delay_doc,
        $1:"delay_by_sponsor"::int as qty_delay_cedent,

        -- Categories
        $1:"pdd_range"::varchar as cd_prov_range,

        -- Booleans
        $1:"coobligation"::boolean as has_coobl,
        $1:"is_present_amount_calculated"::boolean as is_amt_present_calc,
        $1:"is_pdd_calculated"::boolean as is_prov_calc,

        -- Metadata
        $1:"_loaded_at"::timestamp as created_at,
        $1:"_execution_id"::varchar as cd_repl_key,
        $1:"_slug"::varchar as cd_slug

    from {{ source('bronze', 'raw_kanastra__estoque') }}
)

select *
from source
