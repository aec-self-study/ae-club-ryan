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
select * from joined