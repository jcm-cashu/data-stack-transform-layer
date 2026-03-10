with recompras_recent as (
    select *,
    id_external as nr_cnab_doc,
    from {{ ref('stg_kanastra__recompras') }}
    qualify rank() over (
        partition by pymt_info_date, cd_slug, id_external
        order by created_at desc
    ) = 1
)

select * from recompras_recent

