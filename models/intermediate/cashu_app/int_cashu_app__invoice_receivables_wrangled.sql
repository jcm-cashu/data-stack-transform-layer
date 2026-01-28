select 
    fi.nr_cnab_ctrl,
    fi.id_inv_fin_item,
    fi.nr_cnab_doc,
    o.cd_slug_corp,
    oi.id_billet,
    oi.id_ord_inst,
    oi.st_inst
from {{ ref('int_cashu_app__invoice_financing_items_dedup') }} fi
inner join {{ ref('stg_cashu_app__order_installments') }} oi 
    on fi.id_ord_inst = oi.id_ord_inst
inner join {{ ref('int_cashu_app__orders_wrangled') }} o on o.id_ord_inst = oi.id_ord_inst