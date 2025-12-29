# dbt Seed Process - Understanding the Commands

This document explains what commands are executed when you run `dbt seed` to load CSV data into your database.

---

## Command Execution Flow

When you run `dbt seed`, dbt executes a series of steps to load seed data:

### 1. **Initialization Phase**

```
dbt seed [options]
```

dbt performs these startup tasks:
- Load project configuration from `dbt_project.yml`
- Parse profiles from `profiles.yml` to get database connection
- Initialize adapter (DuckDB in this case)
- Register database connection

**Example Output:**
```
Running with dbt=1.11.2
Registered adapter: duckdb=1.10.0
Found 2 models, 8 data tests, 1 seed, 1 source, 473 macros
```

---

### 2. **Discovery Phase**

dbt scans the `seeds/` folder for all CSV files:

```sql
-- dbt queries the database to check existing seed tables
SELECT
    'duckdb' as database,
    table_name as name,
    table_schema as schema,
    CASE table_type
        WHEN 'BASE TABLE' THEN 'table'
        WHEN 'VIEW' THEN 'view'
        WHEN 'LOCAL TEMPORARY' THEN 'table'
    END as type
FROM system.information_schema.tables
WHERE lower(table_schema) = 'main'
  AND lower(table_catalog) = 'duckdb'
```

This checks if the seed table already exists.

---

### 3. **Schema Parsing Phase**

dbt reads `seeds/schema.yml` to:
- Understand seed table structure
- Get column names and data types
- Identify tests to run

**From our schema.yml:**
```yaml
seeds:
  - name: zipcodes_us
    description: United States zipcodes reference data
    columns:
      - name: country_code
        data_type: varchar
      - name: latitude
        data_type: double
      # ... more columns
```

---

### 4. **Table Creation/Drop Phase**

dbt checks if the seed table exists and drops it if it needs to reload:

```sql
-- If table exists, drop it to reload fresh data
DROP TABLE IF EXISTS main.zipcodes_us
```

---

### 5. **Data Loading Phase** ⭐ **Main Step**

dbt reads the CSV file and inserts data. The actual mechanism depends on the adapter:

**For DuckDB (our setup):**

```sql
-- DuckDB uses COPY/INSERT with CSV reader
INSERT INTO main.zipcodes_us
SELECT * FROM read_csv_auto('seeds/zipcodes.us.csv')
```

**Equivalent steps:**

1. **Create table** based on CSV structure:
```sql
CREATE TABLE main.zipcodes_us (
    country_code VARCHAR,
    zipcode VARCHAR,
    place VARCHAR,
    state VARCHAR,
    state_code VARCHAR,
    province VARCHAR,
    province_code VARCHAR,
    community VARCHAR,
    community_code VARCHAR,
    latitude DOUBLE,
    longitude DOUBLE
)
```

2. **Load data from CSV**:
```sql
INSERT INTO main.zipcodes_us
SELECT * FROM read_csv_auto('seeds/zipcodes.us.csv')
```

Or using DuckDB's efficient COPY command:

```sql
COPY main.zipcodes_us FROM 'seeds/zipcodes.us.csv' (FORMAT CSV, HEADER TRUE)
```

---

### 6. **Test Execution Phase** (Optional)

After loading, dbt can run tests defined in `schema.yml`:

```sql
-- Test: not_null on country_code
SELECT COUNT(*)
FROM main.zipcodes_us
WHERE country_code IS NULL

-- Test: unique on zipcode
SELECT zipcode, COUNT(*)
FROM main.zipcodes_us
GROUP BY zipcode
HAVING COUNT(*) > 1
```

---

### 7. **Commit Phase**

dbt commits the transaction:

```sql
BEGIN
  -- All operations happen here
  -- If successful: COMMIT
COMMIT

-- If any error: ROLLBACK
```

---

## Log Output Interpretation

When you run `dbt seed`, you see output like:

```
1 of 1 START seed file main.zipcodes.us ..................... [RUN]
1 of 1 OK loaded seed file main.zipcodes.us .................. [INSERT 41483] in 0.82s
```

