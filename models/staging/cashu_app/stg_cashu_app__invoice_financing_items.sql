with source as (
    select
        -- Identifiers
        id as id_inv_fin_item,                          -- BIGINT: primary key
        invoice_receivable_id as id_recv,               -- BIGINT: FK to receivable
        invoice_financing_id as id_inv_fin,             -- INTEGER: FK to financing
        order_installment_id as id_ord_inst,            -- BIGINT: FK to order installment
        resale_bank_id as id_bnk_resale,                -- INTEGER: FK to resale bank
        cnab_numero_controle as nr_cnab_ctrl,           -- VARCHAR
        cnab_numero_documento as nr_cnab_doc,           -- VARCHAR

        -- Dates
        due_date::date as due_date,                     -- TIMESTAMP -> DATE
        issue_date::date as issue_date,                 -- TIMESTAMP -> DATE
        resale_settlement_date::date as sttl_date_resale, -- TIMESTAMP -> DATE

        -- Timestamps
        created_at,                                     -- TIMESTAMP
        updated_at,                                     -- TIMESTAMP
        anticipated_at,                                 -- TIMESTAMP

        -- Amounts
        amount as amt_total,                            -- DECIMAL(16,2): total amount
        invoice_value_without_fees as amt_net,          -- DECIMAL(10,2): value without fees
        amount_after_fees_before_mdr as amt_post_fees_pre_mdr, -- DECIMAL(10,4)
        invoice_financing_transfer_cost as amt_cost_transf, -- DECIMAL(10,3)

        -- Fees
        payment_processing_fee as amt_fee_proc,         -- DECIMAL(10,3)
        invoice_financing_fee as amt_fee_fin,           -- DECIMAL(10,4)
        consultancy_fee as amt_fee_consult,             -- DECIMAL(10,4)
        mdr_fee as amt_fee_mdr,                         -- DECIMAL(10,6)

        -- Rates / Percentages
        bank_cut_percentage as pct_cut_bnk,             -- DECIMAL(5,2)
        resale_bank_cut_percentage as pct_cut_bnk_resale, -- DECIMAL(5,2)

        -- Quantities
        credit_period_in_days as qty_credit_days,       -- INTEGER

        -- Type
        rate_type as tp_rate,                           -- VARCHAR

        -- Booleans
        anticipated as is_antcp,                        -- BOOLEAN
        resale as is_resale                             -- BOOLEAN


    from {{ source('bronze', 'raw_cashu_app__invoice_financing_items') }}
    qualify rank() over(partition by id order by _etl_loaded_at desc) = 1
)

select *
from source
