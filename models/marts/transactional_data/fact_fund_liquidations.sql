{{
  config(
    materialized='incremental',
    incremental_strategy='delete+insert',
    unique_key=['ref_date', 'id_fund'],
    schema='fact_data'
  )
}}

select 
coalesce(pymt_date_debtor, pymt_info_date) as ref_date,
*,
from {{ ref('int_kanastra__liquidacoes_recompras_with_invoice') }}

{% if is_incremental() %}
where created_at >= (
    select max(created_at) - interval '1 day'
    from {{ this }}
)
{% endif %}
