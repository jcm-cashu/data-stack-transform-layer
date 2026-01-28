select
    mes::int as mth,
    ano::int as yr,
    banker as nm_banker,
    corporate_slug as cd_slug_corp,
    {{bz_format_float('meta')}} as amt_target
from {{ source('bronze', 'raw_cashu_sales__metas') }}
