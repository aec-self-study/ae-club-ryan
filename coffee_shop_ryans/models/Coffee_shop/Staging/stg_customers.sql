{{
    config(
        materialized='table'
    )
}}

with customers as (
    select * from {{ source('coffee_shop','customers') }}
)
, transformed as (
    select
        id as customer_id,
        name as customer_name,
        email
    from customers
)

select * from transformed