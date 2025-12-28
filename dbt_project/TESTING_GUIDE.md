# DBT Testing Guide

Comprehensive guide to implementing data quality tests in this dbt project.

---

## Quick Reference

| Test Type | Location | Usage | Reusable |
|-----------|----------|-------|----------|
| Generic | `tests/generic/test_*.sql` | Column-level validations | ✓ Yes |
| Singular | `tests/test_*.sql` | Model/multi-column checks | ✗ No |
| Built-in | N/A | `not_null`, `unique`, etc. | ✓ Yes |

---

## 1. Generic Tests

Generic tests are reusable SQL test patterns applied to multiple columns/models.

### Built-in Generic Tests

#### 1.1 Not Null

Ensures a column doesn't contain NULL values.

```yaml
# schema.yml
columns:
  - name: tpep_pickup_datetime
    tests:
      - not_null
```

When to use:
- Critical business identifiers (IDs, dates)
- Required fields in source data
- Foreign keys

---

#### 1.2 Unique

Ensures a column contains only unique values.

```yaml
columns:
  - name: trip_id
    tests:
      - unique
```

When to use:
- Primary keys
- Unique identifiers
- Any column that should have no duplicates

---

#### 1.3 Accepted Values

Ensures column values belong to a predefined list.

```yaml
columns:
  - name: payment_type
    tests:
      - accepted_values:
          arguments:
            values: [0, 1, 2, 3, 4, 5, 6]
```

When to use:
- Categorical data with fixed categories
- Status fields (active, inactive, pending)
- Enum-like fields
- Payment methods, ride types, etc.

```yaml
columns:
  - name: status
    tests:
      - accepted_values:
          arguments:
            values: ['active', 'inactive', 'pending']
```

---

#### 1.4 Relationships

Validates foreign key relationships between tables.

```yaml
# Child table: models/fct_taxi_trips.sql
columns:
  - name: payment_type_id
    tests:
      - relationships:
          arguments:
            to: ref('dim_payment_types')
            field: payment_type_id
```

When to use:
- Foreign key validations
- Referential integrity checks
- Ensuring child records have valid parent records

---

### Custom Generic Tests

Create reusable tests for domain-specific validations.

#### Example: Amount Positive Test

**File**: `tests/generic/test_amount_positive.sql`

```sql
{% test amount_positive(model, column_name) %}
    -- Test that a column contains only positive values (> 0)
    -- Usage: Apply to monetary/quantity columns

    select
        *
    from {{ model }}
    where {{ column_name }} <= 0
{% endtest %}
```

**Usage in schema.yml**:

```yaml
columns:
  - name: fare_amount
    description: Fare amount in USD
    tests:
      - amount_positive

  - name: total_amount
    description: Total amount in USD
    tests:
      - amount_positive
```

#### How to Write Custom Generic Tests

**Template**:

```sql
{% test test_name(model, column_name, [additional_args]) %}
    -- Detailed description of what this test validates
    -- Include usage examples in comments

    select
        *
    from {{ model }}
    where [test condition that finds violations]

    -- Test FAILS if query returns any rows
    -- Test PASSES if query returns 0 rows
{% endtest %}
```

**Key Points**:
- Test FAILS when query returns rows (violations found)
- Test PASSES when query returns 0 rows (validation successful)
- Use `model` and `column_name` parameters
- Add optional parameters for flexibility

#### More Custom Test Examples

**Email Format Validation**:

```sql
{% test email_format(model, column_name) %}
    select *
    from {{ model }}
    where {{ column_name }} not like '%@%.%'
        or {{ column_name }} like ' %'
        or {{ column_name }} like '% '
{% endtest %}
```

**Date Range Validation**:

```sql
{% test date_in_range(model, column_name, min_date, max_date) %}
    select *
    from {{ model }}
    where {{ column_name }} < '{{ min_date }}'
        or {{ column_name }} > '{{ max_date }}'
{% endtest %}
```