**Breaking this down:**
- `1 of 1` - Seed 1 of 1 total seeds
- `START seed file` - Starting to load seed
- `main.zipcodes.us` - Table name
- `OK loaded` - Successfully loaded
- `[INSERT 41483]` - Inserted 41,483 rows
- `in 0.82s` - Took 0.82 seconds

---

## Complete dbt seed Workflow

```
┌─────────────────────────────────┐
│  dbt seed                       │
│ (reads CSV files)               │
└──────────────┬──────────────────┘
               │
               ▼
┌─────────────────────────────────┐
│ Parse seeds/schema.yml          │
│ (get table structure)           │
└──────────────┬──────────────────┘
               │
               ▼
┌─────────────────────────────────┐
│ Query database for existing     │
│ seed tables                      │
└──────────────┬──────────────────┘
               │
               ▼
┌─────────────────────────────────┐
│ Drop old table if exists        │
│ DROP TABLE IF EXISTS            │
└──────────────┬──────────────────┘
               │
               ▼
┌─────────────────────────────────┐
│ Create new table                │
│ CREATE TABLE main.zipcodes_us   │
└──────────────┬──────────────────┘
               │
               ▼
┌─────────────────────────────────┐
│ Insert data from CSV            │
│ COPY FROM or INSERT ... SELECT  │
│ ✓ 41,483 rows loaded            │
└──────────────┬──────────────────┘
               │
               ▼
┌─────────────────────────────────┐
│ Run tests (if defined)          │
│ not_null, unique, etc.          │
└──────────────┬──────────────────┘
               │
               ▼
┌─────────────────────────────────┐
│ COMMIT transaction              │
│ ✓ Success                       │
└─────────────────────────────────┘
```

---

## Key Commands Summary

| Command | Purpose | SQL Generated |
|---------|---------|---|
| `dbt seed` | Load all CSV seeds | `COPY FROM` / `INSERT INTO SELECT` |
| `dbt seed -s zipcodes_us` | Load specific seed | Same, but only for zipcodes_us |
| `dbt seed --full-refresh` | Force reload, drop old tables | `DROP TABLE IF EXISTS` + `INSERT` |
| `dbt seed --show` | Show seed data after loading | `SELECT * FROM seed_table` |

---

## For Our Project

**When you ran:**
```bash
source ../dbt_env/bin/activate && dbt seed
```

**These commands were executed in order:**

1. ✅ Connect to DuckDB
2. ✅ Query information_schema to check if `main.zipcodes_us` exists
3. ✅ Drop existing table (if any) to force fresh load
4. ✅ Create `main.zipcodes_us` table with 11 columns
5. ✅ Execute: `INSERT INTO main.zipcodes_us SELECT * FROM read_csv_auto('seeds/zipcodes.us.csv')`
6. ✅ Result: **41,483 rows inserted in 0.82 seconds**
7. ✅ COMMIT transaction

---

## Understanding Your CSV Load

**File:** `seeds/zipcodes.us.csv`
- **Size:** 2.7 MB
- **Rows:** 41,483
- **Columns:** 11
- **Format:** CSV with header row

**Table Created:** `main.zipcodes_us`
- Location: DuckDB database (in-memory or file-based)
- Type: Permanent table
- Schema: main

---

## Important Notes

1. **Idempotent**: Running `dbt seed` multiple times with same CSV produces same result
2. **Full Refresh**: By default, dbt drops and recreates the table each time
3. **Incremental**: You can configure seeds to append instead of replace (rarely used)
4. **Transaction Safe**: All operations are atomic (all-or-nothing)
5. **Fast**: DuckDB's CSV reading is highly optimized

---

## Troubleshooting

| Issue | Cause | Solution |
|-------|-------|----------|
| "Could not set lock" | Database file locked by another process | Close DBeaver or other DB tools |
| "Column type mismatch" | CSV values don't match data_type | Check data_type in schema.yml |
| Seed not loading | CSV file not found | Verify file is in `seeds/` folder |
| Wrong row count | CSV encoding issue | Save CSV as UTF-8 |

---

**Last Updated:** December 29, 2025
