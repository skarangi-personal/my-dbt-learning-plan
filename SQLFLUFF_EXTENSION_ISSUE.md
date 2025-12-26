# SQLFluff "Executable Not Found" - Advanced Troubleshooting

This guide covers the issue where VSCode's SQLFluff extension cannot find the sqlfluff executable.

---

## Updated Configuration ✅

Your `.vscode/settings.json` now has TWO paths configured:

```json
{
  "sqlfluff.executablePath": "/Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_env/bin/sqlfluff",
  "sqlfluff.python": "/Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_env/bin/python"
}
```

**Both are now configured.** This ensures the extension:
1. Finds the sqlfluff executable
2. Uses the correct Python interpreter to run it

---

## Step-by-Step Resolution

### Step 1: Hard Restart VSCode (CRITICAL)

The key is to completely close and reopen VSCode:

```bash
# Kill all VSCode processes
pkill -f "Code"

# Wait 2 seconds
sleep 2

# Clear extension cache
rm -rf ~/Library/Application\ Support/Code/Cache
rm -rf ~/Library/Application\ Support/Code/CachedData

# Reopen VSCode with your project
code /Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_project
```

### Step 2: Wait for Initialization

When VSCode opens:
1. Wait 30-60 seconds for extensions to load
2. Look for any error popups - don't dismiss them yet
3. Open the Output panel: `View → Output`
4. Select "SQLFluff" from the dropdown

### Step 3: Check Output Panel for Errors

In Output panel (Cmd+Shift+U), select "SQLFluff":
- **No errors** → SQLFluff is working ✅
- **"executable not found"** → Continue to Step 4
- **Other errors** → Note them and check Step 5

### Step 4: Test SQLFluff

Create a test file to verify:

1. Create: `models/test_sqlfluff.sql`
2. Add content:
```sql
SELECT id,name,email FROM {{ ref('orders') }} WHERE status='active'
```

3. Save (Cmd+S)
4. Watch the file - it should auto-format to:
```sql
select
    id,
    name,
    email,
from {{ ref('orders') }}
where status = 'active'
```

**If formatting happens → SQLFluff works!** ✅

### Step 5: Reinstall SQLFluff Extension (if still failing)

1. `Cmd+Shift+X` (Extensions)
2. Search: "sqlfluff"
3. Click the extension by "dorzey"
4. Click **Uninstall**
5. Click **Reload** when prompted
6. Wait for reload to complete
7. Reinstall the extension
8. Wait 30 seconds for initialization

---

## What Each Setting Does

### `sqlfluff.executablePath`
- **Purpose**: Path to the sqlfluff executable
- **Current value**: `/Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_env/bin/sqlfluff`
- **Why absolute path**: Ensures VSCode can find it regardless of how you open the project
- **Type**: String (full file path)

### `sqlfluff.python`
- **Purpose**: Path to Python interpreter sqlfluff should use
- **Current value**: `/Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_env/bin/python`
- **Why needed**: SQLFluff is a Python tool and needs the right Python to run
- **Type**: String (full file path)

### `sqlfluff.dialect`
- **Purpose**: SQL dialect (we use DuckDB)
- **Current value**: `duckdb`
- **Why**: Ensures SQLFluff knows how to parse and format DuckDB SQL

### `sqlfluff.config`
- **Purpose**: Path to SQLFluff rules file
- **Current value**: `${workspaceFolder}/.sqlfluff`
- **Why**: This file has 12 dbt best practices rules

### `[sql].editor.formatOnSave`
- **Purpose**: Auto-format SQL when you save
- **Current value**: `true`
- **Why**: Automatic formatting without manual commands

---

## Verification Checklist

Run through these checks to verify everything is working:

### Check 1: File Exists
```bash
ls -la /Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_env/bin/sqlfluff
# Should show: -rwxr-xr-x (executable)
```

### Check 2: Executable Works
```bash
/Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_env/bin/sqlfluff --version
# Should show: sqlfluff, version 3.5.0
```

### Check 3: Python Works
```bash
/Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_env/bin/python --version
# Should show: Python 3.11.9
```

### Check 4: Settings File Valid
```bash
cat /Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_project/.vscode/settings.json | grep sqlfluff
```

Should show:
```json
"sqlfluff.executablePath": "/Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_env/bin/sqlfluff",
"sqlfluff.python": "/Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_env/bin/python",
```

### Check 5: Extension Installed
In VSCode:
1. `Cmd+Shift+X`
2. Search: "sqlfluff"
3. Should see the extension by "dorzey"
4. Should say "Installed" (not "Install")

### Check 6: Configuration File Exists
```bash
ls -la /Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_project/.sqlfluff
# Should show: -rw-r--r-- (readable text file)
```

---

## Common Issues and Solutions

### Issue 1: "Command not found: Code"
**Symptom**: Terminal says `code: command not found`

