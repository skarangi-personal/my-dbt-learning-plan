# Quick Reference Guide: SQL to DBT Translation

A practical reference for translating SQL patterns to DBT patterns, with examples for each concept.

---

## 1. SQL to DBT Command Translation

### Basic Commands

| Task | SQL | DBT |
|------|-----|-----|
| Create table | `CREATE TABLE my_table AS SELECT ...` | `dbt run` (materialized='table') |
| Create view | `CREATE VIEW my_view AS SELECT ...` | `dbt run` (materialized='view') |
| Drop table | `DROP TABLE my_table` | `dbt run` (on-run-end hook) |
| Analyze/refresh | Manual refresh | `dbt run` |

### DBT Essential Commands

```bash
# Initialization & Setup
dbt init project_name              # Create new project
dbt debug                           # Test connection

# Running Models
dbt run                             # Run all models
dbt run --select model_name         # Run specific model
dbt run --select tag:daily          # Run models with tag
dbt run --full-refresh              # Rebuild from scratch
dbt run --select +model_name        # Run + upstream dependencies
dbt run --select model_name+        # Run + downstream dependents

# Testing & Quality
dbt test                            # Run all tests
dbt test --select model_name        # Test specific model
dbt freshness                       # Check source freshness

# Documentation
dbt docs generate                   # Generate lineage docs
dbt docs serve                      # Serve docs locally (localhost:8000)

# Snapshots & Incremental
dbt snapshot                        # Run snapshot models
dbt run --select config.materialized:incremental  # Run incremental only

# Profiles & Config
dbt profiles list                   # Show available profiles
```

---

## 2. Model Materialization Cheat Sheet

### When to Use Each

```
View (Fast to query, no storage):
  - SELECT queries used by other models
  - Thin transformation layers
  - Data volumes < 1M rows

Table (Instant queries, storage cost):
  - Final mart tables (fct_*, dim_*)
  - Complex transformations
  - Data volumes > 1M rows
  - Referenced frequently

Ephemeral (No storage, inlined):
  - Intermediate CTEs
  - One-time helpers
  - Never directly queried
  - Reusable logic blocks

Incremental (Only new data):
  - Large fact tables (100M+ rows)
  - Time-series data
  - Known append/update pattern
  - Daily/hourly refreshes

Snapshot (Historical tracking):
  - Slowly changing dimensions
  - Need full history
  - Point-in-time analysis
```

### Example Materialization Config

```yaml
# dbt_project.yml
models:
  my_project:
    staging:
      +materialized: ephemeral      # All staging views
    intermediate:
      +materialized: ephemeral      # Reusable logic
    marts:
      +materialized: table          # Final outputs
      fct_orders:
        +materialized: incremental  # Large table
        +unique_key: order_id
```

---

## 3. SQL Pattern Translation

### Pattern 1: Simple SELECT to Model

**SQL (Traditional approach)**:
```sql
CREATE TABLE public.dim_customers AS
SELECT
  customer_id,
  name,
  email,
  created_at
FROM raw_data.customers
WHERE deleted_at IS NULL;
```

**DBT (Modern approach)**:
```sql
-- models/marts/dim_customers.sql
SELECT
  customer_id,
  name,
  email,
  created_at
FROM {{ source('raw_data', 'customers') }}
WHERE deleted_at IS NULL
```

---

### Pattern 2: JOIN Multiple Tables

**SQL (Traditional)**:
```sql
CREATE TABLE public.fct_orders AS
SELECT
  o.order_id,
  o.customer_id,
  c.customer_name,
  o.product_id,
  p.product_name,
  o.order_date,
  o.amount
FROM raw_data.orders o
LEFT JOIN raw_data.customers c ON o.customer_id = c.customer_id
LEFT JOIN raw_data.products p ON o.product_id = p.product_id;
```

**DBT (Modern)**:
```sql
-- models/marts/fct_orders.sql
SELECT
  o.order_id,
  o.customer_id,
  c.customer_name,
  o.product_id,
  p.product_name,
  o.order_date,
  o.amount
FROM {{ ref('stg_orders') }} o
LEFT JOIN {{ ref('dim_customers') }} c ON o.customer_id = c.customer_id
LEFT JOIN {{ ref('dim_products') }} p ON o.product_id = p.product_id
```

**Key differences**:
- `{{ ref('model_name') }}` instead of raw table names
- Automatic dependency tracking
- Staging models handle raw to clean transformation

---

### Pattern 3: CTEs and Staging

