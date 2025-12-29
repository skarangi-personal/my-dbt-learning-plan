{{ config(materialized='view') }}

-- Raw yellow taxi trip data
-- This view exposes the staging model as the raw data layer
-- Used by downstream transformations

SELECT *
FROM {{ ref('stg_yellow_taxi_parquet') }}
