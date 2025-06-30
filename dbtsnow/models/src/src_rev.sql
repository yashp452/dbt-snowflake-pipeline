WITH date_spine AS (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2024-01-01' as date)",
        end_date="cast('2024-12-31' as date)"
    ) }}
),
date_with_week AS (
    SELECT
        EXTRACT(week FROM date_day) AS week_number,
        date_day
    FROM date_spine
),
first_date_per_week AS (
    SELECT
        week_number,
        MIN(date_day) AS week_start_date
    FROM date_with_week
    GROUP BY week_number
),
rev AS (
    SELECT
        msisdn,
        week_number,
        revenue_usd
    FROM DBT_SNOWFLAKE.RAW.REV
)

SELECT
    r.msisdn,
    r.revenue_usd,
    r.week_number,
    f.week_start_date AS full_date
FROM rev r
LEFT JOIN first_date_per_week f
    ON r.week_number = f.week_number
ORDER BY r.msisdn, r.week_number
