select
    -- Identifiers
    id as id_inv,
    {{ standardize_bz_gov_id('cnpj') }} as nr_gov_id,
    chave_nfe as cd_nfe_key,
    nfe_number as nr_nfe,
    business_id as id_business,
    external_id as id_external,

    -- Names
    name as nm_inv,

    -- Dates
    issued_on as issue_date,
    external_reference_date as external_ref_at,

    -- Amounts
    amount as amt_inv,

    -- Status
    status as st_inv,

    -- Types
    payment_method as tp_pymt,
    natureza_da_operacao as tp_oper_nature,
    modalidade_frete as tp_freight,

    -- Errors
    error_message as desc_error,
    inconsistency_errors as desc_inconsistency_errors,

    -- JSON
    file_content_parsed as data_file_content,

    -- Timestamps
    audit_finished_at,
    created_at,
    updated_at

from {{ source('bronze', 'raw_cashu_app__invoices') }}
qualify rank() over(partition by id order by _etl_loaded_at desc) = 1
