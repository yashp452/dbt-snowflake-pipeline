
SELECT
    CAST(msisdn AS STRING)         AS msisdn,
    CAST(gender AS STRING)         AS gender,
    CAST(year_of_birth AS INTEGER) AS year_of_birth,
    CAST(system_status AS STRING)  AS system_status,
    CAST(mobile_type AS STRING)    AS mobile_type,
    CAST(value_segment AS STRING)  AS value_segment,
    CAST(composite_key AS STRING) as customer_id
FROM {{ref('src_crm')}}
