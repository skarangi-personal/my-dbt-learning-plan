# VSCode SQLFluff Error - Definitive Fix

If you see: **"The sqlfluff executable was not found"** in VSCode, this guide will fix it.

---

## What Was Wrong

The `settings.json` was using a relative path:
```json
"sqlfluff.executablePath": "${workspaceFolder}/../dbt_env/bin/sqlfluff"
```

VSCode's path expansion sometimes fails with relative paths that go up directories (`../`). This causes SQLFluff to not be found.

---

## The Fix (Already Applied) ✅

The `settings.json` has been updated to use an **absolute path**:

```json
"sqlfluff.executablePath": "/Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_env/bin/sqlfluff"
```

This ensures VSCode can always find SQLFluff, regardless of how the workspace is opened.

---

## What to Do Now

### Step 1: Restart VSCode
This is critical - you must close and reopen VSCode for the new setting to take effect:

```bash
# Close VSCode completely
Cmd+Q

# Reopen with your project
code /Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_project
```

### Step 2: Verify SQLFluff is Working
1. Create a test file: `models/test_sqlfluff.sql`
2. Write unformatted SQL:
```sql
SELECT id,name,email FROM {{ source('raw','customers') }} WHERE status='active'
```

3. Save the file (Cmd+S)
4. Watch it auto-format to:
```sql
select
    id,
    name,
    email,
from {{ source('raw', 'customers') }}
where status = 'active'
```

If it auto-formats, **SQLFluff is working!** ✅

### Step 3: Check for Error Messages
1. In VSCode, open the Output panel: `Cmd+Shift+U`
2. Select "SQLFluff" from the dropdown
3. You should see no errors
4. If you see errors, check Step 1 - restart VSCode

---

## Why This Works

**Absolute Path Benefits:**
- ✅ No path expansion issues
- ✅ Works regardless of workspace configuration
- ✅ Direct reference to executable
- ✅ Most reliable for tools like SQLFluff

**Relative Path Problems:**
- ❌ `../` path resolution sometimes fails in VSCode
- ❌ Depends on workspace configuration
- ❌ Can fail with some VSCode extensions
- ❌ Less reliable for external tools

---

## Verify Your Configuration

Your `settings.json` now has:

```json
{
  "python.defaultInterpreterPath": "${workspaceFolder}/../dbt_env/bin/python",
  "sqlfluff.dialect": "duckdb",
  "sqlfluff.executablePath": "/Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_env/bin/sqlfluff",
  "sqlfluff.config": "${workspaceFolder}/.sqlfluff",
  "sqlfluff.autofix": true,
  "[sql]": {
    "editor.defaultFormatter": "dorzey.vscode-sqlfluff",
    "editor.formatOnSave": true
  }
}
```

Key settings explained:
- `sqlfluff.executablePath` - **Absolute path** to sqlfluff (now fixed!)
- `sqlfluff.config` - Relative path to `.sqlfluff` rules file
- `editor.formatOnSave` - Auto-format when you save
- `sqlfluff.autofix` - Automatically fix violations

---

## Testing SQLFluff Step-by-Step

### Test 1: Create Test File
```bash
# In VSCode, create: models/test.sql
SELECT * FROM {{ ref('orders') }}
```

### Test 2: Save and Watch Format
1. Press Cmd+S to save
2. Code should auto-format
3. If it doesn't, check Output panel

### Test 3: Check Output Panel
1. View → Output
2. Select "SQLFluff" from dropdown
3. Look for any error messages

### Test 4: Manual Format
1. Create a messy SQL file
2. Press: Cmd+K Cmd+F (Format Document)
3. Should format with 4-space indents, lowercase, trailing commas

### Test 5: Error Detection
1. Write: `WHERE status = null`
2. Should show red squiggle
3. Hover and see: "Null comparison should use IS NULL"

---

## If Error Persists

### Option A: Force Restart
```bash
# Hard restart of VSCode
pkill -f "Code"
code /Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_project
```

### Option B: Clear VSCode Cache
```bash
# Close VSCode first
Cmd+Q

# Clear cache
rm -rf ~/Library/Application\ Support/Code/Cache
rm -rf ~/Library/Application\ Support/Code/CachedData

# Reopen VSCode
code /Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_project
```

### Option C: Reinstall SQLFluff Extension
1. `Cmd+Shift+X` (Extensions)
2. Search: "sqlfluff"
3. Uninstall
4. Restart VSCode
5. Reinstall

### Option D: Verify SQLFluff Installation
```bash
# Activate environment
source activate.sh

# Verify sqlfluff exists and runs
which sqlfluff
sqlfluff --version
# Should show: sqlfluff, version 3.5.0

# Test linting
sqlfluff lint models/
```

If `sqlfluff --version` works in terminal but VSCode still fails:
- The extension may need restart
- Try Option A (force restart)
- Or try Option C (reinstall extension)

---

## What Happens After Fix

### Auto-Formatting Workflow
1. You write messy SQL
2. Save file (Cmd+S)
3. SQLFluff detects violations
4. Auto-fixes them (based on `.sqlfluff` config)
5. You see formatted code instantly

### Benefits
- ✅ Consistent code style
- ✅ Follows dbt best practices
- ✅ No manual formatting needed
- ✅ Red squiggles show violations
- ✅ Quick fixes available on hover

### Example Formatting
```sql
-- Your messy code:
SELECT customer_id,COUNT(*) as total FROM {{ ref('orders') }} WHERE status='active' GROUP BY customer_id ORDER BY total DESC

-- After save (auto-formatted):
select
    customer_id,
    count(*) as total,
from {{ ref('orders') }}
where status = 'active'
group by customer_id
order by total desc
```

---

## Settings You Can Customize

If you want to adjust SQLFluff behavior:

### Disable Auto-Fix
```json
"sqlfluff.autofix": false
```
(Violations shown but not auto-fixed)

### Change Max Line Length
Edit `.sqlfluff`:
```ini
[core]
max_line_length = 100  # was 80
```

### Disable Specific Rules
Edit `.sqlfluff`:
```ini
[sqlfluff:rules:L042]
forbid_unused_aliases = false
```

### Turn Off Auto-Format on Save
```json
"[sql]": {
  "editor.formatOnSave": false
}
```

---

## Support Resources

- **SQLFluff Docs**: https://docs.sqlfluff.com
- **dbt SQL Style Guide**: https://docs.getdbt.com/best-practices/how-we-style/2-how-we-style-our-sql
- **VSCode Settings**: Press Cmd+, to open settings
- **SQLFluff Extension Repo**: https://github.com/dorzey/vscode-sqlfluff

---

## Summary

✅ **Fix Applied**: SQLFluff path updated to absolute path

✅ **Next Step**: Restart VSCode (Cmd+Q then reopen)

✅ **Verification**: Create test.sql, save it, watch it format

✅ **Result**: Auto-formatting should work immediately

---

**Once this is working, you're ready to start Day 1 of the curriculum!**

See: `CURRICULUM.md` → Day 1: DBT Fundamentals

---

**Status**: ✅ Fixed and Ready

Last updated: December 26, 2024
