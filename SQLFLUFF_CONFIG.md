# SQLFluff Configuration for dbt

Complete SQLFluff setup aligned with dbt's SQL styling best practices.

Based on: https://docs.getdbt.com/best-practices/how-we-style/2-how-we-style-our-sql

---

## Overview

SQLFluff is a linter and formatter for SQL that helps maintain consistent code style. We've configured it to match dbt's recommended SQL styling guide.

---

## What's Been Configured

A `.sqlfluff` file has been created in your `dbt_project/` folder with these settings:

### Core Settings
- **Dialect**: DuckDB (matches your database)
- **Max Line Length**: 80 characters
- **Indent**: 4 spaces
- **Indentation Unit**: Space (not tabs)

---

## dbt SQL Styling Rules Implemented

### 1. **Indentation: 4 Spaces**
```sql
-- ✅ Good
SELECT
    customer_id,
    order_amount
FROM {{ ref('orders') }}

-- ❌ Bad
SELECT
  customer_id,
  order_amount
FROM {{ ref('orders') }}
```

### 2. **Line Length: 80 Characters Max**
```sql
-- ✅ Good (fits in 80 chars)
SELECT customer_id, order_date, amount
FROM {{ ref('orders') }}

-- ❌ Bad (exceeds 80 chars)
SELECT customer_id, order_date, amount, payment_method, shipping_address FROM {{ ref('orders') }}
```

### 3. **Lowercase Everything**
```sql
-- ✅ Good
select
    customer_id,
    count(*) as order_count
from {{ ref('orders') }}
group by customer_id

-- ❌ Bad
SELECT
    CUSTOMER_ID,
    COUNT(*) AS ORDER_COUNT
FROM {{ ref('orders') }}
GROUP BY CUSTOMER_ID
```

### 4. **Trailing Commas**
```sql
-- ✅ Good (comma after last item in list)
select
    customer_id,
    order_date,
    amount,
from {{ ref('orders') }}

-- ❌ Bad (no comma after last item)
select
    customer_id,
    order_date,
    amount
from {{ ref('orders') }}
```

### 5. **Explicit AS for Aliases**
```sql
-- ✅ Good
select
    customer_id as id,
    order_date as date
from {{ ref('orders') }} as o

-- ❌ Bad
select
    customer_id id,
    order_date date
from {{ ref('orders') }} o
```

### 6. **Always Prefix Column Names in Joins**
```sql
-- ✅ Good
select
    o.order_id,
    c.customer_name,
    o.order_date
from {{ ref('orders') }} as o
left join {{ ref('customers') }} as c
    on o.customer_id = c.customer_id

-- ❌ Bad
select
    order_id,
    customer_name,
    order_date
from {{ ref('orders') }} as o
left join {{ ref('customers') }} as c
    on o.customer_id = c.customer_id
```

### 7. **Ref Statements at Top in CTEs**
```sql
-- ✅ Good
with orders as (
    select * from {{ ref('orders') }}
),
customers as (
    select * from {{ ref('customers') }}
)
select
    o.order_id,
    c.customer_name
from orders as o
left join customers as c
    on o.customer_id = c.customer_id

-- ❌ Bad
select
    o.order_id,
    c.customer_name
from {{ ref('orders') }} as o
left join {{ ref('customers') }} as c
    on o.customer_id = c.customer_id
```

### 8. **Prefer UNION ALL Over UNION**
```sql
-- ✅ Good
select customer_id from orders_2023
union all
select customer_id from orders_2024

-- ❌ Bad
select customer_id from orders_2023
union
select customer_id from orders_2024
```

### 9. **Jinja Comments for Compiled SQL**
```sql
-- ✅ Good (Jinja comment - not in compiled SQL)
{# Note: This is a comment that won't appear in compiled SQL #}
select
    customer_id,
    order_date
from {{ ref('orders') }}

-- ⚠️ Regular comment (appears in compiled SQL)
-- This comment will appear in compiled SQL
select
    customer_id,
    order_date
from {{ ref('orders') }}
```

### 10. **Fields Before Aggregates**
```sql
-- ✅ Good
select
    customer_id,
    order_date,
    count(*) as order_count,
    sum(amount) as total_amount
from {{ ref('orders') }}
group by customer_id, order_date

-- ❌ Bad
select
    count(*) as order_count,
    sum(amount) as total_amount,
    customer_id,
    order_date
from {{ ref('orders') }}
group by customer_id, order_date
```

### 11. **IS NULL, Not = NULL**
```sql
-- ✅ Good
where status is null

-- ❌ Bad
where status = null
```

### 12. **Use != Not <>**
```sql
-- ✅ Good
where status != 'cancelled'

-- ❌ Bad
where status <> 'cancelled'
```

---

## Using SQLFluff in VSCode

### Automatic Formatting (On Save)

When you save a `.sql` file, SQLFluff automatically formats it:

1. Create or edit any model file: `models/staging/stg_example.sql`
2. Write your SQL (in any style)
3. **Save the file** (Cmd+S)
4. Watch it auto-format to dbt style!

### Manual Formatting

You can also manually format:

1. Write your SQL
2. Press: `Cmd+K Cmd+F` (Format Document)
3. SQLFluff reformats your code

### Linting (Error Detection)

As you type, SQLFluff shows:
- ❌ Red squiggles for style violations
- ⚠️ Yellow warnings for best practices

