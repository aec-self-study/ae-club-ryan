{{
    config(
        materialized='table'
    )
}}

with products as (
    select * from {{ source('coffee_shop','products') }}
)
, transformed as (
    select
        id as product_id,
        name as product_name,
        category,
        created_at,
    from products
)

select * from transformed