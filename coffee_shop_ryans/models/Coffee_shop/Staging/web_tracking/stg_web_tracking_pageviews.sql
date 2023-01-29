{{
    config(
        materialized='table'
    )
}}

with pageviews as (
    select * from {{ source('web_tracking','pageviews') }}
)
, transformed as (
    select id as event_id
        , visitor_id
        , customer_id
        , page as page_name
        , device_type
        , timestamp as event_date
        , lag(timestamp) over (partition by visitor_id order by timestamp) as last_page_view
    from pageviews
    order by event_date
)
select * from transformed