**SQL (Traditional)**:
```sql
-- Step 1: Create staging table
CREATE TABLE staging_orders AS
SELECT
  order_id,
  customer_id,
  CAST(order_date AS DATE) AS order_date,
  CAST(amount AS NUMERIC(10,2)) AS amount,
  'USD' AS currency
FROM raw_data.orders
WHERE status != 'CANCELLED';

-- Step 2: Join with staging
SELECT
  s.order_id,
  s.customer_id,
  c.customer_name
FROM staging_orders s
JOIN public.customers c ON s.customer_id = c.customer_id;
```

**DBT (Modern)**:
```sql
-- models/staging/stg_orders.sql
SELECT
  order_id,
  customer_id,
  CAST(order_date AS DATE) AS order_date,
  CAST(amount AS NUMERIC(10,2)) AS amount,
  'USD' AS currency
FROM {{ source('raw_data', 'orders') }}
WHERE status != 'CANCELLED'

-- models/intermediate/int_orders_with_customers.sql
SELECT
  s.order_id,
  s.customer_id,
  c.customer_name
FROM {{ ref('stg_orders') }} s
JOIN {{ ref('dim_customers') }} c ON s.customer_id = c.customer_id
```

---

### Pattern 4: Data Quality Checks

**SQL (Traditional)**:
```sql
-- Manual check
SELECT COUNT(*) FROM orders WHERE order_id IS NULL;
SELECT COUNT(*) FROM orders WHERE amount < 0;
SELECT COUNT(DISTINCT customer_id) FROM orders;
```

**DBT (Modern)**:
```yaml
# models/marts/schema.yml
version: 2
models:
  - name: fct_orders
    columns:
      - name: order_id
        tests:
          - not_null
          - unique
      - name: customer_id
        tests:
          - not_null
          - relationships:
              to: ref('dim_customers')
              field: customer_id
      - name: amount
        tests:
          - not_negative
```

Run tests:
```bash
dbt test  # Runs all tests automatically
```

---

## 4. Jinja Templating Essentials

### Variables

```sql
-- Define variable (in dbt_project.yml or --vars)
# dbt_project.yml:
vars:
  start_date: '2023-01-01'
  environment: 'production'

-- Use in model
SELECT *
FROM {{ ref('orders') }}
WHERE order_date >= '{{ var("start_date") }}'
  AND environment = '{{ var("environment") }}'

-- Run with override
dbt run --vars '{"start_date": "2024-01-01"}'
```

### Conditionals

```sql
-- If/else logic
SELECT
  order_id,
  customer_id,
  amount
FROM {{ ref('orders') }}

-- Using environment variables
{% if target.name == 'prod' %}
  WHERE status = 'CONFIRMED'
{% else %}
  LIMIT 10000
{% endif %}
```

### Loops

```sql
-- Loop through list
SELECT
  order_id,
  {% for col in ['customer_id', 'product_id', 'amount'] %}
    {{ col }} {% if not loop.last %},{% endif %}
  {% endfor %}
FROM {{ ref('orders') }}
```

### Macros (Reusable Code)

```sql
-- macros/generate_flags.sql
{% macro generate_active_flags(date_col, last_activity_col) %}
  CASE WHEN {{ date_col }} > CURRENT_DATE - INTERVAL 30 DAY
    THEN TRUE ELSE FALSE END AS is_active,
  CASE WHEN {{ last_activity_col }} IS NULL
    THEN TRUE ELSE FALSE END AS is_inactive
{% endmacro %}

-- models/marts/dim_customers.sql
SELECT
  customer_id,
  name,
  {{ generate_active_flags('created_at', 'last_order_date') }}
FROM {{ ref('stg_customers') }}
```

---

## 5. Materialization Decision Tree

```
Should I use a TABLE?
- Size > 1M rows? YES -> TABLE
- Queried directly by users? YES -> TABLE
- Fact or dimension? YES -> TABLE
- Else -> EPHEMERAL or VIEW

Should I use EPHEMERAL?
- Reusable SQL logic? YES -> EPHEMERAL
- Only intermediate step? YES -> EPHEMERAL
- Complex CTE? YES -> EPHEMERAL
- Else -> VIEW or TABLE

Should I use INCREMENTAL?
- Size > 100M rows? YES -> INCREMENTAL
- Append-only data? YES -> INCREMENTAL
- Time-series fact? YES -> INCREMENTAL
- Else -> TABLE or VIEW

Should I use SNAPSHOT?
- Need historical data? YES -> SNAPSHOT
- Track changes over time? YES -> SNAPSHOT
- SCD Type 2 needed? YES -> SNAPSHOT
- Else -> TABLE
```

---

## 6. DBT Project Structure

### Recommended Layout

