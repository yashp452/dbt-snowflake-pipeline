SELECT  
    device_id,
    CAST(msisdn AS STRING) as    msisdn,
    CAST(brand_name AS STRING) as    brand_name,
    CAST(model_name AS STRING)  AS model_name,
    CAST(os_name AS STRING)    AS os_name,
    CAST(os_vendor AS STRING)    AS os_vendor,
FROM {{ref('src_devices')}}