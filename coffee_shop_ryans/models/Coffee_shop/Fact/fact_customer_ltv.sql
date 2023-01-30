{{
    config(
        materialized='table'
    )
}}

with int_weekly_revenue as (
    select * from {{ ref('int_weekly_revenue') }}
)
, max_customer_week as (
    select customer_id
        , max(customer_week_number) as max_week
    from int_weekly_revenue
    group by 1
)
, all_weeks_per_customer as (
    select customer_id
        , generated_week_number
    from max_customer_week 
    join unnest(
        generate_array(1,999)
    ) as generated_week_number
        on generated_week_number <= max_week
)
, weekly_revenue_final as (
    select a.customer_id
        , a.generated_week_number as week
        , ifnull(sum(r.price),0) as revenue
    from all_weeks_per_customer a
    left join int_weekly_revenue r on a.customer_id = r.customer_id and a.generated_week_number = r.customer_week_number
    group by 1,2
    order by 1,2
)
select *
    , sum(revenue) over (partition by customer_id order by week rows unbounded preceding) as cumulative_revenue
from weekly_revenue_final