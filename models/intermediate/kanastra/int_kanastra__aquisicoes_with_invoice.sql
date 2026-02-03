select
    c3.id_customer as id_fund,
    c2.id_customer as id_customer_cedent,
    c1.id_customer as id_customer_debtor,
    i.id_inv_fin_item,
    i.id_billet,
    i.id_ord_inst,
    i.st_inst,
    i.cd_name_slug,
    i.cd_nfe_key,
    tb.*
from {{ref('int_kanastra__aquisicoes_recent')}} tb 
left join {{ref('int_cashu_app__invoice_financing_items_wrangled')}} i
on tb.nr_cnab_ctrl = i.nr_cnab_ctrl
and tb.nr_cnab_doc = i.nr_cnab_doc
left join {{ref('dim_parties')}} c1 on tb.nr_gov_id_debtor = c1.nr_gov_id
left join {{ref('dim_parties')}} c2 on tb.nr_gov_id_cedent = c2.nr_gov_id
left join {{ref('dim_parties')}} c3 on tb.nr_gov_id_fund = c3.nr_gov_id