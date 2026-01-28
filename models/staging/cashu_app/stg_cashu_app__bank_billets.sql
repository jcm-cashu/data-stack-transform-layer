select
    -- Identifiers
    id as id_billet,
    invoice_receivable_id as id_inv_recv,
    business_id as id_business,
    corporate_id as id_corp,
    bank_id as id_bnk,
    bank_user_id as id_bnk_user,
    link_id as id_link,
    id_integracao as id_integ,

    -- Document Numbers
    {{standardize_bz_gov_id('document')}} as nr_doc,
    nosso_numero as nr_boleto,
    numero_documento as nr_doc_billet,
    nfe_document_number as nr_nfe_doc,
    barcode as cd_barcode,
    pdf_protocol as cd_pdf_protocol,

    -- Dates
    issue_date,
    due_date,
    payment_date as pymt_date,
    interest_start_date as int_start_date,
    late_fee_start_date as pnlt_start_date,

    -- Timestamps
    payment_registered_date as pymt_reg_at,
    pdf_file_attached_at as pdf_attached_at,
    registered_at,
    created_at,
    updated_at,

    -- Amounts
    value as amt_face,
    amount_paid as amt_paid,
    amount_interest as amt_int,
    amount_late_fee as amt_pnlt,

    -- Rates
    interest_rate as rate_int,
    late_fee_rate as rate_pnlt,

    -- Status
    status as st_billet,
    integration_status as st_integ,

    -- Types
    manual_liquidation_kind as tp_manual_liquidation,
    integration_type as tp_integ,

    -- Booleans
    downloaded as is_downloaded,
    automatically as is_auto,
    exception_flow as is_exception_flow,
    block_to_update as is_blocked_update,

    -- Descriptions
    observation_note as desc_obs

from {{ source('bronze', 'raw_cashu_app__bank_billets') }}
qualify rank() over(partition by id order by _etl_loaded_at desc) = 1