with tp_chgbk_kind as (
    select
    $1 tp_chgbk_kind,
    $2 nm_chgbk
    from (values('0','valor alterado'),
    (1,'vencimento alterado'),
    (2,'cancelado'),
    (3,'desacordo comercial'),
    (4,'regresso'),
    (5,'nao paga terceiros'))s
)
select
t1.*,
t2.nm_chgbk
from {{ ref('stg_cashu_app__order_installment_charge_backs') }} t1
left join tp_chgbk_kind t2 on t1.tp_chgbk_kind = t2.tp_chgbk_kind