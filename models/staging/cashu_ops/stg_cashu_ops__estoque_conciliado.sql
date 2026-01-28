with source as (
    select
        -- Identifiers
        $1:"id_inv_fin_item"::bigint as id_inv_fin_item,
        $1:"uid_inst"::varchar as uid_inst,
        $1:"custom_id"::varchar as uid_custom,
        $1:"id_interno"::varchar as id_interno,
        $1:"id"::bigint as id,
        -- Dates
        to_timestamp(($1:"issue_date"::int/1e9)::int)::date as issue_date,
        to_timestamp(($1:"due_date"::int/1e9)::int)::date as due_date,
        to_timestamp(($1:"pymt_date"::int/1e9)::int)::date as pymt_date,
        --$1:"due_date"::date as due_date,
        --$1:"pymt_date"::date as pymt_date,
        -- Timestamps
        to_timestamp(($1:"created_at"::int/1e9)::int)::date as created_at,
        to_timestamp(($1:"anticipated_at"::int/1e9)::int)::date as anticipated_at,
        --$1:"created_at"::timestamp as created_at,
        --$1:"anticipated_at"::timestamp as anticipated_at,
        -- Codes
        $1:"name_slug"::varchar as cd_name_slug,
        $1:"chave_nfe"::varchar as cd_nfe_key,
        -- Amounts
        $1:"amt_total"::float as amt_total,
        $1:"amt_net"::float as amt_net,
        $1:"amt_paid"::float as amt_paid,
        $1:"amt_int"::float as amt_int,
        $1:"amt_pnlt"::float as amt_pnlt

    from {{ source('bronze', 'raw_cashu_ops__estoque_conciliado') }}
)
select *
from source
