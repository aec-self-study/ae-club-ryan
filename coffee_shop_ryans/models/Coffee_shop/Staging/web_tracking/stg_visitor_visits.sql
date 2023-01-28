{{
    config(
        materialized='table'
    )
}}

with pageviews as (
    select * from {{ ref('stg_web_tracking_pageviews') }}
)
, distinct_visitor_visits as (
    select distinct visitor_id
        , customer_id as distinct_customer_id
        , min(event_date) over (partition by visitor_id) as first_event_date
        , max(event_date) over (partition by visitor_id) as last_event_date
        , row_number() over (partition by visitor_id order by event_date) as occurence
    from pageviews
    where customer_id is not null
    group by visitor_id,customer_id,event_date
    qualify occurence = 1
    order by visitor_id, occurence
)
select distinct_customer_id as customer_id
  , visitor_id
  , first_event_date
  , last_event_date
from distinct_visitor_visits
qualify row_number() over (partition by distinct_customer_id order by first_event_date) = 1