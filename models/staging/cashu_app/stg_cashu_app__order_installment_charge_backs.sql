select
    -- Identifiers
    id as id_ord_inst_chgbk,
    order_installment_id as id_ord_inst,
    bank_billet_id as id_billet,
    invoice_financing_id as id_inv_fin,

    -- Amounts
    previous_amount as amt_prev,
    interest_amount as amt_int,
    penalty_amount as amt_pnlt,
    payment_processing_fee as amt_fee_proc,
    total_amount as amt_total,

    -- Dates / Timestamps
    previous_due_date::date as due_date_prev,
    send_to_bpo_at as bpo_sent_at,
    due_date_extension_amount as due_ext_at,
    created_at,
    updated_at,

    -- Rates
    rate as rate_chgbk,

    -- Type / Status
    kind as tp_chgbk_kind,
    status as st_chgbk,

    -- Descriptions
    description as desc_chgbk

from {{ source('bronze', 'raw_cashu_app__order_installment_charge_backs') }}
qualify rank() over(partition by id order by _etl_loaded_at desc) = 1

