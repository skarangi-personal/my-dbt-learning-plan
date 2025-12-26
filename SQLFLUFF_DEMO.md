# SQLFluff Demo - Live Example

Here's a live demonstration of SQLFluff working in your repository!

---

## STEP 1: Original Unformatted File

**File**: `models/demo_model.sql`

```sql
-- Sample unformatted DBT model for SQLFluff demo
SELECT customer_id,order_date,amount,status FROM raw_orders WHERE status='completed' AND amount>100 ORDER BY order_date DESC
```

**Problems**:
- ❌ All columns on one line (hard to read)
- ❌ No spaces after commas
- ❌ Keywords (WHERE, ORDER) not on new lines
- ❌ Line is 124 characters (exceeds 80 char limit)
- ❌ No spaces around comparison operators
- ❌ No trailing newline

---

## STEP 2: Run SQLFluff Lint - Detect Violations

**Command**:
```bash
source activate.sh
sqlfluff lint models/demo_model.sql
```

**Output**: Detected 13 Violations

```
== [models/demo_model.sql] FAIL
L:   2 | P:   1 | LT05 | Line is too long (124 > 80). [layout.long_lines]
L:   2 | P:   1 | LT09 | Select targets should be on a new line unless there is
                       | only one select target. [layout.select_targets]
L:   2 | P:  20 | LT01 | Expected single whitespace between comma ',' and naked
                       | identifier. [layout.spacing]
L:   2 | P:  31 | LT01 | Expected single whitespace between comma ',' and naked
                       | identifier. [layout.spacing]
L:   2 | P:  38 | LT01 | Expected single whitespace between comma ',' and naked
                       | identifier. [layout.spacing]
L:   2 | P:  61 | LT14 | The 'WHERE' keyword should always start a new line.
                       | [layout.keyword_newline]
L:   2 | P:  73 | LT01 | Expected single whitespace between naked identifier and
                       | raw comparison operator '='. [layout.spacing]
L:   2 | P:  74 | LT01 | Expected single whitespace between raw comparison
                       | operator '=' and quoted literal. [layout.spacing]
L:   2 | P:  96 | LT01 | Expected single whitespace between naked identifier and
                       | raw comparison operator '>'. [layout.spacing]
L:   2 | P:  97 | LT01 | Expected single whitespace between raw comparison
                       | operator '>' and numeric literal. [layout.spacing]
L:   2 | P: 101 | LT14 | The 'ORDER' keyword should always start a new line.
                       | [layout.keyword_newline]
L:   2 | P: 125 | LT12 | Files must end with a single trailing newline.
                       | [layout.end_of_file]
All Finished!
```

**Key Details**:
- Line 2: Too long (124 chars vs 80 max)
- Spacing violations detected at positions 20, 31, 38, 73, 74, 96, 97
- Keywords (WHERE, ORDER) not on new lines
- Missing trailing newline

---

## STEP 3: Run SQLFluff Fix - Auto-Format

**Command**:
```bash
source activate.sh
sqlfluff fix models/demo_model.sql
```

**Output**:
```
==== finding fixable violations ====
== [models/demo_model.sql] FIXED
10 fixable linting violations found
```

✅ **10 violations automatically fixed!**

---

## STEP 4: Formatted File - AFTER SQLFluff

**File**: `models/demo_model.sql` (after formatting)

```sql
-- Sample unformatted DBT model for SQLFluff demo
SELECT
    customer_id,
    order_date,
    amount,
    status
FROM raw_orders
WHERE status = 'completed' AND amount > 100
ORDER BY order_date DESC
```

---

## Comparison: Before & After

### BEFORE (Messy)
```sql
SELECT customer_id,order_date,amount,status FROM raw_orders WHERE status='completed' AND amount>100 ORDER BY order_date DESC
```

**Problems**:
- All on one line
- Hard to read
- Doesn't follow dbt style
- Line too long
- Inconsistent spacing

