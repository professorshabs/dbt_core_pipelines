with source as (
    select * from {{ source('raw_shop', 'raw_orders') }}
),

renamed as (
    select
        cast(order_id as integer) as order_id,
        cast(customer_id as integer) as customer_id,
        cast(order_date as date) as order_date,
        status as order_status,
        cast(updated_at as timestamp) as updated_at
    from source
)

select * from renamed

