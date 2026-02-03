select
    id as id_mov_model_exp,
    id_experimento as id_model_exp,
    identificador_modelo as id_model,
    {{ standardize_bz_gov_id('documento') }} as nr_doc,
    data_base_consultada_scr::date as ref_scr_date,
    aprovado_flag as is_approved,
    limite_liberado as amt_limit_released,
    prazo as qty_term,
    output_modelo as score_model_output,
    score as score_model,
    created_at
from {{ source('bronze', 'raw_cashu_app__movimentacao_modelos_experimentos') }}
qualify rank() over (partition by id order by _etl_loaded_at desc) = 1
