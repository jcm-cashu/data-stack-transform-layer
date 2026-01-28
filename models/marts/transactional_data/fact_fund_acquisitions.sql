{{
  config(
    materialized='incremental',
    incremental_strategy='delete+insert',
    unique_key=['ref_date', 'id_fund'],
    schema='fact_data'
  )
}}

select *
from {{ ref('int_kanastra__aquisicoes_with_invoice') }}

{% if is_incremental() %}
where created_at >= (
    select max(created_at) - interval '1 day'
    from {{ this }}
)
{% endif %}
