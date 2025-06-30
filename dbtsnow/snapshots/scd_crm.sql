{% snapshot scd_crm %}

{{
   config(
       target_schema='dev', 
       unique_key='msisdn',
       strategy='check',
       check_cols=['gender', 'year_of_birth', 'system_status', 'mobile_type', 'value_segment'],
       invalidate_hard_deletes=True
   )
}}

select * from DBT_SNOWFLAKE.DEV.src_crm

{% endsnapshot %}
