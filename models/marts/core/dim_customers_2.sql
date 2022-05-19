with customers as (
    select *
    from {{ ref('stg_customers_2')}}
),

orders as (
    select * from {{ref('stg_orders_2')}}
),

final  as (
    select
        c.customer_id,
        o.order_id,
        o.order_date,
        status
    from customers c
    join orders o on o.user_id = c.customer_id
    where o.order_date > '2018-02-01'
    and
    o.status in ('placed', 'shipped')
)

select * from final