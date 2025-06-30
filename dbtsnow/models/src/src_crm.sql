{{ config(materialized='table') }}

WITH crmtable AS (
    SELECT
        *,
        {{ dbt_utils.generate_surrogate_key(['msisdn', 'gender', 'year_of_birth']) }} AS composite_key
    FROM DBT_SNOWFLAKE.RAW.CRM
),

active_keys AS (
    SELECT
        composite_key
    FROM crmtable
    GROUP BY composite_key
    HAVING MIN(system_status) = 'ACTIVE' AND MAX(system_status) = 'ACTIVE'
),

active_crm AS (
    SELECT *
    FROM crmtable
    WHERE composite_key IN (SELECT composite_key FROM active_keys)
),

final AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY composite_key ORDER BY id DESC) AS rn
    FROM active_crm
),

last_per_msisdn AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY msisdn ORDER BY id DESC) AS rn_msisdn
    FROM final
    WHERE rn = 1
)

SELECT
    msisdn,
    gender,
    year_of_birth,
    system_status,
    mobile_type,
    value_segment,
    id,
    composite_key
FROM last_per_msisdn
WHERE rn_msisdn = 1