Usage:
```yaml
columns:
  - name: birth_date
    tests:
      - date_in_range:
          arguments:
            min_date: '1900-01-01'
            max_date: current_date
```

---

## 2. Singular Tests

Singular tests are custom SQL queries for complex, model-specific validations.

**File**: `tests/test_trip_duration_positive.sql`

```sql
-- Validate that trip duration is always positive
-- This test checks: tpep_dropoff_datetime - tpep_pickup_datetime > 0

select
    count(*) as invalid_trips
from {{ ref('yellow_taxi_raw') }}
where
    (tpep_dropoff_datetime - tpep_pickup_datetime) <= interval '0 seconds'
having
    count(*) > 0
```

### When to Use Singular Tests

Use singular tests for:
- **Complex multi-column logic**: Combining multiple columns
- **Cross-table validations**: Data consistency across models
- **Time-based checks**: Before/after dates, duration validations
- **Aggregate validations**: Checking totals, counts, sums
- **Business rule validations**: Complex domain logic

### Singular Test Best Practices

1. **Clear naming**: Name indicates what is being tested
   ```
   ✓ test_trip_duration_positive.sql
   ✗ test_yellow_taxi_raw.sql  (too vague)
   ```

2. **Self-documenting SQL**: Include comments explaining the logic
   ```sql
   -- Validate taxi trip durations are positive
   -- Business rule: No trip should take 0 or negative time

   select count(*)
   from {{ ref('yellow_taxi_raw') }}
   where (tpep_dropoff_datetime - tpep_pickup_datetime) <= interval '0 seconds'
   having count(*) > 0
   ```

3. **Readable assertions**: Test should clearly show what passes/fails
   ```sql
   -- Good: Clear what's being tested
   select count(*) as data_quality_issues
   from transactions
   where amount < 0
   having count(*) > 0
   ```

---

## 3. Test Application in schema.yml

### Structure

```yaml
version: 2

models:
  - name: yellow_taxi_raw
    description: Raw yellow taxi trip data

    columns:
      - name: trip_id
        description: Unique trip identifier
        tests:
          - not_null
          - unique

      - name: tpep_pickup_datetime
        description: Pickup datetime
        tests:
          - not_null

      - name: payment_type
        description: Payment method code
        tests:
          - accepted_values:
              arguments:
                values: [0, 1, 2, 3, 4, 5, 6]

      - name: fare_amount
        description: Base fare amount in USD
        tests:
          - not_null
          - amount_positive

      - name: total_amount
        description: Total trip amount in USD
        tests:
          - not_null
          - amount_positive
```

### Test Grouping Strategy

1. **Critical Tests** (run frequently)
   - `not_null` on IDs and dates
   - `unique` on primary keys
   - `accepted_values` for categorical data

2. **Quality Tests** (catch data issues)
   - `amount_positive` for monetary values
   - Format validations for emails, phones
   - Relationship validations for foreign keys

3. **Advanced Tests** (complex logic)
   - Singular tests with business rules
   - Cross-table consistency checks
   - Aggregate level validations

---

## 4. Running Tests

### Run All Tests

```bash
dbt test
```

Output:
```
Found 7 tests
1 of 7 START test not_null_yellow_taxi_raw_trip_id      [RUN]
...
Finished running 7 tests
Completed successfully
Done. PASS=7 WARN=0 ERROR=0
```

### Run Specific Tests

**Run single test**:
```bash
dbt test --select test_trip_duration_positive
```

**Run tests for specific model**:
```bash
dbt test --select yellow_taxi_raw
```

**Run specific test type** (generic tests):
```bash
dbt test --select amount_positive
```

### Run with Build Command

Build runs models AND tests:

```bash
# Run model + tests
dbt build -s yellow_taxi_raw

# Run entire project + tests
dbt build
```

### View Test Details

Get SQL of compiled test:

