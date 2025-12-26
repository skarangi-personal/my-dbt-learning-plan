# 10-Day DBT Learning Curriculum
**For SQL-Strong Data Engineers**

---

## Table of Contents

1. [Curriculum Overview](#curriculum-overview)
2. [10-Day Module Breakdown](#10-day-module-breakdown)
3. [3 Progressive Projects](#3-progressive-projects)
4. [Data Modeling Reference](#data-modeling-reference)
5. [Success Criteria](#success-criteria)
6. [Resource Navigation Guide](#resource-navigation-guide)

---

## Curriculum Overview

### Target Audience
- **Background**: Data engineers with strong SQL skills but limited Python coding experience
- **Goal**: Master 30% of DBT functionality used in 80% of real-world scenarios
- **Learning Style**: Hands-on, project-based learning
- **Duration**: 10 days (6-8 hours per day)
- **Outcome**: Production-ready DBT proficiency

### Core Learning Principles
- Leverage existing SQL expertise while building Python confidence gradually
- Focus on DBT-specific patterns and anti-patterns
- Progress from fundamentals → intermediate → production-ready
- Emphasize Kimball methodology applied to DBT architecture
- Real-world project context for every concept

---

## 10-Day Module Breakdown

### **DAYS 1-3: Foundations & Project 1 (E-commerce Warehouse)**

#### Day 1: DBT Fundamentals & Setup
**Duration**: 6-8 hours (2 hrs concepts, 4-6 hrs hands-on)

**Learning Objectives**:
1. Understand DBT project structure and configuration
2. Set up development environment with DuckDB/Postgres/Snowflake
3. Execute first models and understand materializations
4. Comprehend DAG (Directed Acyclic Graph) concept

**Core Concepts**:
- DBT project anatomy (`dbt_project.yml`, models, tests, macros)
- Materializations: view, table, ephemeral (when to use each)
- `ref()` and `source()` functions for dependency management
- DAG visualization and model execution order
- dbt commands essentials: `dbt init`, `dbt run`, `dbt docs`

**Data Modeling Focus**:
- Introduction to Kimball methodology
- Fact vs. Dimension tables overview
- Star schema basics

**Hands-On Project Work** (Project 1 Start):
- Set up E-commerce data warehouse project
- Load raw source data (orders, customers, products)
- Create 2-3 staging models (SQL SELECT transformations)
- Understand ephemeral materializations for intermediate steps

**SQL-to-DBT Mapping**:
- SQL: `SELECT * FROM raw_data WHERE active = true` → DBT staging model
- Multiple CTEs in SQL → Multiple DBT models with `ref()` linking

**Common Pitfalls**:
- Circular dependencies in `ref()` usage
- Overusing tables instead of views (performance impact)
- Hardcoded table names instead of `source()` references

**Time Breakdown**: Setup (1hr) | Concepts (1hr) | Hands-on (4-6hrs)

**Recommended Resources for This Day**:
- **Primary**: dbt Learn Sandbox (start here)
- **Video**: Seattle Data Guy - "Complete DBT Setup Guide"
- **Docs**: dbt Documentation - Installation & Project Structure
- **Reference**: Official Jaffle Shop example project

---

#### Day 2: Models & Materializations Deep Dive
**Duration**: 6-8 hours (2.5 hrs concepts, 3.5-5.5 hrs hands-on)

**Learning Objectives**:
1. Master materialization strategies (view, table, incremental, ephemeral)
2. Optimize model performance based on data volume and query patterns
3. Implement layered architecture (staging → intermediate → marts)
4. Understand when to use each materialization type

**Core Concepts**:
- **View materialization**: Fastest to query, no storage, recalculates each time
- **Table materialization**: Slower initial run, instant queries, storage cost
- **Incremental materialization**: Only processes new/updated data
- **Ephemeral materialization**: Inlining CTEs without creating objects
- Layered architecture: `staging/`, `intermediate/`, `marts/`
- Model naming conventions (stg_*, int_*, fct_*, dim_*)

**Data Modeling Focus**:
- Grain of a fact table (what does each row represent?)
- Conformation of dimensions across multiple fact tables
- Star schema layout with DBT structure

**Hands-On Project Work** (Project 1 Continued):
- Refactor staging models with proper naming conventions
- Create intermediate models for business logic
- Create mart models (fact tables for orders, dimensions for customers/products)
- Experiment with different materializations and compare performance
- Set `materialized: table` for final marts, `ephemeral` for reusable CTEs

**SQL Examples**:
```sql
-- SQL CTE pattern
WITH customer_orders AS (
  SELECT customer_id, COUNT(*) as order_count
  FROM orders
  GROUP BY customer_id
)
SELECT * FROM customer_orders

-- DBT equivalent
-- staging/stg_orders.sql (ephemeral)
-- intermediate/int_customer_orders.sql (ephemeral)
-- marts/fct_orders.sql (table)
-- marts/dim_customers.sql (table)
```

**Common Pitfalls**:
- Using tables for high-volume intermediate models (wastes storage)
- Not understanding the performance/cost tradeoffs
- Inconsistent naming conventions across layers

**Time Breakdown**: Concepts (2.5hrs) | Hands-on (3.5-5.5hrs)

**Recommended Resources for This Day**:
- **Video**: dbt Labs - "Understanding Models and Materializations"
- **Blog**: Locally Optimistic - Materialization patterns
- **Docs**: dbt - Model Materializations reference
- **Practice**: Experiment in sandbox with different materializations

---

#### Day 3: Testing & Documentation
**Duration**: 6-8 hours (2 hrs concepts, 4-6 hrs hands-on)

**Learning Objectives**:
1. Implement generic tests (not null, unique, accepted values)
2. Write singular (custom SQL) tests for business logic
3. Document models and columns with YAML metadata
4. Generate and explore data lineage documentation

**Core Concepts**:
- **Generic tests**: Pre-built tests (not_null, unique, relationships, accepted_values)
- **Singular tests**: Custom SQL tests in `tests/` directory
- **Test configurations**: Thresholds, conditional execution
- **YAML metadata**: Properties files for models, columns, tests
- **Documentation generation**: `dbt docs generate` and `dbt docs serve`
- **Lineage tracking**: Understanding model dependencies and impact analysis

**Data Modeling Focus**:
- Surrogate keys and primary key uniqueness
- Referential integrity between facts and dimensions
- Data quality checks specific to dimensional models

**Hands-On Project Work** (Project 1 Complete):
- Add generic tests to Project 1 models:
  - NOT NULL on key columns (customer_id, order_id, product_id)
  - UNIQUE on surrogate keys
  - RELATIONSHIPS between fact and dimension tables
- Write singular tests for business logic:
  - Orders from future dates (data quality check)
  - Revenue not negative (business rule)
- Document all models with descriptions in YAML
- Generate documentation site and review data lineage
- Run `dbt test` and fix any failures

**SQL Examples**:
```sql
-- Singular test: tests/validate_no_future_orders.sql
SELECT * FROM {{ ref('fct_orders') }}
WHERE order_date > CURRENT_DATE
HAVING COUNT(*) > 0
```

**Common Pitfalls**:
- Writing tests without understanding what they verify
- Overcomplicating singular tests instead of fixing data source
- Forgetting to document why tests exist

**Time Breakdown**: Concepts (2hrs) | Hands-on (4-6hrs)

**Recommended Resources for This Day**:
- **Primary**: dbt Learn - Testing module
- **Video**: dbt Labs - "Testing Your Transformations"
- **Docs**: dbt - Testing documentation
- **Reference**: Jaffle Shop tests as examples

**Project 1 Deliverables** (Days 1-3):
✓ 3-layer model architecture (staging → intermediate → marts)
✓ 5+ models with proper materializations
✓ 10+ generic tests + 2 singular tests
✓ Full YAML documentation
✓ Generated documentation site with lineage diagrams

---

### **DAYS 4-7: Intermediate Transformations & Project 2 (Analytics Platform)**

#### Day 4: Sources & Freshness Management
**Duration**: 6-8 hours (1.5 hrs concepts, 4.5-6.5 hrs hands-on)

**Learning Objectives**:
1. Define data sources with YAML configuration
2. Implement source freshness checks
3. Understand source-to-staging patterns
4. Track data lineage from raw sources through marts

**Core Concepts**:
- **Sources**: YAML definitions of upstream raw data
- **Source naming**: Database/schema/table hierarchy
- **Freshness checks**: Warn if source data hasn't updated in X hours
- **Source tests**: Testing data at ingestion point
- **Source documentation**: Metadata for raw tables
- **Loaded_at column**: Timestamp for freshness tracking

**Data Modeling Focus**:
- Source system identification (CRM, payment processor, logs)
- Raw data quality responsibility
- Staging as translation layer between raw and clean data

**Hands-On Project Work** (Project 2 Start):
- Define data sources in `sources.yml`:
  - Analytics platform sources (user events, sessions, conversions)
  - 3+ raw tables from different systems
- Add freshness checks:
  - Error if data > 24 hours old
  - Warn if data > 12 hours old
- Create source tests (not null on key columns)
- Create staging models that transform raw source data
- Document sources with descriptions and column metadata

**SQL Examples**:
```yaml
# sources.yml
version: 2
sources:
  - name: analytics_platform
    database: raw_data
    schema: events
    tables:
      - name: user_events
        freshness:
          warn_after: {count: 12, period: hour}
          error_after: {count: 24, period: hour}
        loaded_at_field: created_at
        tests:
          - not_null:
              column_name: user_id
```

**Common Pitfalls**:
- Ignoring freshness warnings until data breaks downstream
- Source tests too strict (causing false failures)
- Not updating source documentation

**Time Breakdown**: Concepts (1.5hrs) | Hands-on (4.5-6.5hrs)

**Recommended Resources for This Day**:
- **Docs**: dbt - Sources reference
- **Video**: Seattle Data Guy - Source configuration guide
- **Reference**: Jaffle Shop sources.yml examples

---

#### Day 5: Advanced Data Modeling - Slowly Changing Dimensions
**Duration**: 6-8 hours (2.5 hrs concepts, 3.5-5.5 hrs hands-on)

**Learning Objectives**:
1. Implement SCD Type 2 (Slowly Changing Dimensions)
2. Use `dbt-utils` macros for surrogate key generation
3. Track dimension history and validity periods
4. Query historical data effectively

**Core Concepts**:
- **SCD Type 0**: Never changes (unlikely in real world)
- **SCD Type 1**: Overwrite with latest value (lose history)
- **SCD Type 2**: Create new records with effective dates (preserve history)
- **Surrogate keys**: Generated keys independent of natural keys
- **Effective dating**: `valid_from_date` and `valid_to_date`
- **Snapshots**: DBT's built-in feature for SCD Type 2

**Data Modeling Focus**:
- When to use SCD Type 2 (customer attributes, product details)
- Natural key vs. surrogate key distinction
- Join logic for dimensional queries (as-of joins)
- Grain consistency in fact tables

**Hands-On Project Work** (Project 2 Continued):
- Install `dbt-utils` package
- Implement snapshots for dimension tables:
  - Customer dimension: Track address changes, name updates
  - Product dimension: Price and category changes
- Create snapshot models with:
  - Natural key identification
  - Change detection (SQL: `dbt_scd_id`, `dbt_valid_from`, `dbt_valid_to`)
- Implement as-of joins in fact tables using snapshots
- Query historical data (e.g., "revenue by customer at time of order")
- Version dimension tables (dim_customers_v1, dim_products_v1)

**SQL Examples**:
```sql
-- Fact table with SCD Type 2 join
SELECT
  f.order_id,
  f.order_date,
  f.customer_id,
  d.customer_name,
  d.customer_address  -- Gets historical value from snapshot
FROM {{ ref('fct_orders') }} f
LEFT JOIN {{ ref('dim_customers_snapshot') }} d
  ON f.customer_id = d.customer_id
  AND f.order_date BETWEEN d.dbt_valid_from AND COALESCE(d.dbt_valid_to, CURRENT_DATE)
```

**Common Pitfalls**:
- Using SCD Type 2 for everything (performance impact)
- Forgetting to update fact tables to use snapshots
- Confused about valid_to_date logic (should be exclusive end date)

**Time Breakdown**: Concepts (2.5hrs) | Hands-on (3.5-5.5hrs)

**Recommended Resources for This Day**:
- **Docs**: dbt - Snapshots reference
- **Video**: Luke Barousse - SCD Type 2 explained
- **Blog**: Kimball Group - Slowly changing dimensions
- **Practice**: Jaffle Shop advanced snapshot patterns

---

#### Day 6: Incremental Models & Performance Optimization
**Duration**: 6-8 hours (2 hrs concepts, 4-6 hrs hands-on)

**Learning Objectives**:
1. Build incremental models for large tables
2. Understand dbt-core incremental strategies (append, merge, delete+insert)
3. Optimize query performance with partitioning
4. Handle idempotency and deduplication

**Core Concepts**:
- **Incremental materialization**: Only process new rows (faster, cheaper)
- **dbt_internal_is_incremental()**: Conditional logic for incremental runs
- **Incremental strategies**:
  - Append: Add new rows (fast, assumes no updates)
  - Merge: Insert/update based on unique key (slower, handles updates)
  - Delete+insert: Rebuild changed partitions (balanced approach)
- **Partition keys**: For large fact tables (date-based)
- **Idempotency**: Same run produces same result
- **Deduplication**: Handling duplicates in raw data

**Data Modeling Focus**:
- Incremental design patterns for fact tables
- Date-based partitioning strategies
- Grain considerations for incremental updates
- History tracking (when to use incremental vs. snapshots)

**Hands-On Project Work** (Project 2 Continued):
- Convert large fact table to incremental model:
  ```sql
  {{ config(
    materialized='incremental',
    on_schema_change='fail',
    unique_key='order_id'
  ) }}

  SELECT * FROM {{ source('raw', 'orders') }}
  {% if execute and this.exists and not should_fullrefresh %}
    WHERE order_date > (SELECT MAX(order_date) FROM {{ this }})
  {% endif %}
  ```
- Test incremental runs vs. full refresh
- Benchmark performance improvements
- Implement merge strategy for SCD updates
- Add data quality checks for duplicates

**Common Pitfalls**:
- Not tracking max_date properly (duplicate rows)
- Assuming append strategy when updates occur
- Not testing full refresh occasionally

**Time Breakdown**: Concepts (2hrs) | Hands-on (4-6hrs)

**Recommended Resources for This Day**:
- **Docs**: dbt - Incremental materializations
- **Blog**: dbt Blog - Incremental patterns
- **Video**: Analytics Engineering Weekly - Performance optimization

---

#### Day 7: Jinja, Macros & Reusable Patterns
**Duration**: 6-8 hours (2.5 hrs concepts, 3.5-5.5 hrs hands-on)

**Learning Objectives**:
1. Understand Jinja templating fundamentals
2. Write reusable macros for common transformations
3. Use dbt-utils macros effectively
4. Avoid DRY (Don't Repeat Yourself) violations

**Core Concepts**:
- **Jinja basics**: Variables, loops, conditionals, filters
- **Variables**: dbt `var()` for parameterization
- **Macros**: Reusable SQL code blocks
- **dbt-utils**: Pre-built macros (generate_surrogate_key, get_column_values, etc.)
- **Control structures**: `if`, `for` in SQL templates
- **Filters**: `upper`, `lower`, `pluralize` for string manipulation
- **Built-in variables**: `this`, `target`, `execute`, `run_started_at`

**Data Modeling Focus**:
- Macro-driven column standardization
- Dynamic dimension building
- Reusable fact table patterns

**Hands-On Project Work** (Project 2 Complete):
- Write custom macros:
  - Column standardization (naming conventions)
  - Flag generation (is_active, is_deleted)
  - Test data masking (mask PII in dev)
- Use dbt-utils macros:
  - `generate_surrogate_key()` for dimension keys
  - `get_column_values()` for dynamic tests
- Implement conditional logic:
  - Different processing for dev vs. prod environments
  - Feature flags for new transformations
- Create Jinja examples showing SQL-to-Jinja translation

**SQL Examples**:
```sql
-- SQL CTE with repeated pattern
WITH customer_flags AS (
  SELECT
    customer_id,
    CASE WHEN created_at > CURRENT_DATE - INTERVAL 30 DAY THEN TRUE ELSE FALSE END AS is_new,
    CASE WHEN last_order_date IS NULL THEN TRUE ELSE FALSE END AS is_inactive,
    CASE WHEN status = 'DELETED' THEN TRUE ELSE FALSE END AS is_deleted
  FROM customers
)

-- DBT macro approach (macros/generate_flags.sql)
{% macro generate_flags(table, date_col, last_activity_col) %}
  CASE WHEN {{ date_col }} > CURRENT_DATE - INTERVAL 30 DAY THEN TRUE ELSE FALSE END AS is_new,
  CASE WHEN {{ last_activity_col }} IS NULL THEN TRUE ELSE FALSE END AS is_inactive,
  CASE WHEN status = 'DELETED' THEN TRUE ELSE FALSE END AS is_deleted
{% endmacro %}
```

**Common Pitfalls**:
- Over-engineering macros for one-off use
- Complex Jinja reducing readability
- Not testing macros with different inputs

**Time Breakdown**: Concepts (2.5hrs) | Hands-on (3.5-5.5hrs)

**Recommended Resources for This Day**:
- **Primary**: dbt Learn - Jinja tutorial
- **Video**: dbt Labs - Macros & Jinja explained
- **Blog**: Real Python - Jinja template basics
- **Reference**: dbt-utils package documentation

**Project 2 Deliverables** (Days 4-7):
✓ Source definitions with freshness checks
✓ SCD Type 2 snapshots for 2+ dimensions
✓ Incremental fact table with 40%+ performance improvement
✓ 3+ custom macros for reusable patterns
✓ 15+ models across all layers
✓ Comprehensive test suite (20+ tests)

---

### **DAYS 8-10: Production Ready & Project 3 (Enterprise Pipeline)**

#### Day 8: Seeds & Reference Data Management
**Duration**: 6-8 hours (1.5 hrs concepts, 4.5-6.5 hrs hands-on)

**Learning Objectives**:
1. Use seeds for reference/lookup data
2. Implement version control for seed data
3. Create maintenance workflows for reference tables
4. Understand seed versioning and CI/CD integration

**Core Concepts**:
- **Seeds**: CSV files converted to database tables
- **Seed structure**: `seeds/` directory with CSV files
- **Column types**: Defining data types for seed columns
- **Versioning**: Tracking changes to reference data
- **Version control**: Seeds as part of git repository
- **Maintenance**: Updating seeds without breaking dependencies

**Data Modeling Focus**:
- Reference data (lookup tables, mappings)
- Configuration management (thresholds, rules)
- Dimension hierarchies

**Hands-On Project Work** (Project 3 Start):
- Create seed files for Project 3:
  - Product category mappings
  - Region/territory hierarchies
  - Business rules configurations
- Configure seed column types in `dbt_project.yml`
- Load seeds: `dbt seed`
- Reference seeds in models: `source('seeds', 'category_mapping')`
- Track seed changes in git
- Document seed purpose and maintenance schedule

**Common Pitfalls**:
- Using seeds for large datasets (should use sources)
- Not versioning seed changes
- Hardcoding values instead of using seeds

**Time Breakdown**: Concepts (1.5hrs) | Hands-on (4.5-6.5hrs)

**Recommended Resources for This Day**:
- **Docs**: dbt - Seeds reference
- **Blog**: Locally Optimistic - Reference data patterns
- **Reference**: Jaffle Shop seeds examples

---

#### Day 9: Testing at Scale & Data Quality
**Duration**: 6-8 hours (2 hrs concepts, 4-6 hrs hands-on)

**Learning Objectives**:
1. Build comprehensive data quality checks
2. Use dbt-expectations package for advanced tests
3. Implement data quality frameworks
4. Debug test failures and data issues

**Core Concepts**:
- **Generic test configurations**: Tags, thresholds, limits
- **dbt-expectations**: Pre-built data quality tests
- **Custom generic tests**: Writing reusable test templates
- **Test severity**: Warning vs. Error
- **Test failure debugging**: Understanding why tests fail
- **Data quality metrics**: Row counts, null percentages, freshness
- **Threshold-based tests**: Allowing some degree of failure

**Data Modeling Focus**:
- Quality checks at each layer
- Source-to-mart validation
- Referential integrity across dimensions and facts

**Hands-On Project Work** (Project 3 Continued):
- Implement advanced tests with dbt-expectations:
  - Distribution tests (values within expected range)
  - Schema change detection
  - Outlier detection
- Create custom generic test template:
  - Revenue within expected bounds
  - Order counts meet minimum threshold
- Set test severity levels:
  - Critical tests: Error (fail CI/CD)
  - Warning tests: Warn but allow deployment
- Implement data quality dashboard concept:
  - Test execution results
  - Data freshness status
  - Quality metrics tracking

**Common Pitfalls**:
- Too strict thresholds breaking legitimate data
- Not investigating root cause of test failures
- Ignoring warning-level test failures

**Time Breakdown**: Concepts (2hrs) | Hands-on (4-6hrs)

**Recommended Resources for This Day**:
- **Docs**: dbt - Advanced testing patterns
- **Package**: dbt-expectations GitHub
- **Blog**: Analytics Engineering Weekly - Data quality approaches

---

#### Day 10: CI/CD & Production Deployment
**Duration**: 6-8 hours (2 hrs concepts, 4-6 hrs hands-on)

**Learning Objectives**:
1. Set up CI/CD workflows for dbt
2. Understand git branching strategy
3. Implement production deployment pipeline
4. Monitor dbt runs and troubleshoot issues

**Core Concepts**:
- **Continuous Integration (CI)**: Automated testing on code changes
- **Continuous Deployment (CD)**: Automated deployment to production
- **dbt Cloud**: Managed CI/CD environment
- **Git branching**: Feature branches, testing, production
- **Pre-commit hooks**: Early validation before commit
- **Run artifacts**: Documentation and lineage artifacts
- **Scheduling**: Regular runs (daily, hourly)
- **Alerts & monitoring**: Failure notifications, performance tracking

**Data Modeling Focus**:
- Production-grade dimension & fact table validation
- Automated refresh schedules
- Monitoring data quality in production
- Rollback strategies for bad deployments

**Hands-On Project Work** (Project 3 Complete):
- Configure CI/CD pipeline:
  - Git workflow: Create feature branch, make changes
  - CI step: Run `dbt parse`, `dbt compile`, `dbt test` on PR
  - CD step: Deploy to production on merge
- Set up notifications:
  - Slack alerts for failed runs
  - Email summaries of data quality
- Implement scheduling:
  - Daily incremental refresh (6 AM)
  - Full refresh weekly (Sunday)
- Document runbook:
  - How to rollback failed deployment
  - How to investigate failed tests
  - Performance tuning procedures

**Common Pitfalls**:
- Deploying without testing first
- No monitoring of production runs
- Unclear rollback procedures

**Time Breakdown**: Concepts (2hrs) | Hands-on (4-6hrs)

**Recommended Resources for This Day**:
- **Primary**: dbt Learn - Production setup
- **Course**: Maven Analytics - Production deployment module
- **Docs**: dbt Cloud documentation
- **Reference**: DataTalks.Club - CI/CD patterns

**Project 3 Deliverables** (Days 8-10):
✓ 20+ models in production architecture
✓ Seed files for reference data
✓ Advanced data quality test suite (30+ tests)
✓ CI/CD pipeline with automated testing
✓ Production deployment runbook
✓ Monitoring & alerting setup
✓ Complete documentation and lineage

---

## 3 Progressive Projects

### **Project 1: E-commerce Data Warehouse (Days 1-3)**

**Business Context**:
You're building a data warehouse for an e-commerce platform. The data team needs self-serve analytics on orders, customers, and products.

**Raw Data Structure**:
- `raw_orders`: order_id, customer_id, product_id, order_date, amount (10K rows)
- `raw_customers`: customer_id, name, email, city, country, created_at (5K rows)
- `raw_products`: product_id, product_name, category, price (500 rows)

**Business Requirements**:
1. How many orders per day, week, month?
2. Which customers are most valuable (by lifetime value)?
3. Which products drive the most revenue?
4. What's the repeat order rate?

**Data Model Architecture**:
```
Staging Layer:
  - stg_orders (clean orders)
  - stg_customers (clean customers)
  - stg_products (clean products)

Intermediate Layer:
  - int_customer_ltv (customer lifetime value)
  - int_product_revenue (revenue per product)

Mart Layer:
  - fct_orders (fact table)
  - dim_customers (dimension table)
  - dim_products (dimension table)
  - dim_dates (date dimension)
```

**Model Count**: 8 models
**Tests**: 10+ generic tests
**Estimated Complexity**: ⭐ (Beginner)

**Success Metrics**:
- All tests pass
- Documentation complete with descriptions
- Lineage diagram shows clear dependencies
- Marts populated and queryable

---

### **Project 2: Multi-Source Analytics Platform (Days 4-7)**

**Business Context**:
You're building an analytics platform that ingests data from multiple sources: web analytics, CRM, payment processor. The team needs advanced analysis with historical tracking.

**Raw Data Structure**:
- `events_user_events`: user_id, event_type, event_date, properties (1M rows)
- `events_sessions`: session_id, user_id, session_date, duration (500K rows)
- `crm_customers`: customer_id, name, status, created_date, updated_date (100K rows)
- `payments_transactions`: transaction_id, customer_id, amount, status, date (300K rows)
- `product_list`: product_id, name, category, list_price (5K rows)

**Business Requirements**:
1. Track customer journey from event → session → transaction
2. Identify high-value customer segments
3. Measure product performance and trends
4. Historical customer attribute tracking (SCD Type 2)

**Data Model Architecture**:
```
Staging Layer (from sources):
  - stg_user_events
  - stg_sessions
  - stg_crm_customers
  - stg_transactions
  - stg_products

Intermediate Layer:
  - int_customer_session_metrics
  - int_customer_ltv
  - int_product_performance
  - int_customer_attributes (SCD preparation)

Snapshot Layer:
  - snap_customers (SCD Type 2)
  - snap_products

Mart Layer:
  - fct_events (incremental)
  - fct_sessions (incremental)
  - fct_transactions (incremental)
  - dim_customers (with history)
  - dim_products (with history)
  - dim_dates
  - dim_segments
```

**Model Count**: 18+ models
**Tests**: 20+ tests
**Materializations**: 5+ tables, 3+ incremental, 2+ snapshots
**Estimated Complexity**: ⭐⭐ (Intermediate)

**Success Metrics**:
- Incremental models reduce run time by 40%+
- SCD Type 2 dimensions track all customer changes
- Historical queries work correctly with as-of joins
- All source freshness checks passing

---

### **Project 3: Production-Grade Data Pipeline with Monitoring (Days 8-10)**

**Business Context**:
You're building an enterprise-grade data platform. The pipeline must handle scale, quality, and reliability. Data quality is critical, and teams depend on accurate, timely data.

**Raw Data Structure**:
- `raw_orders`: order_id, customer_id, product_id, order_date, amount, updated_at (10M rows, incremental)
- `raw_customers`: customer_id, name, email, tier, created_at, updated_at (1M rows)
- `raw_transactions`: transaction_id, order_id, customer_id, status, timestamp (50M rows)
- `raw_inventory`: product_id, warehouse_id, quantity, last_updated (10K rows)
- `seed_business_rules`: rule_name, threshold, active (configuration)

**Business Requirements**:
1. Real-time inventory tracking (hourly updates)
2. Daily revenue reporting with quality guarantees
3. Customer segmentation for marketing campaigns
4. Automated alerts for data quality issues
5. Fast queries on 10M+ row fact tables

**Data Model Architecture**:
```
Source Layer:
  - sources.yml with freshness checks for all 5 tables

Staging Layer:
  - stg_orders (from orders source)
  - stg_customers (from customers source)
  - stg_transactions (from transactions source)
  - stg_inventory (from inventory source)

Intermediate Layer:
  - int_order_metrics
  - int_customer_segments
  - int_inventory_status
  - int_transaction_summaries

Snapshot Layer:
  - snap_customers (daily, SCD Type 2)
  - snap_products (weekly, SCD Type 2)

Mart Layer:
  - fct_orders (incremental, daily partition)
  - fct_transactions (incremental, hourly partition)
  - fct_inventory (table, updated hourly)
  - dim_customers (from snapshot)
  - dim_products (from snapshot)
  - dim_dates
  - dim_warehouses
  - agg_daily_revenue (pre-aggregated for reporting)

Monitoring/Reference:
  - seed_business_rules
  - seed_business_alerts
```

**Model Count**: 25+ models
**Tests**: 30+ tests (including advanced dbt-expectations)
**Incremental Models**: 3+ with merge/delete strategies
**Snapshots**: 2+ with daily/weekly cadence
**Estimated Complexity**: ⭐⭐⭐ (Advanced)

**CI/CD Requirements**:
- Automated testing on every commit
- Scheduled runs (daily refresh, hourly inventory)
- Slack notifications for failures
- Rollback procedures

**Success Metrics**:
- All models complete in < 30 minutes (daily run)
- No data quality alerts in production
- 95%+ query performance vs. raw tables
- Runbook documents all procedures
- Team can deploy confidently

---

## Data Modeling Reference

### Kimball Methodology in DBT

#### 1. Dimensional Modeling Basics

**Fact Tables** (What happened?):
- Contain measurable events (orders, clicks, transactions)
- Grain: Lowest atomic level (one row = one order, one click)
- Foreign keys to dimensions
- Numeric measures (amounts, counts, durations)
- Time-based keys (order_date, transaction_timestamp)

**Dimension Tables** (Who, What, Where, When?):
- Contain context/attributes for facts
- Slowly changing (SCD Type 1, 2, or 3)
- Natural keys + surrogate keys
- Denormalized for query efficiency
- Examples: customers, products, dates, locations

**Example Star Schema**:
```
              dim_customers
                    |
                    | (customer_sk)
                    |
dim_dates -----> fct_orders <----- dim_products
   |                 |
   |                 | (order_date_sk)
   |                 |
   |------------ dim_dates

fct_orders columns:
  - order_id (business key)
  - order_date_sk (foreign key)
  - customer_sk (foreign key)
  - product_sk (foreign key)
  - order_amount (measure)
```

#### 2. DBT Layered Architecture

**Layer 1: Staging (stg_*)**
- One-to-one with source tables
- Light transformations (rename, type cast, basic validation)
- Ephemeral materialization (usually)
- Purpose: Standardize raw data

**Layer 2: Intermediate (int_*)**
- Business logic and calculations
- Join multiple sources
- Ephemeral or table based on complexity
- Purpose: Reusable transformation logic

**Layer 3: Marts (fct_*, dim_*)**
- Final business-facing tables
- Optimized for queries (materialized as tables)
- Business users query these
- Purpose: Easy self-serve analytics

#### 3. Grain and Conformation

**Grain Definition**:
- What does each row represent?
- Examples:
  - Order grain: one row per order
  - Order detail grain: one row per line item
  - Daily summary grain: one row per day per customer

**Conformation**:
- Same dimension used by multiple facts
- Same customer dimension in orders, returns, complaints
- Ensures consistency across analytics

#### 4. Surrogate Keys & Natural Keys

**Natural Key**: Business identifier
- customer_email, order_id
- Can change or be duplicated
- Used in sources

**Surrogate Key**: Generated identifier
- customer_sk, order_sk
- Stable across time
- Used in fact/dimension tables
- Generated in DBT using `dbt_utils.generate_surrogate_key()`

#### 5. Slowly Changing Dimensions (SCD)

**SCD Type 1: Overwrite**
```sql
-- Old value is lost
UPDATE dim_customers SET status = 'inactive' WHERE customer_id = 123
```
Use when: History not needed

**SCD Type 2: Add new row with dates**
```sql
-- Preserve history with validity dates
| customer_id | name     | status    | valid_from | valid_to   |
|-------------|----------|-----------|------------|------------|
| 123         | John     | active    | 2023-01-01 | 2023-06-30 |
| 123         | John     | inactive  | 2023-07-01 | NULL       |
```
Use when: Need to analyze "as of" a specific date

**SCD Type 3: Add new column**
```sql
-- Keep current and previous value
| customer_id | name     | current_status | previous_status |
|-------------|----------|----------------|-----------------|
| 123         | John     | inactive       | active          |
```
Use when: Only need current + previous value

#### 6. Star Schema Design Pattern in DBT

```
models/
├── staging/
│   ├── stg_orders.sql
│   ├── stg_customers.sql
│   └── stg_products.sql
├── intermediate/
│   ├── int_order_items.sql
│   └── int_customer_summary.sql
├── marts/
│   ├── fct_orders.sql
│   ├── fct_order_items.sql
│   ├── dim_customers.sql
│   ├── dim_products.sql
│   └── dim_dates.sql
└── snapshots/
    ├── snap_customers.sql
    └── snap_products.sql
```

---

## Success Criteria

### By End of Day 10, You Should Be Able To:

**Architecture & Design**:
- ✓ Design 3-layer data models (staging → intermediate → marts)
- ✓ Apply Kimball methodology to real-world scenarios
- ✓ Implement star schema patterns with DBT
- ✓ Choose appropriate materializations based on use case
- ✓ Design for incremental processing and scalability

**Implementation**:
- ✓ Build testable, documented DBT projects
- ✓ Implement SCD Type 2 patterns for slowly changing dimensions
- ✓ Optimize performance with incremental models
- ✓ Write Jinja macros for reusable patterns
- ✓ Deploy to production with CI/CD automation

**Testing & Quality**:
- ✓ Write comprehensive test suites (generic + singular)
- ✓ Implement data quality frameworks
- ✓ Debug test failures and investigate data issues
- ✓ Monitor data freshness and quality metrics

**Production Readiness**:
- ✓ Debug and monitor data pipelines
- ✓ Implement source freshness checks
- ✓ Set up alerting for failures
- ✓ Document runbooks for operational procedures
- ✓ Understand data lineage and impact analysis

**Communication**:
- ✓ Explain data lineage and model dependencies
- ✓ Document models with clear descriptions
- ✓ Generate lineage diagrams for stakeholders
- ✓ Communicate data quality to business teams

---

## Resource Navigation Guide

### Getting Started (Pick One Based on Learning Style)

**For Video Learners**: Start with dbt Labs YouTube channel
- "Getting Started with dbt" (15 mins)
- "Understanding Models and Materializations" (20 mins)

**For Hands-On Learners**: Start with dbt Learn Sandbox
- Free, no setup required
- Pre-configured environment
- Interactive tutorials

**For Book Learners**: Start with Kimball Group Reader excerpts
- Understand "why" behind data models
- Reference throughout the 10 days

**For Community Learners**: Join dbt Slack
- 50,000+ members
- Channel for every topic
- Real-world problem solving

### Daily Resource Breakdown

**Days 1-3 Focus**: Fundamentals
- dbt Learn tutorials (primary)
- Seattle Data Guy setup videos
- Official dbt documentation

**Days 4-7 Focus**: Advanced patterns
- Locally Optimistic blog posts
- Analytics Engineering Weekly podcast
- Jaffle Shop repository code examples

**Days 8-10 Focus**: Production
- dbt Cloud documentation
- Maven Analytics advanced modules
- DataTalks.Club Zoomcamp videos

### Quick Reference Materials

**Included in This Curriculum**:
1. SQL to Jinja Quick Reference (see appendix)
2. DBT Command Cheat Sheet (see appendix)
3. Troubleshooting Guide (see appendix)
4. Data Modeling Patterns (this section)

---

## Next Steps

1. **Choose Your Warehouse**: DuckDB (local), Postgres (local), or Snowflake (cloud)
2. **Set Up Environment**: Follow Day 1 setup instructions
3. **Start Project 1**: Build the e-commerce warehouse in Days 1-3
4. **Progress Through Projects**: Days 4-7 (analytics platform), Days 8-10 (production)
5. **Engage Resources**: Use recommended materials for each day
6. **Build Portfolio**: Complete all 3 projects as portfolio pieces

---

*Last Updated: December 2024*
*Version: 1.0*
