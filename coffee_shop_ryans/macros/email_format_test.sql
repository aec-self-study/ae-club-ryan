{% test email_format(model, column_name) %}
    select
        *
 
    from {{ model }}
    where not REGEXP_CONTAINS(email, r'@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+')
    
 {% endtest %}