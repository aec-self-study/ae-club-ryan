{{
    config(
        materialized='table'
    )
}}

SELECT b.customer_id
  , a.customer_name
  , a.email
  , MIN(b.ordered_at) AS first_order_at
  , COUNT(a.customer_id) AS number_of_orders
FROM {{ref('stg_customers')}} a
LEFT JOIN {{ref('stg_orders')}} b on a.customer_id = b.customer_id
GROUP BY 1,2,3
ORDER BY first_order_at