# DBT Setup Guide with VSCode IDE

Complete step-by-step guide to set up DBT locally with VSCode, based on dbt community recommendations.

---

## Prerequisites

- **Python**: 3.8+ (you have 3.11.9) ✓
- **pip**: Python package manager
- **VSCode**: Code editor
- **Git**: Version control (already installed)
- **Data Warehouse**: Choose one (DuckDB recommended for learning)

---

## Step 1: Create Virtual Environment

Virtual environments isolate DBT dependencies from your system Python.

```bash
# Create virtual environment
python3 -m venv dbt_env

# Activate it
source dbt_env/bin/activate

# Verify activation (you should see (dbt_env) in terminal)
which python
```

---

## Step 2: Install DBT Core

Choose your database adapter:

### Option A: DuckDB (Recommended for Learning)
```bash
pip install dbt-duckdb
```

### Option B: PostgreSQL
```bash
pip install dbt-postgres
```

### Option C: Snowflake
```bash
pip install dbt-snowflake
```

### Option D: BigQuery
```bash
pip install dbt-bigquery
```

Then verify installation:
```bash
dbt --version
```

---

## Step 3: Initialize DBT Project

```bash
# Navigate to your project directory
cd /Users/skarangi/projects/trainings/my-dbt-learning-plan

# Initialize DBT (creates dbt_project.yml and profiles.yml)
dbt init my_dbt_project

# Navigate into project
cd my_dbt_project

# Test connection
dbt debug
```

---

## Step 4: Configure VSCode

### 4.1 Install DBT Extension

1. Open VSCode
2. Go to Extensions (Cmd+Shift+X)
3. Search for "dbt"
4. Install **"DBT Power User"** or **"dbt for Visual Studio Code"**

### 4.2 Configure File Navigation

Add this to `.vscode/settings.json` to jump between models and compiled SQL:

```json
{
  "dbt.pathMatcher": "'^(.*/)?models/(.*/)?(.+\\.sql)$': ['**/compiled/**/$3'], '^(.*/)?compiled/(.*/)?(.+\\.sql)$': ['**/models/**/$3']"
}
```

Or manually add to VSCode settings:
1. Cmd+Shift+P → "Preferences: Open Settings (JSON)"
2. Add the pathMatcher configuration above

### 4.3 VSCode Extensions (Optional but Recommended)

- **DBT Power User** (official)
- **SQL Tools** (for SQL syntax highlighting)
- **GitLens** (for git integration)
- **YAML** (for YAML syntax)
- **Thunder Client** (for API testing)

---

## Step 5: Set Up Your First Project

### 5.1 Project Structure

```bash
my_dbt_project/
├── dbt_project.yml          # Project configuration
├── profiles.yml             # Database credentials
├── models/
│   ├── staging/            # Raw data transformations
│   ├── intermediate/       # Business logic
│   └── marts/              # Final outputs
├── tests/                  # Data quality tests
├── macros/                 # Reusable SQL code
├── snapshots/              # Historical data (SCD Type 2)
├── seeds/                  # Reference data (CSV)
└── docs/                   # Documentation
```

### 5.2 Update dbt_project.yml

Edit `dbt_project.yml` to match your structure:

```yaml
name: 'my_first_dbt_project'
version: '1.0.0'
config-version: 2

profile: 'default'

model-paths: ["models"]
analysis-paths: ["analyses"]
test-paths: ["tests"]
data-paths: ["data"]
macro-paths: ["macros"]
snapshot-paths: ["snapshots"]
target-path: "target"
clean-targets:
  - "target"
  - "dbt_packages"

models:
  my_first_dbt_project:
    staging:
      +materialized: ephemeral
    intermediate:
      +materialized: ephemeral
    marts:
      +materialized: table
```

### 5.3 Create First Model

Create `models/staging/stg_example.sql`:

```sql
SELECT
  id,
  name,
  created_at
FROM {{ source('raw_data', 'example_table') }}
LIMIT 100
```

### 5.4 Define Sources

Create `models/sources.yml`:

```yaml
version: 2

sources:
  - name: raw_data
    description: Raw source data
    database: duckdb_database
    schema: main
    tables:
      - name: example_table
        description: Example table from source
```

---

## Step 6: Run DBT Commands

```bash
# Parse project (check for errors)
dbt parse

# Run all models
dbt run

# Run specific model
dbt run --select stg_example

# Test data quality
dbt test

# Generate documentation
dbt docs generate
dbt docs serve
# Open http://localhost:8000
```

