with source as (
    select *
    from {{ source('bronze', 'raw_cashu_app__core_data_scrs') }}
),

unioned as (

    select
        {{ standardize_bz_gov_id('document_stripped') }} as nr_doc_stripped,

        (money_plus_response:ResumoDoCliente.DataBaseConsultada::varchar || '-01')::date as ref_date,

        coalesce(
            money_plus_response:ResumoDoCliente.DataInicioRelacionamento::date,
            money_plus_response:ResumoDoClienteTraduzido.DtInicioRelacionamento::date
        ) as rel_start_date,

        money_plus_response:ResumoDoClienteTraduzido.Prejuizo::float as amt_loss,
        money_plus_response:ResumoDoClienteTraduzido.Repasses::float as amt_transf,
        money_plus_response:ResumoDoClienteTraduzido.RiscoTotal::float as amt_risk_tot,
        money_plus_response:ResumoDoClienteTraduzido.Coobrigacoes::float as amt_coobl,

        money_plus_response:ResumoDoClienteTraduzido.QtdeOperacoes::int as qty_oper,
        money_plus_response:ResumoDoClienteTraduzido.QtdeInstituicoes::int as qty_inst,

        money_plus_response:ResumoDoClienteTraduzido.CarteiraVencer::float as amt_portf_due,
        money_plus_response:ResumoDoClienteTraduzido.CarteiraVencido::float as amt_portf_overdue,
        money_plus_response:ResumoDoClienteTraduzido.CarteiradeCredito::float as amt_credit_portf,

        money_plus_response:ResumoDoClienteTraduzido.CreditosaLiberar::float as amt_credit_release,
        money_plus_response:ResumoDoClienteTraduzido.LimitesdeCredito::float as amt_credit_limit,
        money_plus_response:ResumoDoClienteTraduzido.LimitesdeCreditoAte360dias::float as amt_credit_limit_360d,
        money_plus_response:ResumoDoClienteTraduzido.LimitesdeCreditoAcima360dias::float as amt_credit_limit_gt_360d,

        money_plus_response:ResumoDoClienteTraduzido.PrejuizoAte12meses::float as amt_loss_12m,
        money_plus_response:ResumoDoClienteTraduzido.PrejuizoAcima12meses::float as amt_loss_gt_12m,
        money_plus_response:ResumoDoClienteTraduzido.RiscoIndiretoVendor::float as amt_risk_indirect_vendor,

        money_plus_response:ResumoDoClienteTraduzido.ResponsabilidadeTotal::float as amt_liab_tot,

        money_plus_response:ResumoDoClienteTraduzido.VlrOperacoesSobJudice::float as amt_oper_under_judice,
        money_plus_response:ResumoDoClienteTraduzido.QtdeOperacoesSobJudice::int as qty_oper_under_judice,

        money_plus_response:ResumoDoClienteTraduzido.VlrOperacoesDiscordancia::float as amt_oper_discrep,
        money_plus_response:ResumoDoClienteTraduzido.QtdeOperacoesDiscordancia::int as qty_oper_discrep,

        money_plus_response:ResumoDoClienteTraduzido.PercDocumentosProcessados::float as pct_doc_proc,

        money_plus_response:ResumoDoClienteTraduzido.CarteiraVencer31a60dias::float as amt_portf_due_31_60d,
        money_plus_response:ResumoDoClienteTraduzido.CarteiraVencer61a90dias::float as amt_portf_due_61_90d,
        money_plus_response:ResumoDoClienteTraduzido.CarteiraVencer91a180dias::float as amt_portf_due_91_180d,
        money_plus_response:ResumoDoClienteTraduzido.CarteiraVencer181a360dias::float as amt_portf_due_181_360d,
        money_plus_response:ResumoDoClienteTraduzido.CarteiraVencerAcima360dias::float as amt_portf_due_gt_360d,
        money_plus_response:ResumoDoClienteTraduzido.CarteiraVencerPrazoIndeterminado::float as amt_portf_due_term_undef,
        money_plus_response:ResumoDoClienteTraduzido.CarteiraVencerAte30diasVencidosAte14dias::float as amt_portf_due_0_30d_ovd_0_14d,

        money_plus_response:ResumoDoClienteTraduzido.CarteiraVencido15a30dias::float as amt_portf_overdue_15_30d,
        money_plus_response:ResumoDoClienteTraduzido.CarteiraVencido31a60dias::float as amt_portf_overdue_31_60d,
        money_plus_response:ResumoDoClienteTraduzido.CarteiraVencido61a90dias::float as amt_portf_overdue_61_90d,
        money_plus_response:ResumoDoClienteTraduzido.CarteiraVencido91a180dias::float as amt_portf_overdue_91_180d,
        money_plus_response:ResumoDoClienteTraduzido.CarteiraVencido181a360dias::float as amt_portf_overdue_181_360d,
        money_plus_response:ResumoDoClienteTraduzido.CarteiraVencidoAcima360dias::float as amt_portf_overdue_gt_360d,

        created_at,
        _etl_loaded_at

    from source
    where coalesce(money_plus_response:Erro::boolean, false) = false
      and length(document_stripped) = 14

    union all

    select
        {{ standardize_bz_gov_id('document_stripped') }} as nr_doc_stripped,

        (money_plus_partner_response:ResumoDoCliente.DataBaseConsultada::varchar || '-01')::date as ref_date,

        coalesce(
            money_plus_partner_response:ResumoDoCliente.DataInicioRelacionamento::date,
            money_plus_partner_response:ResumoDoClienteTraduzido.DtInicioRelacionamento::date
        ) as rel_start_date,

        money_plus_partner_response:ResumoDoClienteTraduzido.Prejuizo::float as amt_loss,
        money_plus_partner_response:ResumoDoClienteTraduzido.Repasses::float as amt_transf,
        money_plus_partner_response:ResumoDoClienteTraduzido.RiscoTotal::float as amt_risk_tot,
        money_plus_partner_response:ResumoDoClienteTraduzido.Coobrigacoes::float as amt_coobl,

        money_plus_partner_response:ResumoDoClienteTraduzido.QtdeOperacoes::int as qty_oper,
        money_plus_partner_response:ResumoDoClienteTraduzido.QtdeInstituicoes::int as qty_inst,

        money_plus_partner_response:ResumoDoClienteTraduzido.CarteiraVencer::float as amt_portf_due,
        money_plus_partner_response:ResumoDoClienteTraduzido.CarteiraVencido::float as amt_portf_overdue,
        money_plus_partner_response:ResumoDoClienteTraduzido.CarteiradeCredito::float as amt_credit_portf,

        money_plus_partner_response:ResumoDoClienteTraduzido.CreditosaLiberar::float as amt_credit_release,
        money_plus_partner_response:ResumoDoClienteTraduzido.LimitesdeCredito::float as amt_credit_limit,
        money_plus_partner_response:ResumoDoClienteTraduzido.LimitesdeCreditoAte360dias::float as amt_credit_limit_360d,
        money_plus_partner_response:ResumoDoClienteTraduzido.LimitesdeCreditoAcima360dias::float as amt_credit_limit_gt_360d,

        money_plus_partner_response:ResumoDoClienteTraduzido.PrejuizoAte12meses::float as amt_loss_12m,
        money_plus_partner_response:ResumoDoClienteTraduzido.PrejuizoAcima12meses::float as amt_loss_gt_12m,
        money_plus_partner_response:ResumoDoClienteTraduzido.RiscoIndiretoVendor::float as amt_risk_indirect_vendor,

        money_plus_partner_response:ResumoDoClienteTraduzido.ResponsabilidadeTotal::float as amt_liab_tot,

        money_plus_partner_response:ResumoDoClienteTraduzido.VlrOperacoesSobJudice::float as amt_oper_under_judice,
        money_plus_partner_response:ResumoDoClienteTraduzido.QtdeOperacoesSobJudice::int as qty_oper_under_judice,

        money_plus_partner_response:ResumoDoClienteTraduzido.VlrOperacoesDiscordancia::float as amt_oper_discrep,
        money_plus_partner_response:ResumoDoClienteTraduzido.QtdeOperacoesDiscordancia::int as qty_oper_discrep,

        money_plus_partner_response:ResumoDoClienteTraduzido.PercDocumentosProcessados::float as pct_doc_proc,

        money_plus_partner_response:ResumoDoClienteTraduzido.CarteiraVencer31a60dias::float as amt_portf_due_31_60d,
        money_plus_partner_response:ResumoDoClienteTraduzido.CarteiraVencer61a90dias::float as amt_portf_due_61_90d,
        money_plus_partner_response:ResumoDoClienteTraduzido.CarteiraVencer91a180dias::float as amt_portf_due_91_180d,
        money_plus_partner_response:ResumoDoClienteTraduzido.CarteiraVencer181a360dias::float as amt_portf_due_181_360d,
        money_plus_partner_response:ResumoDoClienteTraduzido.CarteiraVencerAcima360dias::float as amt_portf_due_gt_360d,
        money_plus_partner_response:ResumoDoClienteTraduzido.CarteiraVencerPrazoIndeterminado::float as amt_portf_due_term_undef,
        money_plus_partner_response:ResumoDoClienteTraduzido.CarteiraVencerAte30diasVencidosAte14dias::float as amt_portf_due_0_30d_ovd_0_14d,

        money_plus_partner_response:ResumoDoClienteTraduzido.CarteiraVencido15a30dias::float as amt_portf_overdue_15_30d,
        money_plus_partner_response:ResumoDoClienteTraduzido.CarteiraVencido31a60dias::float as amt_portf_overdue_31_60d,
        money_plus_partner_response:ResumoDoClienteTraduzido.CarteiraVencido61a90dias::float as amt_portf_overdue_61_90d,
        money_plus_partner_response:ResumoDoClienteTraduzido.CarteiraVencido91a180dias::float as amt_portf_overdue_91_180d,
        money_plus_partner_response:ResumoDoClienteTraduzido.CarteiraVencido181a360dias::float as amt_portf_overdue_181_360d,
        money_plus_partner_response:ResumoDoClienteTraduzido.CarteiraVencidoAcima360dias::float as amt_portf_overdue_gt_360d,

        created_at,
        _etl_loaded_at

    from source
    where coalesce(money_plus_partner_response:Erro::boolean, false) = false
      and length(document_stripped) = 11
)

