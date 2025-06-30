{% snapshot scd_dim_crm %}

{{
   config(
       target_schema='dev',
       unique_key='customer_id',
       strategy='check',
       check_cols=['msisdn', 'gender', 'year_of_birth', 'system_status', 'mobile_type', 'value_segment'],
       invalidate_hard_deletes=True
   )
}}

select
    customer_id,
    msisdn,
    gender,
    year_of_birth,
    system_status,
    mobile_type,
    value_segment
from {{ ref('dim_crm') }}


{% endsnapshot %}
