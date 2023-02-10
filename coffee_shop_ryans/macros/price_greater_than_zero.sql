{% test greater_than_zero(model, column_name) %}
    select
        *
 
    from {{ model }}
    where price <= 0
    
 {% endtest %}