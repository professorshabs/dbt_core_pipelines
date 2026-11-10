with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('fct_orders') }}
),

customer_orders as (
    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,
        sum(
            case
                when order_status != 'returned' then total_amount_dollars
                else 0
            end
        ) as lifetime_value_dollars
    from orders
    group by customer_id
),

final as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customers.full_name,
        customers.email,
        customers.signup_date,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        coalesce(customer_orders.lifetime_value_dollars, 0) as lifetime_value_dollars,
        case
            when coalesce(customer_orders.lifetime_value_dollars, 0) >= 50 then 'VIP'
            when coalesce(customer_orders.number_of_orders, 0) >= 1 then 'Active'
            else 'Prospect'
        end as customer_tier
    from customers
    left join customer_orders
        on customers.customer_id = customer_orders.customer_id
)

select * from final

