SELECT b.customer_id
  , a.name
  , a.email
  , MIN(b.created_at) AS first_order_at
  , COUNT(a.id) AS number_of_orders
  --Adding a comment here.
from `analytics-engineers-club.coffee_shop.customers` a
LEFT JOIN `analytics-engineers-club.coffee_shop.orders` b on a.id = b.customer_id
GROUP BY 1,2,3
ORDER BY first_order_at
LIMIT 5;