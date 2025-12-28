{% test amount_positive(model, column_name) %}
    -- Generic test to ensure a column contains only positive values (> 0)
    select
        *
    from {{ model }}
    where {{ column_name }} <= 0
{% endtest %}
