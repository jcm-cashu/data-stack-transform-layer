select
    -- Identifiers
    id as id_corp,
    {{ standardize_bz_gov_id('cnpj') }} as nr_gov_id,
    bank_id as id_bnk,

    -- Names
    razao_social as nm_legal,
    fantasy_name as nm_trading,
    name_slug as cd_name_slug,

    -- Business Info
    ramo_atividade as cd_activity_brch,
    parceiro_comercial as nm_partner,

    -- Booleans
    deliver_bank_billet_to_customer as is_deliver_billet_cust,
    enable_import_business as is_import_business_enabled,

    -- Timestamps
    created_at,
    updated_at

from {{ source('bronze', 'raw_cashu_app__corporates') }}
qualify rank() over(partition by id order by _etl_loaded_at desc) = 1