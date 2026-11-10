{% snapshot scd_raw_orders %}

{{
    config(
      target_schema='snapshots',
      unique_key='order_id',
      strategy='timestamp',
      updated_at='updated_at',
    )
}}

select * from {{ source('raw_shop', 'raw_orders') }}

{% endsnapshot %}

