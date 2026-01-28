with aquisicoes_recent as (
    select *
    from {{ ref('stg_kanastra__aquisicoes') }}
    qualify rank() over (
        partition by ref_date, nr_gov_id_fund  
        order by created_at desc
    ) = 1
)

select * from aquisicoes_recent