{{
  config(
    materialized='incremental',
    incremental_strategy='delete+insert',
    unique_key=['pymt_date_debtor', 'id_fund'],
    schema='fact_data'
  )
}}

select *
from {{ ref('int_kanastra__liquidacoes_recompras_with_invoice') }}

{% if is_incremental() %}
where created_at >= (
    select max(created_at) - interval '1 day'
    from {{ this }}
)
{% endif %}
