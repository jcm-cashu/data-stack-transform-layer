select 
   regexp_replace(cnpj,'[\\.\\/\\-]','') as nr_gov_id_issuer,
   razao_social as nm_legal_issuer,
   tipo_loja as tp_store,
   iff(apto_a_operar = 'TRUE',TRUE,FALSE) as is_operable,
   to_date(data_apto_a_operar,'DD/MM/YYYY') as operable_at,
   iff(tier = '#N/A','Sem Tier',tier) as cd_tier,

from {{ source('bronze', 'raw_cashu_ops__cacau_show_stores') }} ir
