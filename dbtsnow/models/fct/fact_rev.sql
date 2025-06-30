-- models/fact_revenue.sql
WITH src AS (
    SELECT * FROM {{ ref('src_rev') }}
),
dim_customer AS (
    SELECT customer_id, msisdn FROM {{ ref('dim_crm') }}
),
dim_device AS (
    SELECT device_id, msisdn FROM {{ ref('dim_device') }}
),
dim_date AS (
    SELECT date_id, week_number FROM {{ ref('dim_date') }}
),
customer_device_bridge AS (
    SELECT customer_device_id, customer_id, device_id
    FROM {{ ref('customer_device_bridge') }}
)
SELECT
    ROW_NUMBER() OVER (ORDER BY src.msisdn, src.week_number) AS fact_revenue_id,
    cdb.customer_device_id,
    dd.date_id,
    src.revenue_usd
FROM src
left JOIN dim_customer dc ON src.msisdn = dc.msisdn
left join customer_device_bridge cdb ON cdb.customer_id = dc.customer_id
left join JOIN dim_date dd ON src.week_number = dd.week_number
