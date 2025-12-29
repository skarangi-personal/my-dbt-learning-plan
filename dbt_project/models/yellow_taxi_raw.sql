{{ config(materialized='table') }}

-- Load yellow taxi trip data from parquet files
-- Source: {{ source('taxi_data', 'yellow_taxi_parquet') }}

{%- set parquet_path -%}
    /Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_project/data/raw/yellow_taxi/yellow_tripdata_*.parquet
{%- endset -%}

SELECT *
FROM read_parquet('{{ parquet_path.strip() }}')
