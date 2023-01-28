{{
    config(
        materialized='table'
    )
}}

with pageviews as (
    select * from {{ source('web_tracking','pageviews') }}
)
, transformed as (
    select
        id as event_id,
        visitor_id,
        customer_id,
        device_type,
        timestamp as event_date,
        page as page_name
    from pageviews
)
select * from transformed