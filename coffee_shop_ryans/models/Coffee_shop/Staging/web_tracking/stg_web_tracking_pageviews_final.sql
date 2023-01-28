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
, sessioned as (
    select first_visitor_id as visitor_id
        , event_id
        , customer_id
        , device_type
        , event_date
        , page_name
        , row_number() over (partition by visitor_id order by event_date) as event_number
        , if(row_number() over (partition by visitor_id order by event_date)=1,1,0) as is_first_view
        , timestamp_diff(lead(event_date,1) over (partition by visitor_id order by event_date), event_date, minute) as minutes_between_views
    from joined
)
, new_session as (
    select *
        , case when minutes_between_views >= 30 then 1
            when is_first_view = 1 then 1
            else 0
        end as is_new_session
    from sessioned
)
, session_numbers as (
    select *
        , sum(is_new_session) over (partition by visitor_id order by event_date) as session_number
    from new_session
    order by event_date
)
, session_id as (
    select event_id
        , visitor_id
        , customer_id
        , md5(visitor_id||session_number) as session_id
        , page_name
        , device_type
        , event_date
    from session_numbers
    order by visitor_id, event_date
)
select * from session_id