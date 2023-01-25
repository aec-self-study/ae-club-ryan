{{
    config(
        materialized='table'
    )
}}

with order_items as (
    select * from {{ ref('stg_order_items') }}
)
, orders as (
    select * from {{ ref('stg_orders') }}
)
, product_prices as (
    select * from {{ ref('stg_product_prices') }}
)
, products as (
    select * from {{ ref('stg_products') }}
)
, new_customers as (
    select * from {{ ref('int_new_customer') }}
)
, joined as (
    select DATE_TRUNC(DATE(orders.ordered_at), WEEK) as order_week
        , products.category
        , IF(orders.ordered_at=customers.first_order_at,'New','Returning') as customer_type
        , SUM(prices.price) as revenue
    from orders orders
    left join order_items items ON orders.order_id = items.order_id
    left join products products ON products.product_id = items.product_id
    left join product_prices prices ON prices.product_id = products.product_id
    left join new_customers customers ON customers.customer_id = orders.customer_id
    group by 1,2,3
    order by 1
)
select * from joined
