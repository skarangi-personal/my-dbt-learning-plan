-- Singular test: Ensure trip duration is always greater than zero
-- Trip duration is calculated as: tpep_dropoff_datetime - tpep_pickup_datetime

select
    count(*) as invalid_trip_duration_count
from {{ ref('yellow_taxi_raw') }}
where
    (tpep_dropoff_datetime - tpep_pickup_datetime) <= interval '0 seconds'
having
    count(*) > 0
