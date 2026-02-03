select
    c3.id_customer as id_fund,
    i.id_inv_fin_item,
    i.id_billet,
    i.id_ord_inst,
    i.st_inst,
    i.cd_name_slug,
    i.cd_nfe_key,
    tb.*
from {{ref('int_kanastra__liquidacoes_recent')}} tb 
left join {{ref('int_cashu_app__invoice_financing_items_wrangled')}} i
on tb.nr_cnab_ctrl = i.nr_cnab_ctrl
and tb.nr_cnab_doc = i.nr_cnab_doc
left join {{ref('dim_parties')}} c3 on tb.nr_gov_id_fund = c3.nr_gov_id