select
    nr_doc_stripped,
    ref_date,
    rel_start_date,
    amt_loss,
    amt_transf,
    amt_risk_tot,
    amt_coobl,
    qty_oper,
    amt_portf_due,
    amt_portf_overdue,
    amt_credit_release,
    amt_credit_limit,
    qty_inst,
    amt_credit_portf,
    amt_loss_12m,
    amt_risk_indirect_vendor,
    amt_loss_gt_12m,
    amt_liab_tot,
    amt_oper_under_judice,
    qty_oper_under_judice,
    amt_portf_due_31_60d,
    amt_portf_due_61_90d,
    amt_portf_due_91_180d,
    amt_portf_overdue_15_30d,
    amt_portf_overdue_31_60d,
    amt_portf_overdue_61_90d,
    amt_oper_discrep,
    amt_portf_due_181_360d,
    amt_portf_overdue_91_180d,
    pct_doc_proc,
    qty_oper_discrep,
    amt_portf_due_gt_360d,
    amt_portf_overdue_181_360d,
    amt_credit_limit_360d,
    amt_portf_overdue_gt_360d,
    amt_credit_limit_gt_360d,
    amt_portf_due_term_undef,
    amt_portf_due_0_30d_ovd_0_14d,
    created_at

from unioned
qualify rank() over (
    partition by nr_doc_stripped, ref_date
    order by _etl_loaded_at desc
) = 1

