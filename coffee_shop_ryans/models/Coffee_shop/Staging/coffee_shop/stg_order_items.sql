{{
    config(
        materialized='table'
    )
}}

with order_items as (
    select * from {{ source('coffee_shop','order_items') }}
)
, transformed as (
    select
        id as order_item_id,
        order_id,
        product_id
    from order_items
)

select * from transformed