# DBT Project Standards & Best Practices

This document outlines the standards and best practices for this dbt project to ensure consistency, maintainability, and code quality.

---

## Table of Contents
1. [Project Structure](#project-structure)
2. [Model Organization](#model-organization)
3. [Testing Standards](#testing-standards)
4. [File Naming Conventions](#file-naming-conventions)
5. [Code Quality](#code-quality)
6. [Documentation](#documentation)

---

## Project Structure

### Directory Organization

```
dbt_project/
├── models/              # Data transformation models
│   ├── staging/         # Staging models (optional, for intermediate transformations)
│   ├── marts/           # Mart models (final business-facing tables/views)
│   └── schema.yml       # Model metadata and test definitions
│
├── tests/               # Data quality tests
│   ├── generic/         # Reusable generic test macros
│   └── *.sql            # Singular tests (specific to one model)
│
├── macros/              # Jinja2 helper functions and custom logic
│   └── (helper functions, not generic tests)
│
├── seeds/               # Static data files (CSV/YAML)
│
├── snapshots/           # SCD Type 2 snapshots for slowly changing dimensions
│
├── analyses/            # Ad-hoc analysis queries
│
├── dbt_project.yml      # dbt project configuration
├── profiles.yml         # Database connection profiles (DO NOT COMMIT)
└── .gitignore           # Git ignore rules
```

### Why This Structure?

- **Separation of Concerns**: Models, tests, and macros are clearly separated
- **Scalability**: Easy to organize growing number of models
- **Discoverability**: Clear directory names help developers find files quickly
- **Testing Organization**: Generic tests in `tests/generic/` for reuse, singular tests at `tests/` root

---

## Model Organization

### Model Layers

Models should be organized in layers following the medallion architecture:

1. **Raw/Staging Models** (`staging/`)
   - Source data loaded from external systems
   - Minimal transformations
   - Example: `stg_yellow_taxi_raw.sql`

2. **Intermediate Models** (`intermediate/` - optional)
   - Mid-level transformations combining multiple sources
   - Used by downstream models
   - Example: `int_taxi_with_geography.sql`

3. **Mart Models** (`marts/`)
   - Final business-facing tables/views
   - Aggregated, denormalized data
   - Example: `fct_taxi_trips.sql`, `dim_payment_types.sql`

### Model Configuration

Use `config` blocks in models to specify materialization and other settings:

```sql
{{ config(materialized='table') }}

SELECT *
FROM source_data
```

Common materializations:
- `table` - Creates a physical table (default for large datasets)
- `view` - Creates a database view (good for small/intermediate models)
- `incremental` - Only processes new/changed data

---

## Testing Standards

### Generic Tests (Reusable)

**Location**: `tests/generic/test_*.sql`

Generic tests are reusable test definitions applied to columns via `schema.yml`.

#### Built-in Generic Tests:
- `not_null` - Column must not contain NULL values
- `unique` - Column must contain unique values
- `accepted_values` - Column values must be in a predefined list
- `relationships` - Foreign key validation

#### Custom Generic Tests:
Create custom generic tests in `tests/generic/`:

```sql
{% test amount_positive(model, column_name) %}
    -- Custom test logic
    select *
    from {{ model }}
    where {{ column_name }} <= 0
{% endtest %}
```

Apply in `schema.yml`:
```yaml
columns:
  - name: fare_amount
    tests:
      - amount_positive
```

### Singular Tests (Model-Specific)

**Location**: `tests/test_*.sql`

Singular tests are SQL queries written for specific models/data quality checks:

```sql
-- tests/test_trip_duration_positive.sql
select count(*) as invalid_trips
from {{ ref('yellow_taxi_raw') }}
where (tpep_dropoff_datetime - tpep_pickup_datetime) <= interval '0 seconds'
having count(*) > 0
```

**When to use:**
- Complex multi-column validations
- Model-specific business logic checks
- Conditional logic that doesn't fit generic test pattern

### Test Execution

```bash
# Run all tests
dbt test

# Run specific test
dbt test --select test_trip_duration_positive

# Run tests for specific model
dbt test --select yellow_taxi_raw

# Run specific test type (generic)
dbt test --select amount_positive
```

### Test Results

- **PASS**: Query returns 0 rows (expected behavior)
- **FAIL**: Query returns rows (data quality issue detected)

---

## File Naming Conventions

### Models

```
{layer}_{domain}_{entity}_{transformation}.sql

Examples:
- stg_taxi_yellow_raw.sql           (staging model)
- int_taxi_geography_enriched.sql    (intermediate model)
- fct_taxi_trips.sql                 (fact table)
- dim_payment_types.sql              (dimension table)
```

### Tests

```
test_{model_name}_{condition}.sql

Examples:
- test_trip_duration_positive.sql
- test_yellow_taxi_raw_payment_valid.sql
```

### Generic Tests

```
test_{validation_type}.sql

Examples:
- test_amount_positive.sql
- test_email_format.sql
```

### Schema Files

```
schema.yml  (or models/schema.yml)
```

Contains:
- Model descriptions
- Column descriptions
- Column-level tests
- Model-level properties

---

## Code Quality

### SQL Formatting

All SQL files must be formatted with **sqlfluff**.

```bash
# Check formatting
sqlfluff lint models/

# Auto-fix formatting issues
sqlfluff fix models/
```

Configuration file: `.sqlfluff`

### dbt Linting

Use `dbt build` or `dbt run` with proper error handling to catch issues early.

### Ref and Source Functions

**Always use `ref()` for model references:**
```sql
-- ✓ Good
from {{ ref('stg_yellow_taxi_raw') }}

-- ✗ Avoid
from public.stg_yellow_taxi_raw
```

**Use `source()` for raw data sources:**
```yaml
# In schema.yml
sources:
  - name: taxi_data
    tables:
      - name: yellow_trips_raw
```

```sql
-- In model
from {{ source('taxi_data', 'yellow_trips_raw') }}
```

Benefits:
- Automatic dependency tracking
- Environment portability
- Clear data lineage
- Refactoring safety

---

## Documentation

### Model Documentation (schema.yml)

Every model and column should have clear descriptions:

```yaml
version: 2

models:
  - name: yellow_taxi_raw
    description: Raw yellow taxi trip data from NYC TLC

    columns:
      - name: tpep_pickup_datetime
        description: Pickup datetime in America/New_York timezone
        tests:
          - not_null

      - name: payment_type
        description: Payment method code (0=Unknown, 1=Credit, 2=Cash, etc)
        tests:
          - accepted_values:
              arguments:
                values: [0, 1, 2, 3, 4, 5, 6]
```

### SQL Comments

Add comments for complex logic:

```sql
-- Calculate trip duration in minutes
select
    trip_id,
    -- Duration rounded to nearest minute for reporting
    round(
        extract(epoch from (tpep_dropoff_datetime - tpep_pickup_datetime)) / 60
    ) as trip_duration_minutes
from {{ ref('yellow_taxi_raw') }}
```

### Data Dictionary

Generate automated documentation:

```bash
dbt docs generate
dbt docs serve
```

Accessible at: `http://localhost:8000`

---

## Development Workflow

### Running Models

```bash
# Run all models
dbt run

# Run specific model
dbt run -s yellow_taxi_raw

# Run model and tests
dbt build -s yellow_taxi_raw
```

### Testing Workflow

```bash
# 1. Develop model
# 2. Add tests in schema.yml
# 3. Run model
dbt run -s my_model

# 4. Test model
dbt test -s my_model

# 5. If tests pass, commit
git add .
git commit -m "Add my_model with tests"
```

---

## Git Commit Standards

### Commit Message Format

```
<type>(<scope>): <subject>

<body>

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>
```

### Commit Types

- `feat`: New model or feature
- `test`: Add or update tests
- `fix`: Fix data or logic issues
- `refactor`: Restructure code without changing behavior
- `docs`: Documentation updates
- `style`: Format/linting changes

### Examples

```
feat(models): Add fct_taxi_trips fact table with aggregations

- Aggregates trip-level data by date and payment type
- Includes fare and tip amount summaries
- Tested with not_null and accepted_values validations

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>
```

```
test(yellow_taxi): Add fare_amount positive validation test

- Added custom amount_positive generic test
- Applied to fare_amount and total_amount columns
- Detects data quality issues with non-positive monetary values

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>
```

---

## Do's and Don'ts

### ✓ DO

- Use `ref()` for all model references
- Write descriptive test and model names
- Document complex business logic
- Run tests before committing
- Use proper git commit messages
- Organize models by layer (staging, intermediate, marts)
- Apply sqlfluff formatting to all SQL

### ✗ DON'T

- Hardcode table names (use `ref()` instead)
- Skip tests - all models should have tests
- Commit without running `dbt test`
- Use unclear abbreviations in model names
- Leave models undocumented
- Mix multiple unrelated changes in one commit
- Commit `.dbt/profiles.yml` or secrets

---

## Resources

- [dbt Documentation](https://docs.getdbt.com)
- [dbt Best Practices](https://docs.getdbt.com/guides/best-practices)
- [sqlfluff](https://docs.sqlfluff.com)
- [dbt Community](https://discourse.getdbt.com)

---

**Last Updated**: December 29, 2025
**Version**: 1.0
