{{
    config(
        materialized='table'
    )
}}

with product_prices as (
    select * from {{ source('coffee_shop','product_prices') }}
)
, transformed as (
    select
        id as product_price_id,
        product_id,
        price,
        created_at,
        ended_at
    from product_prices
)

select * from transformed