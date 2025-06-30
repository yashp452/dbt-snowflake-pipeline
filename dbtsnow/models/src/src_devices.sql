

WITH filtered_device AS (
    SELECT *
    FROM DBT_SNOWFLAKE.RAW.DEVICES d
    WHERE d.msisdn IN (SELECT DISTINCT msisdn FROM DBT_SNOWFLAKE.RAW.REV)
),
unique_device AS (
    SELECT *
    FROM filtered_device
    WHERE msisdn IN (
        SELECT msisdn
        FROM filtered_device
        GROUP BY msisdn
        HAVING COUNT(*) = 1
    )
)
SELECT 
    {{ dbt_utils.generate_surrogate_key(['msisdn', 'imei_tac']) }} AS device_id,
    msisdn,
    COALESCE(imei_tac,'N/A') as imei_tac,
    COALESCE(brand_name,'N/A') as brand_name,
    COALESCE(model_name,'N/A') as model_name,
    COALESCE(os_name, 'N/A') AS os_name,
    COALESCE(os_vendor, 'N/A') AS os_vendor
FROM unique_device
