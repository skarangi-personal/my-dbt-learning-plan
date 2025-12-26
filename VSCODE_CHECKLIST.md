# VSCode Setup Checklist ✅

Complete checklist to verify VSCode is properly configured for DBT development.

---

## Files Created ✅

- [x] `.vscode/settings.json` - VSCode configuration
- [x] `requirements.txt` - Python dependencies
- [x] `.gitignore` - Updated with dbt_env and settings.json rules
- [x] `VSCODE_SETUP.md` - Complete setup guide

---

## Configuration Completed ✅

### Python Path
- [x] Set to: `${workspaceFolder}/../dbt_env/bin/python`
- [x] Points to your virtual environment

### SQL Formatting
- [x] SQLFluff enabled
- [x] DuckDB dialect configured
- [x] Auto-format on save enabled
- [x] Max line length: 88 characters

### Search & Files
- [x] Exclude `/target` from search
- [x] Exclude `/dbt_packages` from search
- [x] Exclude `/logs` from search
- [x] Hide `__pycache__` files

### File Navigation
- [x] pathMatcher configured for `ref()` jumping
- [x] Can jump between models and compiled SQL

---

## Before Opening VSCode

### Step 1: Install Extensions

Open VSCode and go to Extensions (Cmd+Shift+X):

**Required:**
- [ ] **DBT Power User** - Search: "dbt for visual studio code"
- [ ] **SQLFluff** - Search: "sqlfluff"

**Recommended:**
- [ ] **find-related** - Quick file navigation
- [ ] **Rainbow CSV** - CSV highlighting for seeds
- [ ] **GitLens** - Git integration
- [ ] **Jinja** - Jinja2 template syntax

### Step 2: Select Python Interpreter

1. Open the dbt_project folder in VSCode: `code dbt_project`
2. Cmd+Shift+P → "Python: Select Interpreter"
3. Choose: `./dbt_env/bin/python`
4. You should see it shows the correct path

### Step 3: Verify Settings

1. Cmd+Shift+P → "Preferences: Open Settings (JSON)"
2. Should show our configuration from `.vscode/settings.json`
3. Verify you see:
   - `python.defaultInterpreterPath`
   - `sqlfluff.dialect: "duckdb"`
   - `dbt.pathMatcher` configuration

---

## Testing Your Setup

### Test 1: Python Interpreter
```bash
# In VSCode Terminal (Ctrl+`)
python --version
# Should show: Python 3.11.9
```

### Test 2: DBT CLI
```bash
source ../activate.sh
dbt --version
# Should show: dbt-core 1.11.2 + dbt-duckdb 1.10.0
```

### Test 3: SQL Formatting
1. Create a test file: `models/test.sql`
2. Write unformatted SQL:
```sql
SELECT id,name,email FROM {{ source('raw', 'customers') }} WHERE status='active'
```
3. Save (Cmd+S)
4. Should auto-format to:
```sql
SELECT
  id,
  name,
  email
