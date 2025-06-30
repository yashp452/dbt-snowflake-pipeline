SELECT
  customer_id,
  year_of_birth
FROM {{ ref('dim_crm') }}
WHERE year_of_birth > EXTRACT(YEAR FROM CURRENT_DATE)
limit 10

