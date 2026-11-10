with source as (
    select * from {{ source('raw_shop', 'raw_customers') }}
),

renamed as (
    select
        cast(customer_id as integer) as customer_id,
        first_name,
        last_name,
        first_name || ' ' || last_name as full_name,
        lower(email) as email,
        cast(signup_date as date) as signup_date
    from source
)

select * from renamed

