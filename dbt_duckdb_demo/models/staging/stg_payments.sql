with source as (
    select * from {{ source('raw_shop', 'raw_payments') }}
),

renamed as (
    select
        cast(payment_id as integer) as payment_id,
        cast(order_id as integer) as order_id,
        payment_method,
        {{ cents_to_dollars('amount_cents') }} as amount_dollars
    from source
)

select * from renamed

