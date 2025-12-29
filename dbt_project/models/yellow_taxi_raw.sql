{{ config(materialized='table') }}

{%- set parquet_path -%}
    /Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_project/data/raw/yellow_taxi/yellow_tripdata_*.parquet
{%- endset -%}

-- Raw yellow taxi trip data loaded from parquet files
-- Source: {{ source('taxi_data', 'yellow_taxi_parquet') }}
-- This model loads data from the external source defined in schema.yml

SELECT *
FROM read_parquet('{{ parquet_path.strip() }}')
