{{
    config(
        materialized='table'
    )
}}

{%- set product_categories = find_product_category() -%}

select date_trunc(ordered_at, month) as date_month,
    {%- for product_category in product_categories %}
    sum(case when category = '{{product_category}}' then price end) as {{ product_category | replace(" ", "_") }}_amount
    {%- if not loop.last %},{% endif -%}
    {% endfor %}
from {{ref ('fact_order_items') }}
group by 1
