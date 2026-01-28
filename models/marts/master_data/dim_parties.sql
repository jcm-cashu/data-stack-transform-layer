{{ config(schema='master_data', materialized='table',name='dim_parties') }}

with manual_input as (
    select
        *
    from {{ source('bronze', 'raw_manual_input__customers') }}
),corporates as (
    select
        -- Identifiers (CNPJ - always 14 chars)
        {{ standardize_cnpj('cnpj') }} as nr_gov_id,

        -- Names
        razao_social as nm_legal

    from {{ source('bronze', 'raw_cashu_app__corporates') }}
), businesses as (
    select
        -- Identifiers (CNPJ - always 14 chars)
        {{ standardize_cnpj('cnpj') }} as nr_gov_id,

        -- Names
        name as nm_legal

    from {{ source('bronze', 'raw_cashu_app__businesses') }}
), customers as (
    select
        -- Identifiers (CPF or CNPJ - smart detection)
        {{ standardize_bz_gov_id('document') }} as nr_gov_id,

        -- Names
        razao_social as nm_legal

    from {{ source('bronze', 'raw_cashu_app__customers') }}
),tb as (
    select 
        *
    from corporates
    union
    select 
        *
    from businesses
    union
    select 
        *
    from customers
    union
    select
        *
    from manual_input
)
select
    {{ dbt_utils.generate_surrogate_key(['nr_gov_id']) }} as id_customer,
    nr_gov_id,
    nm_legal,
    case 
        when length(nr_gov_id) = 11 then 'natural' 
        when length(nr_gov_id) = 14 then 'legal'
        else 'unclassified' 
    end as tp_person
from tb
qualify rank() over (partition by nr_gov_id order by nm_legal desc) = 1