-- Macro to create external source views before dbt run
-- This allows using {{ source() }} directly in queries

{% macro create_sources() %}
    {# Create schema if it doesn't exist #}
    {% set create_schema_sql %}
        CREATE SCHEMA IF NOT EXISTS taxi_data
    {% endset %}

    {% do run_query(create_schema_sql) %}
    {% do log("Created schema: taxi_data", info=true) %}

    {# Create a view for the taxi_data.yellow_taxi_parquet source #}
    {% set create_view_sql %}
        CREATE OR REPLACE VIEW taxi_data.yellow_taxi_parquet AS
        SELECT *
        FROM read_parquet('/Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_project/data/raw/yellow_taxi/yellow_tripdata_*.parquet')
    {% endset %}

    {% do run_query(create_view_sql) %}
    {% do log("Created source view: taxi_data.yellow_taxi_parquet", info=true) %}
{% endmacro %}
