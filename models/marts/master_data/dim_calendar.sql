{{ config(schema='master_data', materialized='table',name='dim_calendar') }}

SELECT
    d::date                              AS date,
    YEAR(d)                              AS yr,
    MONTH(d)                             AS mth,
    DAY(d)                               AS day_of_month,
    DAYOFWEEK(d)                         AS day_of_week,  -- 0 = Sunday
    MONTHNAME(d)         AS nm_month,
    DAYNAME(d)           AS nm_weekday
FROM (
    SELECT
        DATEADD(
            day,
            SEQ4(),
            DATE '1900-01-02'
        ) AS d
    FROM TABLE(
        GENERATOR(ROWCOUNT => 120000)  -- constant, safely large
    )
)
WHERE d <= DATE '2200-12-31'