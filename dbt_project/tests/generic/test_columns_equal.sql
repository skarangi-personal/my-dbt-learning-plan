{% test columns_equal(model, column_name, column2) %}
    -- Generic test to ensure two columns have equal values
    -- column_name: The column being tested (defined in schema.yml)
    -- column2: The column to compare against (passed as argument)
    -- Returns rows where columns are NOT equal (violations)
    -- Test PASSES when both columns are equal across all rows
    -- Useful for validating:
    -- - Totals match sum of parts (total_amount = fare + tip + tolls)
    -- - Calculated fields match stored values
    -- - Source vs target data reconciliation
    -- - Any cross-column equality validation

    select
        *
    from {{ model }}
    where
        -- Check for inequality (violations of the equal condition)
        ({{ column_name }} = {{ column2 }} is false)
        -- Also catch cases where one is null and the other is not
        or ({{ column_name }} is null) != ({{ column2 }} is null)
{% endtest %}
