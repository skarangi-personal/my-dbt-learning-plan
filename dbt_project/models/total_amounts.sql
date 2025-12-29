select
    {% for column_name in ['fare_amount', 'tip_amount', 'tolls_amount', 'total_amount'] %}
        {{ column_name }}{% if not loop.last %},{% endif %}
    {% endfor %}
from {{ ref('yellow_taxi_raw') }}
