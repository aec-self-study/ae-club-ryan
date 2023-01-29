{{
    config(
        materialized='table'
    )
}}

with pageviews as (
    select * from {{ ref('stg_web_tracking_sessions') }}
)
, session_stats as (
    select visitor_id
        , customer_id
        , session_number
        , count(*) as page_views
        , min(event_date) as session_start_time
        , max(event_date) as session_end_time
        , sum(case when page_name='order-confirmation' then 1 else 0 end) as purchase_made
    from pageviews
    group by 1,2,3
)
select * from session_stats