{{
    config(
        materialized='table'
    )
}}

with orders as (
    select * from {{ ref('stg_orders') }}
)
, order_items as (
    select * from {{ ref('stg_order_items') }}
)
, products as (
    select * from {{ ref('stg_products') }}
)
, product_prices as (
    select * from {{ ref('stg_product_prices') }}
)
, first_order as (
    select * from {{ ref('int_new_customer') }}
)
select date_trunc(date(ordered_at), week) as week
    , cast(floor(date_diff(ordered_at, first_order_at, day)/7) + 1 as int64) as customer_week_number
    , orders.customer_id
    , category
    , if(first_order_at = ordered_at, 'new', 'returning') as customer_type
    , price
from orders
join first_order on orders.customer_id = first_order.customer_id
join order_items on orders.order_id = order_items.order_id
join products on products.product_id = order_items.product_id
join product_prices on product_prices.product_id = products.product_id