with recompras_base as (
    select *
    from {{ ref('int_kanastra__recompras_with_invoice') }}
), recompras_docs as (
    select distinct
        id_external as nr_cnab_doc
    from recompras_base
    where id_external is not null
),recompras as (
    select
        id_fund,
        id_inv_fin_item,
        id_billet,
        id_ord_inst,
        st_inst,
        cd_name_slug,
        cd_nfe_key,
        cast(null as date) as pymt_date_debtor,
        pymt_info_date,
        cast(null as varchar) as nr_cnab_ctrl,
        cast(null as varchar) as nr_cnab_doc,
        id_external,
        cast(null as varchar) as id_acq_bond,
        cast(null as varchar) as id_inst,
        cast(null as varchar) as nr_inst,
        nr_gov_id_fund,
        cd_slug_oper,
        tp_liquidation,
        amt_pymt,
        amt_future,
        created_at,
        cd_repl_key,
        cd_slug
    from recompras_base
),liquidacoes as (
    select
        id_fund,
        id_inv_fin_item,
        id_billet,
        id_ord_inst,
        st_inst,
        cd_name_slug,
        cd_nfe_key,
        pymt_date_debtor,
        pymt_info_date,
        nr_cnab_ctrl,
        nr_cnab_doc,
        id_external,
        id_acq_bond,
        id_inst,
        nr_inst,
        nr_gov_id_fund,
        cd_slug_oper,
        tp_liquidation,
        amt_pymt,
        amt_future,
        created_at,
        cd_repl_key,
        cd_slug
    from {{ ref('int_kanastra__liquidacoes_with_invoice') }}
    where nr_cnab_doc not in (
        select nr_cnab_doc
        from recompras_docs
    )
)
select *
from recompras
union all
select *
from liquidacoes