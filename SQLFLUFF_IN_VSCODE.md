# How to Run SQLFluff from VSCode Terminal

Complete guide to running the SQLFluff demo from VSCode's integrated terminal.

---

## Step 1: Open VSCode with Project

```bash
code /Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_project
```

Or in terminal:
```bash
cd /Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_project
code .
```

---

## Step 2: Open VSCode Terminal

**Keyboard Shortcut**: `Ctrl + `` (backtick)

Or use menu: **Terminal → New Terminal**

You should see a terminal panel at the bottom of VSCode.

---

## Step 3: Activate the Virtual Environment

In the VSCode terminal, run:

```bash
source ../activate.sh
```

You should see:
```
🚀 Activating DBT environment...
✅ Environment activated!

Available commands:
  dbt debug
  dbt parse
  dbt run
  ...
```

---

## Step 4: View the Demo File

```bash
cat models/demo_model.sql
```

You should see the unformatted SQL:
```sql
-- Sample unformatted DBT model for SQLFluff demo
SELECT customer_id,order_date,amount,status FROM raw_orders WHERE status='completed' AND amount>100 ORDER BY order_date DESC
```

---

## Step 5: Run SQLFluff Lint

Check for violations:

```bash
sqlfluff lint models/demo_model.sql
```

**Output** (you should see):
```
== [models/demo_model.sql] FAIL
L:   2 | P:   1 | LT05 | Line is too long (124 > 80)
L:   2 | P:   1 | LT09 | Select targets should be on a new line
L:   2 | P:  20 | LT01 | Expected single whitespace between comma
...
All Finished!
```

**This shows 13 violations detected!** ✅

---

## Step 6: Run SQLFluff Fix

Auto-format the file:

```bash
sqlfluff fix models/demo_model.sql
```

**Output** (you should see):
```
==== finding fixable violations ====
== [models/demo_model.sql] FIXED
10 fixable linting violations found
```

**10 violations automatically fixed!** ✅

---

## Step 7: View the Formatted File

See the result:

```bash
cat models/demo_model.sql
```

**Output** (formatted nicely):
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

✅ **Perfect dbt formatting!**

---

## Step 8: Reload in VSCode Editor

If you have the file open in VSCode:

1. Click on `models/demo_model.sql` in the file explorer
2. VSCode will ask: **"File has changed on disk"**
3. Click **"Reload"** to see the formatted version
4. Now you can see the formatted code in the editor!

---

## Complete Terminal Session

Here's the full terminal session all at once:

```bash
# 1. Activate environment
source ../activate.sh

# 2. View original file
echo "=== BEFORE ==="
cat models/demo_model.sql

# 3. Check for violations
echo ""
echo "=== VIOLATIONS (13 found) ==="
sqlfluff lint models/demo_model.sql

# 4. Auto-fix
echo ""
echo "=== FIXING... ==="
sqlfluff fix models/demo_model.sql

# 5. View formatted file
echo ""
echo "=== AFTER (Fixed!) ==="
cat models/demo_model.sql
```

Copy this entire block and paste it into VSCode terminal to see the full demo!

---

## Your Complete Workflow in VSCode

### 1. Create a New Model File

**In VSCode**:
- Click **File → New File**
- Save as: `models/my_first_model.sql`
- Write unformatted SQL:

```sql
SELECT id,name,email,created_at FROM customers WHERE is_active=true AND status='completed'
```

### 2. Open Terminal

- Press: `Ctrl + `` (backtick)
- Run: `source ../activate.sh`

### 3. Format Your Code

```bash
sqlfluff fix models/my_first_model.sql
```

### 4. Reload File in Editor

- VSCode shows: "File has changed on disk"
- Click: **Reload**
- See formatted code!

### 5. Result

Your code is now formatted to dbt best practices!

---

## Useful VSCode Terminal Commands

### Format all models
```bash
sqlfluff fix models/
```

### Format one file
```bash
sqlfluff fix models/staging/stg_customers.sql
```

### Check violations
```bash
sqlfluff lint models/
```

### Format and show what changed
```bash
sqlfluff fix models/demo_model.sql && cat models/demo_model.sql
```

### Run dbt after formatting
```bash
sqlfluff fix models/
dbt run
```

---

## Pro Tips

### Tip 1: Format Before Running DBT
```bash
# Always format first, then run
sqlfluff fix models/
dbt run
```

### Tip 2: Create a Format Script
Create file: `format.sh`
```bash
#!/bin/bash
source ../activate.sh
sqlfluff fix models/
echo "✅ All models formatted!"
```

Then run:
```bash
chmod +x format.sh
./format.sh
```

### Tip 3: Format on Save (Manual)
After editing in VSCode:
1. Save file (Cmd+S)
2. Open terminal (Ctrl+`)
3. Run: `sqlfluff fix models/filename.sql`
4. Reload file in VSCode

### Tip 4: Check Before Commit
```bash
# Before committing to git:
sqlfluff lint models/
# If violations, fix them:
sqlfluff fix models/
```

---

## Common Errors & Solutions

### Error: "sqlfluff command not found"

**Solution**: Run activation first
```bash
source ../activate.sh
sqlfluff lint models/
```

### Error: "No dialect specified"

**Solution**: Make sure you're in the `dbt_project` folder
```bash
cd /path/to/dbt_project
sqlfluff lint models/
```

### Error: "File not found"

**Solution**: Check file path
```bash
ls models/
# Then use correct path
sqlfluff fix models/demo_model.sql
```

---

## Full Example Session

Here's a real example you can try:

```bash
# Activate
source ../activate.sh

# Create test file
cat > models/test_vscode.sql << 'EOF'
SELECT id,name,email FROM users WHERE status='active'
EOF

# Show before
echo "BEFORE:"
cat models/test_vscode.sql

# Format
sqlfluff fix models/test_vscode.sql

# Show after
echo "AFTER:"
cat models/test_vscode.sql

# Cleanup
rm models/test_vscode.sql
```

---

## Next: Your Own Models

Now that you know how to use SQLFluff in VSCode:

1. **Create a new model file** in VSCode
2. **Write some unformatted SQL**
3. **Open terminal** (Ctrl+`)
4. **Run**: `source ../activate.sh`
5. **Format**: `sqlfluff fix models/your_model.sql`
6. **Reload file** in VSCode
7. **See beautiful dbt-style formatting!**

---

## Learning Path

1. ✅ See the demo: `SQLFLUFF_DEMO.md`
2. ✅ See proof it works: `SQLFLUFF_LIVE_TEST.md`
3. ✅ **Learn to use from VSCode** ← You are here
4. → Try it with your own models
5. → Start Day 1 of `CURRICULUM.md`

---

## Ready to Try?

1. Open VSCode terminal: `Ctrl + ``
2. Activate: `source ../activate.sh`
3. Format demo: `sqlfluff fix models/demo_model.sql`
4. View result: `cat models/demo_model.sql`
5. See it auto-formatted! ✅

---

**Status**: ✅ Ready to Use SQLFluff from VSCode Terminal

You now know how to format all your models from VSCode!