---

## Step 7: Configure for DuckDB (Recommended)

### profiles.yml Configuration

```yaml
default:
  target: dev
  outputs:
    dev:
      type: duckdb
      path: /Users/skarangi/projects/trainings/my-dbt-learning-plan/my_dbt_project/duckdb.duckdb
      schema: main
      threads: 4
      timeout_seconds: 300
      
    prod:
      type: duckdb
      path: /Users/skarangi/projects/trainings/my-dbt-learning-plan/my_dbt_project/duckdb_prod.duckdb
      schema: main
      threads: 4
```

Then verify:
```bash
dbt debug
```

---

## Step 8: VSCode Workflow Tips

### 8.1 Command Palette Shortcuts

```
Cmd+Shift+P + "dbt"
- dbt: run
- dbt: test
- dbt: docs generate
- dbt: compile
- dbt: parse
```

### 8.2 File Navigation

- Cmd+Click on `{{ ref('model_name') }}` → Jump to model
- Cmd+Click on `{{ source('source', 'table') }}` → Jump to source definition
- With pathMatcher configured, jump between models and compiled SQL

### 8.3 Useful VSCode Settings

Add to `.vscode/settings.json`:

```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "[sql]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "search.exclude": {
    "**/target": true,
    "**/dbt_packages": true
  },
  "dbt.requestTimeout": 60
}
```

---

## Step 9: First Project Workflow

### 9.1 Create Model File

1. Open VSCode to your DBT project
2. Create new file: `models/marts/my_first_model.sql`
3. Write SQL:

```sql
{{ config(materialized='table') }}

SELECT
  id,
  name,
  created_at
FROM {{ ref('stg_example') }}
```

### 9.2 Run and Test

```bash
# Parse to check syntax
dbt parse

# Compile SQL
dbt compile

# Run the model
dbt run --select my_first_model

# View compiled SQL (in target/compiled/)
```

### 9.3 Add Tests

Create `models/marts/schema.yml`:

```yaml
version: 2

models:
  - name: my_first_model
    description: My first DBT model
    columns:
      - name: id
        description: Primary key
        tests:
          - not_null
          - unique
      - name: name
        tests:
          - not_null
```

Run tests:
```bash
dbt test
```

---

## Step 10: Git Integration

### 10.1 Add .gitignore

Create `.gitignore` in your DBT project:

```
# DBT
target/
dbt_packages/
logs/

# Python
__pycache__/
*.pyc
venv/
dbt_env/

# Editor
.DS_Store
.vscode/

# Credentials
profiles.yml
.env

# Database
*.duckdb
*.db
```

### 10.2 Commit Project

```bash
git add .
git commit -m "Initialize DBT project with DuckDB"
git push origin main
```

---

## Troubleshooting

### Issue: "dbt command not found"
**Solution**: Activate virtual environment
```bash
source dbt_env/bin/activate
```

### Issue: "dbt debug fails"
**Solution**: Check profiles.yml
```bash
cat ~/.dbt/profiles.yml
dbt debug --profiles-dir ~/.dbt/
```

### Issue: "Module not found" error
**Solution**: Reinstall dependencies
```bash
pip install --upgrade dbt-duckdb
```

### Issue: VSCode extension not showing autocomplete
**Solution**: 
1. Restart VSCode
2. Ensure DBT project has dbt_project.yml
3. Run `dbt parse` first

---

## Next Steps

1. ✓ Set up virtual environment
2. ✓ Install DBT with database adapter
3. ✓ Initialize DBT project
4. ✓ Configure VSCode with DBT extension
5. ✓ Create first model and test
6. → Open `CURRICULUM.md` Day 1 to start learning
7. → Follow the 10-day curriculum with hands-on projects

---

## Quick Reference Commands

```bash
# Activate environment
source dbt_env/bin/activate

# Parse project
dbt parse

# Run all models
dbt run

# Run specific model
dbt run --select model_name

# Full refresh
dbt run --full-refresh

# Run tests
dbt test

# Generate docs
dbt docs generate && dbt docs serve

# Check lineage
dbt docs serve # Visit localhost:8000

# Debug connection
dbt debug
```

---

## Resources

- **dbt Documentation**: https://docs.getdbt.com
- **DuckDB Documentation**: https://duckdb.org/docs
- **VSCode DBT Extension**: Search "DBT Power User"
- **dbt Learn**: https://learn.getdbt.com

---

*Setup complete! You're ready to start the 10-day curriculum.*