FROM {{ source('raw', 'customers') }}
WHERE status = 'active'
```

### Test 4: File Navigation
1. Create: `models/stg_orders.sql`
2. In another file, write: `{{ ref('stg_orders') }}`
3. Cmd+Click on `ref('stg_orders')`
4. Should jump to `stg_orders.sql`

### Test 5: Error Highlighting
1. Write invalid SQL in a model:
```sql
SELECT * FROM {{ ref() }}  -- Missing model name
```
2. Should show red squiggle under `ref()`

---

## Quick Feature Test Matrix

| Feature | Test | Expected Result |
|---------|------|-----------------|
| Syntax Highlighting | Write SQL | Code has colors |
| Auto-format | Save file | Code reformats |
| Autocomplete | Type `{{ r` | See suggestions |
| Error Detection | Bad syntax | Red squiggles |
| File Jump | Cmd+Click `ref()` | Jump to model |
| Python Path | Open terminal | Shows correct Python |

---

## Troubleshooting

### "Python interpreter shows wrong path"
**Solution**:
1. Cmd+Shift+P → "Python: Select Interpreter"
2. Click "Enter interpreter path"
3. Type: `/Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_env/bin/python`

### "SQL not formatting on save"
**Solution**:
1. Install SQLFluff extension
2. Verify in settings: `"editor.formatOnSave": true`
3. Verify: `"[sql]": {"editor.defaultFormatter": "dorzey.vscode-sqlfluff"}`

### "Can't jump to files with Cmd+Click"
**Solution**:
1. Install "find-related" extension
2. Or try: Cmd+Shift+U to find related files
3. Check pathMatcher is in settings.json

### "Extensions not showing up"
**Solution**:
1. Cmd+Shift+X to open Extensions
2. Click the Cloud icon to download if needed
3. Restart VSCode (Cmd+Q then open again)

### "DuckDB errors in SQL"
**Solution**:
1. Verify in settings: `"sqlfluff.dialect": "duckdb"`
2. Or disable SQLFluff if it's too strict: Remove from `editor.defaultFormatter`

---

## Your Directory Structure

```
my-dbt-learning-plan/
├── dbt_project/                    # Open THIS folder in VSCode
│   ├── .vscode/
│   │   └── settings.json          # ✅ Configuration file
│   ├── dbt_project.yml
│   ├── models/                    # Write your models here
│   ├── tests/
│   ├── macros/
│   └── ...
├── dbt_env/                        # Virtual environment
├── requirements.txt                # ✅ Python dependencies
├── activate.sh
└── ...
```

---

## How to Open Project Correctly

### Option 1: Open via Command Line
```bash
cd dbt_project
code .
```

### Option 2: Open via VSCode
1. File → Open Folder
2. Select: `/Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_project`
3. Click "Open"

### Option 3: Use Workspace File
Create `dbt_learning.code-workspace`:
```json
{
  "folders": [
    {
      "path": "dbt_project",
      "name": "DBT Project"
    }
  ],
  "settings": {
    "python.defaultInterpreterPath": "${workspaceFolder}/dbt_project/../dbt_env/bin/python"
  }
}
```

Then: `code dbt_learning.code-workspace`

---

## VSCode Keyboard Shortcuts for DBT

| Action | Shortcut |
|--------|----------|
| Open Command Palette | Cmd+Shift+P |
| Select Python Interpreter | Cmd+Shift+P → "Python: Select Interpreter" |
| Open Terminal | Ctrl+` (backtick) |
| Format Document | Cmd+K Cmd+F |
| Find File | Cmd+P |
| Find Related Files | Cmd+Shift+U (with find-related extension) |
| Go to Definition | Cmd+Click |
| Quick Fix | Cmd+. |
| Split Editor | Cmd+\ |

---

## Extensions You Should Have

### Installed ✅
- [ ] dbt for Visual Studio Code (dbt-labs.dbt-power-user)
- [ ] SQLFluff (dorzey.vscode-sqlfluff)

### Recommended ⭐
- [ ] find-related (eamodio.find-related)
- [ ] Rainbow CSV (mechatroner.rainbow-csv)
- [ ] GitLens (eamodio.gitlens)
- [ ] Jinja (wholroyd.jinja)

### To Install
1. Cmd+Shift+X
2. Search extension name
3. Click "Install"

---

## Ready to Start?

Once you've completed this checklist:

1. ✅ Extensions installed
2. ✅ Python interpreter selected
3. ✅ Settings verified
4. ✅ All tests passing

You're ready to:
→ Open `dbt_project` folder in VSCode
→ Open `CURRICULUM.md` Day 1
→ Create your first DBT model!

---

## Quick Start Command

```bash
cd /Users/skarangi/projects/trainings/my-dbt-learning-plan
source activate.sh
code dbt_project
```

Then in VSCode:
1. Cmd+Shift+P → "Python: Select Interpreter"
2. Choose: `./dbt_env/bin/python`
3. Ctrl+` → Open terminal
4. Run: `dbt debug`

You're all set! 🚀

---

**Status**: ✅ VSCode Setup Complete

Last updated: December 26, 2024

