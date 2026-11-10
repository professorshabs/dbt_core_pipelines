with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

order_payments as (
    select
        order_id,
        sum(case when payment_method = 'credit_card' then amount_dollars else 0 end) as credit_card_amount,
        sum(case when payment_method = 'gift_card' then amount_dollars else 0 end) as gift_card_amount,
        sum(case when payment_method = 'bank_transfer' then amount_dollars else 0 end) as bank_transfer_amount,
        sum(amount_dollars) as total_amount_dollars
    from payments
    group by order_id
),

final as (
    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.order_status,
        coalesce(order_payments.credit_card_amount, 0) as credit_card_amount,
        coalesce(order_payments.gift_card_amount, 0) as gift_card_amount,
        coalesce(order_payments.bank_transfer_amount, 0) as bank_transfer_amount,
        coalesce(order_payments.total_amount_dollars, 0) as total_amount_dollars
    from orders
    left join order_payments
        on orders.order_id = order_payments.order_id
)

select * from final

