select
    id as id_model_exp,
    slug as cd_slug,
    modelo_raiz as nm_model_root,
    identificador_modelo_a as id_model_a,
    identificador_modelo_b as id_model_b,
    probabilidade_a as pct_prob_a,
    data_inicio::date as start_date,
    data_fim::date as end_date,
    descricao as desc_exp,
    created_at
from {{ source('bronze', 'raw_cashu_app__cadastro_modelos_experimentos') }}
qualify rank() over (partition by id order by _etl_loaded_at desc) = 1