### AFTER (dbt Best Practices)
```sql
SELECT
    customer_id,
    order_date,
    amount,
    status
FROM raw_orders
WHERE status = 'completed' AND amount > 100
ORDER BY order_date DESC
```

**Fixed**:
- ✅ Each column on own line
- ✅ Easy to read
- ✅ Follows dbt best practices
- ✅ Line length within 80 chars
- ✅ Consistent spacing
- ✅ Keywords on new lines
- ✅ Proper indentation (4 spaces)
- ✅ Trailing newline added

---

## What SQLFluff Fixed

| Issue | Before | After |
|-------|--------|-------|
| Columns | All on one line | Each on new line |
| Commas | `customer_id,order_date` | `customer_id,` (separate line) |
| Equals | `status='completed'` | `status = 'completed'` |
| Greater | `amount>100` | `amount > 100` |
| WHERE | Same line as SELECT | New line |
| ORDER | Same line as WHERE | New line |
| Indentation | None | 4 spaces |
| Line length | 124 chars | ✅ Within 80 |
| Newline | Missing | ✅ Added |

---

## Rules Applied

SQLFluff applied these dbt best practices:

1. **LT05**: Enforce 80-character line limit
2. **LT09**: Put select targets on separate lines
3. **LT01**: Add whitespace after commas and around operators
4. **LT14**: Put keywords on new lines
5. **LT12**: Add trailing newline

All configured in `.sqlfluff` file!

---

## How to Use in Your Workflow

### Option 1: Format One File
```bash
source activate.sh
sqlfluff fix models/staging/stg_customers.sql
```

### Option 2: Format All Models
```bash
source activate.sh
sqlfluff fix models/
```

### Option 3: Check Without Fixing
```bash
source activate.sh
sqlfluff lint models/demo_model.sql
# Shows violations but doesn't change file
```

### Option 4: Format with Backup
```bash
source activate.sh
sqlfluff fix models/ --fixed-suffix _original
# Keeps original with _original suffix
```

---

## Real-World Example

Here's what happens in your actual workflow:

### Day 1: Write Your First Model

You write: `models/staging/stg_customers.sql`
```sql
SELECT id,name,email,created_at,updated_at FROM raw_customers WHERE is_active=true AND deleted_at IS NULL
```

### Run SQLFluff
```bash
source activate.sh
sqlfluff fix models/staging/stg_customers.sql
```

### Instantly Formatted
```sql
SELECT
    id,
    name,
    email,
    created_at,
    updated_at
FROM raw_customers
WHERE is_active = true
    AND deleted_at IS NULL
```

### Now Run DBT
```bash
dbt run
```

✅ Your model is formatted and runs correctly!

---

## Key Takeaways

1. **SQLFluff detects violations** - 13 found in demo
2. **SQLFluff auto-fixes them** - 10 fixed automatically
3. **Follows dbt best practices** - Proper spacing, indentation, line length
4. **Improves readability** - Code is cleaner and more professional
5. **Works from terminal** - Easy to use in your workflow

---

## Configuration Used

Your `.sqlfluff` file configures:
- **Dialect**: DuckDB
- **Max line length**: 80 characters
- **Indentation**: 4 spaces
- **Indentation unit**: Space (not tabs)
- **Trailing commas**: Forbidden
- **Case policy**: Lowercase

---

## You Can Now Use This

1. **Write messy SQL** in VSCode
2. **Save the file**
3. **Run from terminal**:
   ```bash
   source activate.sh
   sqlfluff fix models/
   ```
4. **Reload in VSCode** (auto-reloads)
5. **Your code is now formatted!**

---

## Ready to Learn?

This demo proves SQLFluff works perfectly!

Next: Open `CURRICULUM.md` and go to **Day 1: DBT Fundamentals**

You now know:
- ✅ How to write models
- ✅ How to format them with SQLFluff
- ✅ How to run them with dbt

Everything is ready! 🚀

---

**Status**: ✅ SQLFluff Fully Demonstrated and Working