**Solution**:
1. Install VSCode if not already: https://code.visualstudio.com
2. Or use: `open -a "Visual Studio Code" /path/to/folder`

### Issue 2: "Extension takes long to load"
**Symptom**: SQLFluff takes 30-60 seconds to initialize

**Solution**: This is normal for first load. Be patient and wait.

### Issue 3: "Red squiggles but no auto-format"
**Symptom**: Violations show but don't auto-fix

**Solution**:
1. Check: `"sqlfluff.autofix": true` is in settings
2. Check: `"[sql]": {"editor.formatOnSave": true}` is in settings
3. Try: `Cmd+K Cmd+F` to manually format

### Issue 4: "Wrong Python interpreter selected"
**Symptom**: VSCode uses system Python instead of venv

**Solution**:
1. `Cmd+Shift+P` → "Python: Select Interpreter"
2. Choose: `./dbt_env/bin/python`
3. Verify in status bar (bottom left) shows correct path

### Issue 5: "sqlfluff not recognizing dbt functions"
**Symptom**: Red squiggles on `{{ ref() }}` or `{{ source() }}`

**Solution**:
1. Check: `.sqlfluff` file exists in project root
2. Check: `[sqlfluff:templater:jinja]` section is present
3. Restart VSCode

---

## Nuclear Option: Complete Reinstall

If nothing else works, try complete reinstall:

```bash
# 1. Kill VSCode
pkill -f "Code"

# 2. Remove SQLFluff extension
rm -rf ~/.vscode/extensions/dorzey.vscode-sqlfluff*

# 3. Clear all VSCode cache
rm -rf ~/Library/Application\ Support/Code/Cache
rm -rf ~/Library/Application\ Support/Code/CachedData

# 4. Reinstall sqlfluff in venv
cd /Users/skarangi/projects/trainings/my-dbt-learning-plan
source dbt_env/bin/activate
pip uninstall -y sqlfluff
pip install sqlfluff==3.5.0

# 5. Reopen VSCode
code dbt_project

# 6. Extension will reinstall automatically
# Wait 60 seconds for initialization
```

---

## Expected Behavior After Fix

### When Working Correctly:
1. ✅ Save a `.sql` file
2. ✅ File auto-formats within 1-2 seconds
3. ✅ Formatting follows dbt best practices:
   - Lowercase keywords
   - 4-space indentation
   - Trailing commas
   - Explicit `AS` for aliases
   - `IS NULL` instead of `= NULL`
4. ✅ Violations show as red/yellow squiggles
5. ✅ No errors in Output panel

### When NOT Working:
- ❌ "executable not found" error
- ❌ Files don't auto-format on save
- ❌ No squiggles for violations
- ❌ Output panel shows errors

---

## Testing After Fix

### Test 1: Messy SQL
```sql
SELECT id,name,email,phone,address,created_at FROM {{ ref('customers') }} WHERE status='active' AND deleted_at IS NULL ORDER BY created_at DESC
```

**Should format to:**
```sql
select
    id,
    name,
    email,
    phone,
    address,
    created_at,
from {{ ref('customers') }}
where status = 'active'
    and deleted_at is null
order by created_at desc
```

### Test 2: Bad Practices Detection
```sql
-- Bad: = NULL instead of IS NULL
where deleted_at = null
```

**Should show**: Red squiggle with message "Null comparison should use IS NULL"

### Test 3: Quick Fix
1. Hover over red squiggle
2. Click "Quick Fix"
3. Should auto-correct to `is null`

---

## Settings Summary

Your complete SQLFluff settings:

```json
{
  "sqlfluff.dialect": "duckdb",
  "sqlfluff.executablePath": "/Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_env/bin/sqlfluff",
  "sqlfluff.python": "/Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_env/bin/python",
  "sqlfluff.config": "${workspaceFolder}/.sqlfluff",
  "sqlfluff.ignoreLocal": false,
  "sqlfluff.autofix": true,
  "[sql]": {
    "editor.defaultFormatter": "dorzey.vscode-sqlfluff",
    "editor.formatOnSave": true
  }
}
```

---

## Next Steps After Fix

Once SQLFluff is working:

1. Read: `CURRICULUM.md`
2. Navigate to: **Day 1: DBT Fundamentals**
3. Create your first model and watch it auto-format
4. Start learning DBT!

---

## Need More Help?

- **SQLFluff Extension Docs**: https://github.com/dorzey/vscode-sqlfluff
- **SQLFluff Docs**: https://docs.sqlfluff.com
- **dbt SQL Style Guide**: https://docs.getdbt.com/best-practices/how-we-style/2-how-we-style-our-sql

---

**Status**: ✅ Configuration Complete - Just Need VSCode Restart

Try the restart procedure above, and SQLFluff should work!