```bash
cat target/compiled/dbt_project/tests/test_trip_duration_positive.sql
```

---

## 5. Test Results Interpretation

### PASS Result

```
✓ PASS test_not_null_yellow_taxi_raw_trip_id [0.03s]
```

Meaning: Query returned 0 rows (no violations found)

---

### FAIL Result

```
✗ FAIL 226013 test_amount_positive_yellow_taxi_raw_fare_amount [0.05s]
```

Meaning: Query returned 226,013 rows (violations found)

**Next Steps**:
1. Check failing test SQL in `target/compiled/`
2. Query source data to identify issues
3. Fix data quality issues or adjust test expectations
4. Re-run test to verify fix

---

## 6. Project Test Summary

### Current Tests

| Test | Type | Model | Column | Status |
|------|------|-------|--------|--------|
| `not_null` | Built-in | yellow_taxi_raw | tpep_pickup_datetime | ✓ PASS |
| `accepted_values` | Built-in | yellow_taxi_raw | payment_type | ✓ PASS |
| `not_null` | Built-in | yellow_taxi_raw | fare_amount | ✓ PASS |
| `not_null` | Built-in | yellow_taxi_raw | total_amount | ✓ PASS |
| `amount_positive` | Generic | yellow_taxi_raw | fare_amount | ✗ FAIL |
| `amount_positive` | Generic | yellow_taxi_raw | total_amount | ✗ FAIL |
| `trip_duration_positive` | Singular | yellow_taxi_raw | N/A | ✗ FAIL |

### Failing Tests Analysis

**`amount_positive_fare_amount`**: 226,013 rows with fare_amount ≤ 0
- Action: Review source data quality or adjust business rules

**`amount_positive_total_amount`**: 134,698 rows with total_amount ≤ 0
- Action: Investigate why totals are negative (refunds? credits?)

**`trip_duration_positive`**: 1 row with duration ≤ 0
- Action: Review the specific trip record, likely data entry error

---

## 7. Testing Best Practices

### ✓ DO

- Write tests for all critical business logic
- Name tests descriptively
- Document complex test logic with comments
- Test both positive and negative cases
- Run tests before committing
- Create generic tests for reusable logic
- Use `ref()` in test SQL for model references
- Include tests in code reviews

### ✗ DON'T

- Skip tests to speed up development
- Write overly complex singular tests
- Create generic tests for single-use logic
- Ignore failing tests
- Commit models without tests
- Test implementation details (only test data quality)
- Write tests that are too strict (catch false positives)

---

## 8. Test Development Workflow

### Step 1: Identify Test Needs

```sql
-- Analyze data to understand requirements
select
    count(*),
    min(fare_amount),
    max(fare_amount),
    count(case when fare_amount <= 0 then 1 end) as negative_fares
from {{ ref('yellow_taxi_raw') }}
```

### Step 2: Write Test

```yaml
# schema.yml
columns:
  - name: fare_amount
    tests:
      - not_null
      - amount_positive
```

### Step 3: Run Test

```bash
dbt test -s yellow_taxi_raw
```

### Step 4: Review Results

```bash
# Check compiled SQL
cat target/compiled/dbt_project/tests/amount_positive_yellow_taxi_raw_fare_amount.sql
```

### Step 5: Fix Issues or Adjust

- If data has issues: Fix upstream source
- If test is too strict: Adjust expectations
- If test is correct: Document findings

### Step 6: Commit

```bash
git add models/schema.yml
git commit -m "test(yellow_taxi): Add fare_amount positive validation"
```

---

## 9. Resources

- [dbt Testing Docs](https://docs.getdbt.com/docs/build/tests)
- [dbt Test Properties](https://docs.getdbt.com/reference/resource-properties/tests)
- [dbt Generic Tests](https://docs.getdbt.com/docs/build/custom-tests)

---

**Last Updated**: December 29, 2025
**Version**: 1.0
