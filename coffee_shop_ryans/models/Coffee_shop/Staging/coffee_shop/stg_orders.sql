{{
    config(
        materialized='table'
    )
}}

with orders as (
    select * from {{ source('coffee_shop','orders') }}
)
, transformed as (
    select
        id as order_id,
        customer_id,
        address,
        state,
        zip as zip_code,
        created_at as ordered_at,
        total
    from orders
)

select * from transformed