select
    -- Identifiers
    id as id_cnab_oper,
    corporate_id as id_corp,
    cnab_id as id_cnab,

    -- Metadata
    "source" as cd_source,
    status as st_cnab_oper,

    -- File
    arquivo_nome as nm_file,

    -- Header (CNAB)
    header_id_registro as hdr_id_reg,
    header_id_arquivo as hdr_id_file,
    header_literal_remessa as hdr_desc_remessa_lit,
    header_codigo_servico as hdr_cd_serv,
    header_literal_servico as hdr_desc_serv_lit,
    header_codigo_originador as hdr_cd_originator,
    header_nome_originador as hdr_nm_originator,
    header_numero_banco as hdr_nr_bnk,
    header_nome_banco as hdr_nm_bnk,
    header_data_gravacao as hdr_recorded_date,
    header_branco_1 as hdr_blank_1,
    header_id_sistema as hdr_id_system,
    header_numero_sequencial_arquivo as hdr_nr_seq_file,
    header_numero_banco_cedente as hdr_nr_bnk_cedent,
    header_agencia_cedente as hdr_nr_agcy_cedent,
    header_digito_agencia as hdr_cd_agcy_digit,
    header_conta_corrente_cedente as hdr_nr_acct_cedent,
    header_digito_conta_corrente as hdr_cd_acct_digit,
    header_branco_2 as hdr_blank_2,
    header_numero_sequencial_registro as hdr_nr_seq_reg,

    -- Registro
    id_registro as cd_reg,
    numero_sequencial_registro as nr_seq_reg,

    -- Dates
    data_carencia as grace_date,
    data_liquidacao as sttl_date,
    data_vencimento as due_date,
    data_emissao as issue_date,
    data_pagamento as pymt_at,

    -- Types / Codes
    tipo_juros as tp_int,
    caracteristica_especial as tp_special_char,
    modalidade_operacao as tp_oper_mod,
    natureza_operacao as tp_oper_nature,
    origem_recurso as tp_funding_orig,
    classe_risco as cd_risk_class,
    condicao_papeleta as tp_papeleta_cond,
    ident_emite_papeleta as tp_papeleta_emit,
    identificacao_operacao_banco as cd_bnk_oper,
    indicador_rateio as ind_split,
    enderecamento_aviso as desc_notice_addr,
    identificacao_ocorrencia as cd_occurrence,
    banco_encarregado as cd_bnk_handler,
    agencia_depositaria as nr_agcy_deposit,
    especie_titulo as tp_ttl_kind,
    identificacao as cd_ident,
    primeira_instrucao as desc_instr_1,
    segunda_instrucao as desc_instr_2,
    tipo_pessoa_cedente as tp_person_cedent,
    tipo_inscricao_sacado as tp_person_debtor,
    forma_pagamento as tp_pymt_method,

    -- Strings / Filler
    branco_1 as blank_1,
    branco_2 as blank_2,
    zeros_1 as zeros_1,
    zeros_2 as zeros_2,
    juros_mora as desc_int_mora,
    taxa_juros as desc_rate_int,
    coobrigacao as desc_coobl,

    -- Identifiers / Document numbers
    numero_controle_participante as nr_participant_ctrl,
    numero_banco as nr_bnk,
    identificacao_titulo_banco as cd_ttl_bnk_id,
    digito_nosso_numero as cd_our_nr_digit,
    numero_documento as nr_ttl_doc,
    numero_termo_cessao as nr_cess_term,
    numero_nf_duplicata as nr_nf_dup,
    serie_nf_duplicata as cd_nf_dup_series,
    chave_nota as cd_nf_key,

    -- Parties
    {{ standardize_bz_gov_id('inscricao_sacado') }} as nr_gov_id_debtor,
    nome_sacado as nm_debtor,
    endereco_sacado as desc_addr_debtor,
    cep_sacado as nr_zip_debtor,

    cedente as nm_cedent,
    {{ standardize_bz_gov_id('cedente_cnpj') }} as nr_gov_id_cedent,

    -- Amounts
    valor_pago as amt_paid,
    valor_titulo as amt_ttl,
    valor_presente_parcela as amt_inst_present,
    valor_abatimento as amt_reduction,
    valor_juros_multa as amt_int_pnlt,
    taxa_consultoria as rate_consult_fee,

    -- Timestamps
    created_at,
    updated_at

from {{ source('bronze', 'raw_cashu_app__cnab_operations') }}
qualify rank() over(partition by id order by _etl_loaded_at desc) = 1

