with estoque_recent as (
    select *
    from {{ ref('stg_fromtis__estoque') }}
    qualify rank() over (
        partition by ref_date, nr_gov_id_fund
        order by loaded_at desc, id_extraction desc
    ) = 1
)

select * from estoque_recent