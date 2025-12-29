{{ config(materialized='table') }}

-- Raw yellow taxi trip data loaded from external source
-- Uses source() function to reference taxi_data.yellow_taxi_parquet
-- Source view is created by on-run-start hook

SELECT *
FROM {{ source('taxi_data', 'yellow_taxi_parquet') }}