```
my_dbt_project/
├── dbt_project.yml              # Project config
├── profiles.yml                 # Database connections
├── models/
│   ├── staging/                 # Ephemeral: Clean raw data
│   │   ├── stg_orders.sql
│   │   ├── stg_customers.sql
│   │   └── sources.yml
│   ├── intermediate/            # Ephemeral: Business logic
│   │   ├── int_orders_summary.sql
│   │   └── int_customer_segments.sql
│   └── marts/                   # Tables: Final outputs
│       ├── fct_orders.sql
│       ├── dim_customers.sql
│       └── schema.yml
├── tests/                       # Custom tests
├── macros/                      # Reusable SQL code
├── snapshots/                   # SCD Type 2 models
├── seeds/                       # Reference data (CSV)
└── data/                        # Test data
```

---

## 7. Common Patterns

### Pattern: Dimensional Model (Star Schema)

```sql
-- models/marts/fct_orders.sql
SELECT
  order_id,
  order_date,
  customer_id,
  product_id,
  amount AS order_amount
FROM {{ ref('stg_orders') }}
```

### Pattern: Slowly Changing Dimension (SCD Type 2)

```sql
-- snapshots/snap_customers.sql
{% snapshot snap_customers %}
  SELECT
    customer_id,
    name,
    email,
    status,
    created_at
  FROM {{ source('raw_data', 'customers') }}
{% endsnapshot %}

-- models/marts/dim_customers.sql
SELECT
  customer_id,
  name,
  status,
  dbt_valid_from,
  dbt_valid_to
FROM {{ ref('snap_customers') }}
WHERE dbt_valid_to IS NULL
```

### Pattern: Incremental Model

```sql
-- models/marts/fct_events.sql
{{ config(
  materialized='incremental',
  unique_key='event_id'
) }}

SELECT
  event_id,
  user_id,
  event_date,
  event_type
FROM {{ ref('stg_events') }}

{% if is_incremental() %}
  WHERE event_date > (SELECT MAX(event_date) FROM {{ this }})
{% endif %}
```

---

## 8. Testing Cheat Sheet

### Generic Tests

```yaml
version: 2
models:
  - name: fct_orders
    columns:
      - name: order_id
        tests:
          - not_null
          - unique
      - name: customer_id
        tests:
          - not_null
          - relationships:
              to: ref('dim_customers')
              field: customer_id
      - name: status
        tests:
          - accepted_values:
              values: ['pending', 'shipped', 'delivered']
```

### Custom Tests

```sql
-- tests/validate_no_future_orders.sql
SELECT * FROM {{ ref('fct_orders') }}
WHERE order_date > CURRENT_DATE
```

---

## 9. Troubleshooting Flowchart

```
Issue: Relation not found
- Check: {{ ref('model_name') }} spelling
- Check: Model file exists
- Solution: dbt run first, then test

Issue: Circular dependency
- Check: DAG for circular refs
- Solution: dbt docs serve (visualize)
- Fix: Use ephemeral materialization

Issue: Test failed
- Check: Data quality in source
- Solution: dbt test --select model_name -d

Issue: Incremental duplicate rows
- Check: unique_key configured
- Check: max_date logic
- Solution: Run --full-refresh once
```

---

## 10. Performance Optimization Checklist

```
✓ Use EPHEMERAL for intermediate models
✓ Use INCREMENTAL for 100M+ row facts
✓ Add indexes on foreign keys
✓ Partition large tables by date
✓ Pre-aggregate for dashboards
✓ Test with LIMIT 10000 during development
✓ Monitor run times in dbt docs
```

---

## 11. Essential Jinja Filters

```sql
-- String filters
{{ 'hello world' | upper }}                 # HELLO WORLD
{{ 'HELLO' | lower }}                       # hello

-- List filters
{% set cols = ['a', 'b', 'c'] %}
{{ cols | join(', ') }}                     # a, b, c
{{ cols | length }}                         # 3

-- Default values
{{ var('threshold') | default(100) }}       # 100 (if not set)
```

---

## 12. Quick Project Setup

```bash
# Create project
dbt init my_dbt_project
cd my_dbt_project

# Create folders
mkdir models/staging models/intermediate models/marts

# First model
cat > models/marts/my_first_model.sql << 'ENDFILE'
SELECT * FROM {{ source('raw', 'my_table') }} LIMIT 10
ENDFILE

# Run
dbt run

# Generate docs
dbt docs generate && dbt docs serve
# Go to: http://localhost:8000
```

---

*Use this guide to quickly translate between SQL and DBT patterns. Bookmark for reference!*
