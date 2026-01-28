with liquidacoes_recent as (
    select *
    from {{ ref('stg_kanastra__liquidacoes') }}
    qualify rank() over (
        partition by pymt_info_date, cd_slug 
        order by created_at desc
    ) = 1
)

select * from liquidacoes_recent