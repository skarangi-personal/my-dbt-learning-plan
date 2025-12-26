# Quick SQLFluff Commands - Copy & Paste

**All working commands for your project**

---

## Required Setup (Do This Once)

```bash
cd /Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_project
source ../activate.sh
```

---

## All Commands

### 1. Lint (Check for violations)
```bash
sqlfluff lint models/demo_model.sql --dialect duckdb
```

### 2. Fix (Auto-format)
```bash
sqlfluff fix models/demo_model.sql --dialect duckdb
```

### 3. Format All Models
```bash
sqlfluff fix models/ --dialect duckdb
```

### 4. Check All Models
```bash
sqlfluff lint models/ --dialect duckdb
```

### 5. Format Staging Models Only
```bash
sqlfluff fix models/staging/ --dialect duckdb
```

### 6. Format and View Result
```bash
sqlfluff fix models/demo_model.sql --dialect duckdb && cat models/demo_model.sql
```

### 7. Full Workflow (Format then Run DBT)
```bash
sqlfluff fix models/ --dialect duckdb && dbt run
```

### 8. Check Before Committing
```bash
sqlfluff lint models/ --dialect duckdb && git status
```

---

## One-Line Demo (Copy & Paste)

```bash
cd /Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_project && source ../activate.sh && echo "BEFORE:" && cat models/demo_model.sql && echo "" && echo "FIXING..." && sqlfluff fix models/demo_model.sql --dialect duckdb && echo "" && echo "AFTER:" && cat models/demo_model.sql
```

---

## VSCode Terminal Workflow

```bash
# 1. Open terminal: Ctrl + `
# 2. Copy & paste this:

source ../activate.sh

# 3. Run this to see demo:
sqlfluff lint models/demo_model.sql --dialect duckdb

# 4. Run this to format:
sqlfluff fix models/demo_model.sql --dialect duckdb

# 5. Run this to see result:
cat models/demo_model.sql
```

---

## For Your Own Models

Replace `demo_model.sql` with your filename:

```bash
sqlfluff lint models/your_model_name.sql --dialect duckdb
sqlfluff fix models/your_model_name.sql --dialect duckdb
```

---

## Key Pattern

**Always add**: `--dialect duckdb`

✅ **Correct**:
```bash
sqlfluff fix models/ --dialect duckdb
```

❌ **Won't work**:
```bash
sqlfluff fix models/
```

---

**That's it! Copy-paste any command above and run it!**