Hover over the squiggle to see the issue and quick fixes.

---

## Quick Reference: SQLFluff Commands

### View Violations
```bash
cd dbt_project
sqlfluff lint models/
```

### Auto-fix Issues
```bash
sqlfluff fix models/ --fixed-suffix _fixed
```

### Check Specific File
```bash
sqlfluff lint models/staging/stg_orders.sql
```

### Get Detailed Report
```bash
sqlfluff lint models/ -f human
```

---

## Configuration File Location

**File**: `dbt_project/.sqlfluff`

This file is:
- ✅ Checked into git (so others get the same config)
- ✅ Read by VSCode extension automatically
- ✅ Used when you run `sqlfluff` command
- ✅ Applied when you save files

---

## What Each Rule Does

| Rule | Purpose | dbt Setting |
|------|---------|-------------|
| L001 | Indentation | 4 spaces |
| L003 | Line length | 80 characters |
| L010 | Keywords case | Lowercase |
| L011 | Identifiers case | Lowercase |
| L030 | Function names case | Lowercase |
| L039 | Space before parenthesis | None |
| L040 | Trailing newline | None |
| L042 | Unused aliases | Forbid |
| L045 | NULL comparison | IS NULL |
| L051 | Aliases | Explicit AS |
| L054 | Table references | Explicit prefix |
| L061 | UNION preference | UNION ALL |
| L064 | NULL style | Consistent |

---

## Testing Your Setup

### Test 1: Auto-format on Save

1. Create: `models/test_format.sql`
2. Write unformatted SQL:
```sql
SELECT customer_id, order_date, amount FROM {{ ref('orders') }} WHERE status='active' GROUP BY customer_id, order_date
```

3. Save (Cmd+S)
4. Should format to:
```sql
select
    customer_id,
    order_date,
    amount,
from {{ ref('orders') }}
where status = 'active'
group by customer_id, order_date
```

### Test 2: Error Detection

1. Write: `where status = null`
2. You should see a red squiggle
3. Hover and see: "Null comparison should use IS NULL"

### Test 3: Complex Formatting

1. Write a complex multi-table join without proper formatting
2. Save
3. Watch it auto-format to dbt style with:
   - CTEs at top
   - Explicit aliases
   - Table prefixes
   - Proper indentation

---

## Troubleshooting

### "SQLFluff not working"
**Solution**:
1. Make sure SQLFluff extension is installed
2. Verify `.sqlfluff` file exists in `dbt_project/`
3. Restart VSCode (Cmd+Q then reopen)

### "Formatting doesn't match dbt style"
**Solution**:
1. Check `.sqlfluff` file exists
2. Verify `sqlfluff.dialect = duckdb` is set
3. Save file again (sometimes needs refresh)

### "Too strict for my taste"
**Solution**: You can modify `.sqlfluff` to be less strict:
```ini
# Comment out rules you don't like
# [sqlfluff:rules:L042]
# forbid_unused_aliases = true
```

### "Line length 80 too short"
**Solution**: Change in `.sqlfluff`:
```ini
[core]
max_line_length = 100  # or your preferred length
```

---

## Best Practices

### 1. Format As You Go
Don't wait until the end. Save frequently to catch issues early.

### 2. Use Jinja Comments for Internal Notes
```sql
{# TODO: This needs optimization #}
```

### 3. Trust the Formatter
If SQLFluff reformats your code differently than you wrote it, trust it. The style is intentional.

### 4. Review Violations Carefully
Some violations might be false positives. Review before ignoring.

### 5. Commit Formatted Code
Always commit formatted code to maintain consistency in your repository.

---

## SQLFluff + dbt Workflow

```
1. Write SQL model
         ↓
2. Save file (Cmd+S)
         ↓
3. SQLFluff auto-formats
         ↓
4. Review red squiggles (linting errors)
         ↓
5. Fix violations or hover for quick fix
         ↓
6. Save again
         ↓
7. Run dbt (dbt run)
         ↓
8. Commit formatted, tested code
```

---

## Configuration Details Explained

### Why These Settings?

**80 Character Lines**
- Readable on standard terminals and small screens
- Aligns with PEP 8 (Python standard)
- Prevents deeply nested queries

**4 Space Indentation**
- Industry standard
- Matches dbt's own code style
- Easier to read than 2 spaces

**Lowercase Everything**
- Consistency
- Easier to scan code
- dbt recommendation

**Trailing Commas**
- Easier to add new items
- Cleaner diffs in git
- Matches modern SQL style

**Explicit Aliases**
- Reduces ambiguity
- Required for complex joins
- dbt best practice

---

## Resources

- **SQLFluff Documentation**: https://docs.sqlfluff.com
- **dbt SQL Style Guide**: https://docs.getdbt.com/best-practices/how-we-style/2-how-we-style-our-sql
- **SQLFluff Rules Reference**: https://docs.sqlfluff.com/en/stable/reference/rules/index.html
- **SQLFluff VSCode Extension**: Via VSCode Extensions marketplace

---

## Next Steps

1. ✅ `.sqlfluff` file created
2. → Install SQLFluff VSCode extension (if not already)
3. → Create a test SQL file and save it
4. → Watch it auto-format!
5. → Start writing models with automatic formatting

---

**Your SQL code is now automatically styled to dbt best practices!** ✨

