{%- set columns = [
    'fare_amount',
    'tip_amount',
    'tolls_amount',
    'total_amount'
] -%}

SELECT
    {%- for column_name in columns %}
        {{ column_name }}{% if not loop.last %},{% endif %}
    {%- endfor %}
FROM {{ ref('yellow_taxi_raw') }}
