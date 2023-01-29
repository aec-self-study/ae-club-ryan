{{
    config(
        materialized='table'
    )
}}

with pageviews as (
    select * from {{ ref('stg_web_tracking_pageviews') }}
)
, visitor_vists as (
    select * from {{ ref('stg_visitor_visits') }}
)
, joined as (
    select pageviews.*
        , coalesce(visits.visitor_id,pageviews.visitor_id) as first_visitor_id
    from pageviews pageviews
    left join visitor_vists visits on visits.customer_id = pageviews.customer_id
)
, previous_pageview as (
    select *
        , lag(event_date) over (partition by first_visitor_id order by event_date) as previous_page_view
    from joined
)
, session_difference as (
    select *
        , date_diff(event_date, previous_page_view, minute) time_since_last_visit
    from previous_pageview
)
, new_session as (
    select *
        , cast(coalesce(time_since_last_visit >= 30, true) as integer) as is_new_session
    from session_difference
)
, session_number as (
    select *
        , sum(is_new_session) over (partition by first_visitor_id order by event_date) as session_number
    from new_session
)
select * from session_number