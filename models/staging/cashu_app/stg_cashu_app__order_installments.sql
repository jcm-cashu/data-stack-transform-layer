with source as (
    select
        -- Identifiers
        id as id_ord_inst,                              -- BIGINT: primary key
        order_id as id_ord,                             -- BIGINT: FK to order
        bank_billet_id as id_billet,                    -- BIGINT: FK to bank billet
        recommendation_id as id_recommendation,         -- BIGINT: FK to recommendation
        external_id as id_external,                     -- VARCHAR
        --external_our_number as nr_cnab_ctrl,           -- BIGINT: nosso número
        --conciliation_identifier as nr_cnab_doc,     -- VARCHAR

        -- Dates
        due_date::date as due_date,                     -- TIMESTAMP -> DATE
        due_date_date as due_date_orig,                 -- DATE: original due_date column
        payment_date::date as pymt_date,                -- TIMESTAMP -> DATE
        last_analysis_date::date as analysis_date_last, -- TIMESTAMP -> DATE
        manual_anticipation_date as antcp_date_manual,  -- DATE
        calculated_anticipation_date as antcp_date_calc, -- DATE

        -- Timestamps
        created_at,                                     -- TIMESTAMP
        updated_at,                                     -- TIMESTAMP

        -- Amounts
        amount as amt_total,                            -- DECIMAL(10,2): installment amount
        amount_paid as amt_paid,                        -- DECIMAL(16,2): amount paid

        -- Type / Status
        payment_method as cd_pymt_method,               -- INTEGER: payment method code
        status as st_inst,                              -- VARCHAR: installment status

        -- Booleans - Invoice Financing
        approved_for_invoice_financing as is_appr_inv_fin,      -- BOOLEAN
        analyzed_for_invoice_financing as is_analyzed_inv_fin,  -- BOOLEAN
        last_approved_for_invoice_financing as is_appr_inv_fin_last, -- BOOLEAN

        -- Description / Notes
        invoice_financing_denial_reason as desc_denial_reason,  -- VARCHAR

        -- Arrays / Complex
        installment_inconsistencies as arr_inconsistencies      -- VARCHAR[]: array of inconsistencies

    from {{ source('bronze', 'raw_cashu_app__order_installments') }}
    qualify rank() over(partition by id order by _etl_loaded_at desc) = 1
)

select *
from source
