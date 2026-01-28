select 
    -- Identifiers
    ir.id as id_recv,
    ir.corporate_id as id_corp,
    ir.name_slug as cd_name_slug,

    -- NFe (Nota Fiscal)
    ir.nfe__num_documento as nr_nfe_doc,
    ir.nfe__numero_pedido as nr_nfe_ord,
    ir.nfe__data_pedido as nfe_order_at,

    -- Titulo (Title/Invoice) - Dates
    ir.titulo__data_emissao_documento as ttl_issue_at,
    ir.titulo__data_vencimento_documento_atual as ttl_due_date_curr,
    ir.titulo__data_vencimento_documento_original as ttl_due_date_orig,
    ir.titulo__data_pagamento as ttl_pymt_at,
    ir.titulo__data_ultima_alteracao as ttl_last_updated_at,

    -- Titulo - Identifiers
    ir.titulo__num_documento as nr_ttl_doc,

    -- Titulo - Amounts
    ir.titulo__valor_bruto as amt_ttl_gross,
    ir.titulo__valor_liquido as amt_ttl_net,
    ir.titulo__valor_juros_multa as amt_ttl_int_pnlt,
    ir.titulo__valor_desconto as amt_ttl_disc,

    -- Titulo - Status
    ir.titulo__forma_pagamento as tp_ttl_pymt,
    ir.titulo__status as st_ttl,
    ir.titulo__status_operacao as st_ttl_oper,

    -- Order
    ir.order_status as st_ord,

    -- Cliente (Customer/Debtor) - Identifiers
    regexp_replace(ir.cliente__cpf_cnpj,'[\\.\\/\\-]','') as nr_gov_id_cust,
    ir.cliente__tipo_pessoa_fisica as tp_person_cust,
    ir.cliente__raiz_cnpj as nr_cnpj_root_cust,

    -- Cliente - Names
    ir.cliente__razao_social as nm_legal_cust,
    ir.cliente__nome_fantasia as nm_trading_cust,

    -- Cliente - Credit
    ir.cliente__limite_credito as amt_credit_limit_cust,
    ir.cliente__natureza_juridica as tp_legal_nature_cust,

    -- Cliente - Address
    ir.cliente__endereco as desc_addr_cust,
    ir.cliente__endereco_numero as nr_addr_cust,
    ir.cliente__endereco_complemento as desc_addr_compl_cust,
    ir.cliente__endereco_bairro as nm_district_cust,
    ir.cliente__endereco_cidade as nm_city_cust,
    ir.cliente__endereco_cep as nr_zip_cust,
    ir.cliente__endereco_uf as cd_state_cust,
    ir.cliente__endereco_pais as nm_country_cust,

    -- Cliente - Contact
    ir.cliente__endereco_telefone_01 as nr_phone_cust_01,
    ir.cliente__endereco_telefone_02 as nr_phone_cust_02,
    ir.cliente__endereco_telefone_03 as nr_phone_cust_03,
    ir.cliente__endereco_telefone_04 as nr_phone_cust_04,
    ir.cliente__endereco_telefone_05 as nr_phone_cust_05,
    ir.cliente__endereco_site as desc_website_cust,
    ir.cliente__endereco_email as desc_email_cust,

    -- Emitente (Issuer) - Identifiers
    regexp_replace(ir.emitente__cnpj,'[\\.\\/\\-]','') as nr_gov_id_issuer,
    ir.emitente__nome as nm_issuer,
    ir.emitente__nome_razao_social as nm_legal_issuer,

    -- Emitente - Address
    ir.emitente__endereco as desc_addr_issuer,
    ir.emitente__endereco_numero as nr_addr_issuer,
    ir.emitente__endereco_complemento as desc_addr_compl_issuer,
    ir.emitente__endereco_bairro as nm_district_issuer,
    ir.emitente__endereco_cidade as nm_city_issuer,
    ir.emitente__endereco_cep as nr_zip_issuer,
    ir.emitente__endereco_uf as cd_state_issuer,
    ir.emitente__endereco_pais as nm_country_issuer,

    -- Emitente - Contact
    ir.emitente__endereco_telefone_01 as nr_phone_issuer_01,
    ir.emitente__endereco_telefone_02 as nr_phone_issuer_02,
    ir.emitente__endereco_telefone_03 as nr_phone_issuer_03,
    ir.emitente__endereco_telefone_04 as nr_phone_issuer_04,
    ir.emitente__endereco_telefone_05 as nr_phone_issuer_05,
    ir.emitente__endereco_site as desc_website_issuer,
    ir.emitente__endereco_email as desc_email_issuer,

    -- Economic Group
    ir.economic_group as cd_economic_group,

    -- Invoice Financing Flags
    ir.approved_for_invoice_financing as is_approved_inv_fin,
    ir.analyzed as is_analyzed,
    ir.analyzed_for_invoice_financing as is_analyzed_inv_fin,
    ir.last_analysis_date as last_analysis_at,
    ir.invoice_financing_denial_reason as desc_inv_fin_denial,
    ir.compra_a_prazo as is_credit_purchase,

    -- Metadata
    ir.replication_key as replication_key,
    ir.s3_upload_date as s3_uploaded_at

from {{ source('bronze', 'raw_cashu_app__integration_receivable') }} ir
qualify rank() over(partition by id order by _etl_loaded_at desc) = 1
