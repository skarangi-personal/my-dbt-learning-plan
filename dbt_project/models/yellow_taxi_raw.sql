{{ config(materialized='table') }}

{%- set parquet_path -%}
    /Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_project/data/raw/yellow_taxi/yellow_tripdata_*.parquet
{%- endset -%}

SELECT *
FROM read_parquet('{{ parquet_path.strip() }}')
