with recent_invoice_financing_items as (
    select 
     *,
    from {{ ref('stg_cashu_app__invoice_financing_items') }}
    qualify row_number() over (partition by nr_cnab_ctrl, nr_cnab_doc order by created_at desc) = 1

), invoice_receivable as (
    select 
        fi.id_inv_fin_item,
        fi.nr_cnab_ctrl,
        fi.nr_cnab_doc,
        oi.id_billet,
        oi.id_ord_inst,
        oi.st_inst
    from recent_invoice_financing_items fi
    inner join {{ ref('stg_cashu_app__order_installments') }} oi 
        on fi.id_ord_inst = oi.id_ord_inst
    where fi.nr_cnab_ctrl is not null 
        and fi.nr_cnab_doc is not null 
        and fi.tp_rate is not null
)
select * from invoice_receivable