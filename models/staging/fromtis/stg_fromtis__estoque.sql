with source as (
    select
        -- Dates
        coalesce(
            try_to_date(nullif(trim(data_fundo), ''), 'YYYY-MM-DD'),
            try_to_date(nullif(trim(data_fundo), ''), 'DD/MM/YYYY'),
            try_to_date(nullif(trim(data_fundo), ''))
        ) as fund_date,
        coalesce(
            try_to_date(nullif(trim(data_referencia), ''), 'YYYY-MM-DD'),
            try_to_date(nullif(trim(data_referencia), ''), 'DD/MM/YYYY'),
            try_to_date(nullif(trim(data_referencia), ''))
        ) as ref_date,
        coalesce(
            try_to_date(nullif(trim(data_vencimento_original), ''), 'YYYY-MM-DD'),
            try_to_date(nullif(trim(data_vencimento_original), ''), 'DD/MM/YYYY'),
            try_to_date(nullif(trim(data_vencimento_original), ''))
        ) as due_date_orig,
        coalesce(
            try_to_date(nullif(trim(data_vencimento_ajustada), ''), 'YYYY-MM-DD'),
            try_to_date(nullif(trim(data_vencimento_ajustada), ''), 'DD/MM/YYYY'),
            try_to_date(nullif(trim(data_vencimento_ajustada), ''))
        ) as due_date_adj,
        coalesce(
            try_to_date(nullif(trim(data_emissao), ''), 'YYYY-MM-DD'),
            try_to_date(nullif(trim(data_emissao), ''), 'DD/MM/YYYY'),
            try_to_date(nullif(trim(data_emissao), ''))
        ) as issue_date,
        coalesce(
            try_to_date(nullif(trim(data_aquisicao), ''), 'YYYY-MM-DD'),
            try_to_date(nullif(trim(data_aquisicao), ''), 'DD/MM/YYYY'),
            try_to_date(nullif(trim(data_aquisicao), ''))
        ) as acq_date,

        -- Identifiers
        nullif(trim(seu_numero), '')::varchar as nr_cnab_ctrl,
        nullif(trim(nu_documento), '')::varchar as nr_cnab_doc,
        nullif(trim(id_registro), '')::varchar as id_reg,
        nullif(trim(_extraction_id), '')::varchar as id_extraction,

        -- Parties - Fund/Operation
        nullif(trim(nome_fundo), '')::varchar as nm_fund,
        {{ standardize_bz_gov_id("nullif(trim(doc_fundo), '')") }} as nr_gov_id_fund,

        -- Parties - Originator
        nullif(trim(nome_originador), '')::varchar as nm_orig,
        {{ standardize_bz_gov_id("nullif(trim(doc_originador), '')") }} as nr_gov_id_orig,

        -- Parties - Cedent
        nullif(trim(nome_cedente), '')::varchar as nm_cedent,
        {{ standardize_bz_gov_id("nullif(trim(doc_cedente), '')") }} as nr_gov_id_cedent,

        -- Parties - Debtor
        nullif(trim(nome_sacado), '')::varchar as nm_debtor,
        {{ standardize_bz_gov_id("nullif(trim(doc_sacado), '')") }} as nr_gov_id_debtor,

        -- Type and Status
        nullif(trim(tipo_recebivel), '')::varchar as tp_recv,
        nullif(trim(situacao_recebivel), '')::varchar as cd_sit_recv,

        -- Amounts
        {{ bz_format_float("nullif(trim(valor_nominal), '')") }} as amt_face,
        {{ bz_format_float("nullif(trim(valor_presente), '')") }} as amt_present,
        {{ bz_format_float("nullif(trim(valor_aquisicao), '')") }} as amt_acq,
        {{ bz_format_float("nullif(trim(valor_pdd), '')") }} as amt_prov,
        {{ bz_format_float("nullif(trim(valor_nominal_iof), '')") }} as amt_face_iof,
        {{ bz_format_float("nullif(trim(valor_pdd_geral), '')") }} as amt_prov_gen,

        -- Rates
        {{ bz_format_float("nullif(trim(taxa_cessao), '')") }} as rate_cess,
        {{ bz_format_float("nullif(trim(tx_recebivel), '')") }} as rate_recv,

        -- Quantities
        nullif(regexp_replace(prazo, '[^0-9-]', ''), '')::int as qty_tenor_days,
        nullif(regexp_replace(prazo_atual, '[^0-9-]', ''), '')::int as qty_tenor_days_curr,

        -- Codes and Categories
        nullif(trim(faixa_pdd), '')::varchar as cd_prov_range,
        nullif(trim(codigo_origem), '')::varchar as cd_orig,
        nullif(trim(codigo_finalidade), '')::varchar as cd_purpose,
        nullif(trim(faixa_pdd_geral), '')::varchar as cd_prov_range_gen,
        nullif(trim(tipo_pdd_geral), '')::varchar as tp_prov_gen,
        nullif(trim(cmc7_cheque), '')::varchar as cd_cmc7_chq,

        -- Bank References
        nullif(trim(nu_banco_cheque), '')::varchar as nr_bnk_chq,
        nullif(trim(nu_agencia_cheque), '')::varchar as nr_agcy_chq,
        nullif(trim(nu_conta_cheque), '')::varchar as nr_acct_chq,

        -- Booleans
        case
            when regexp_like(coobrigacao, '^(true|t|1|sim|s|yes|y)$', 'i') then true
            when regexp_like(coobrigacao, '^(false|f|0|nao|n|no)$', 'i') then false
        end as has_coobl,

        -- Metadata
        coalesce(
            try_to_timestamp_ntz(nullif(trim(_etl_loaded_at), ''), 'YYYY-MM-DD HH24:MI:SS'),
            try_to_timestamp_ntz(nullif(trim(_etl_loaded_at), ''), 'YYYY-MM-DD"T"HH24:MI:SS'),
            try_to_timestamp_ntz(nullif(trim(_etl_loaded_at), ''), 'DD/MM/YYYY HH24:MI:SS'),
            try_to_timestamp_ntz(nullif(trim(_etl_loaded_at), ''))
        ) as loaded_at

    from {{ source('bronze', 'raw_fromtis__estoque') }}
)

select *
from source
