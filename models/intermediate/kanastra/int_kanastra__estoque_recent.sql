with estoque_recent as (
    select *
    from {{ ref('stg_kanastra__estoque') }}
    qualify rank() over (
        partition by ref_date, cd_slug, id_uid  
        order by created_at desc
    ) = 1
)

select * from estoque_recent