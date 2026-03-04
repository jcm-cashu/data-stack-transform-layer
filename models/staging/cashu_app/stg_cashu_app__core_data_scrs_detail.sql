with source as (
    select *
    from {{ source('bronze', 'raw_cashu_app__core_data_scrs') }}
),

unioned as (

    select
        cds.created_at,
        (cds.money_plus_response:ResumoDoCliente.DataBaseConsultada::varchar || '-01')::date as ref_date,
        {{ standardize_bz_gov_id('cds.document_stripped') }} as nr_doc_stripped,
        lst_resumo.value:Modalidade::varchar as tp_oper_mod,
        vencimento.value:ValorVencimento::float as amt_due,
        vencimento.value:CodigoVencimento::varchar as cd_due,
        vencimento.value:ValorVencimentoSpecified::boolean as is_amt_due_specified,
        cds._etl_loaded_at
    from source cds,
        lateral flatten(input => cds.money_plus_response:ResumoDoCliente.ListaDeResumoDasOperacoes) lst_resumo,
        lateral flatten(input => lst_resumo.value:ListaDeVencimentos) vencimento
    where length(cds.document_stripped) = 14
      and coalesce(cds.money_plus_response:Erro::boolean, false) = false

    union all

    select
        cds.created_at,
        (cds.money_plus_partner_response:ResumoDoCliente.DataBaseConsultada::varchar || '-01')::date as ref_date,
        {{ standardize_bz_gov_id('cds.document_stripped') }} as nr_doc_stripped,
        lst_resumo.value:Modalidade::varchar as tp_oper_mod,
        vencimento.value:ValorVencimento::float as amt_due,
        vencimento.value:CodigoVencimento::varchar as cd_due,
        vencimento.value:ValorVencimentoSpecified::boolean as is_amt_due_specified,
        cds._etl_loaded_at
    from source cds,
        lateral flatten(input => cds.money_plus_partner_response:ResumoDoCliente.ListaDeResumoDasOperacoes) lst_resumo,
        lateral flatten(input => lst_resumo.value:ListaDeVencimentos) vencimento
    where length(cds.document_stripped) = 11
      and coalesce(cds.money_plus_partner_response:Erro::boolean, false) = false
)

select
    created_at,
    ref_date,
    nr_doc_stripped,
    tp_oper_mod,
    amt_due,
    cd_due,
    is_amt_due_specified
from unioned
qualify rank() over (
    partition by nr_doc_stripped, ref_date, tp_oper_mod, cd_due
    order by _etl_loaded_at desc
) = 1

