with date_dim as(
    select {{ dbt_utils.generate_surrogate_key(['msisdn', 'week_number']) }} as date_id,
    msisdn,
    revenue_usd,
    week_number,
    full_date
    FROM
    {{ref('src_rev')}}
)

select * from date_dim