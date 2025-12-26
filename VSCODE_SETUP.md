# VSCode Setup Guide for DBT CLI

Complete step-by-step instructions for configuring VSCode to work perfectly with your DBT CLI environment.

Based on: https://discourse.getdbt.com/t/setting-up-vscode-to-use-with-the-dbt-cli/3291

---

## Overview

This guide will set up VSCode with:
- Python path pointing to your virtual environment
- DBT syntax highlighting
- SQL linting and formatting
- Quick navigation between models and compiled files
- CSV syntax highlighting

---

## Step 1: Create `.vscode/settings.json`

Your virtual environment is already created at: `dbt_env/`

Create a `.vscode/settings.json` file in your project root:

```bash
mkdir -p .vscode
touch .vscode/settings.json
```

Then add this configuration:

```json
{
  "python.defaultInterpreterPath": "${workspaceFolder}/dbt_env/bin/python",
  "python.formatting.provider": "black",
  "[python]": {
    "editor.defaultFormatter": "ms-python.python",
    "editor.formatOnSave": true
  },
  "[sql]": {
    "editor.defaultFormatter": "dorzey.vscode-sqlfluff",
    "editor.formatOnSave": true
  },
  "search.exclude": {
    "**/target": true,
    "**/dbt_packages": true,
    "**/logs": true
  },
  "sqlfluff.dialect": "duckdb",
  "files.exclude": {
    "**/__pycache__": true,
    "**/.pytest_cache": true
  }
}
```

### What Each Setting Does:

| Setting | Purpose |
|---------|---------|
| `python.defaultInterpreterPath` | Points to your virtual environment Python |
| `editor.formatOnSave` | Auto-format code when you save |
| `search.exclude` | Hide DBT-generated directories from search |
| `sqlfluff.dialect` | Set SQL linter to DuckDB dialect |
| `files.exclude` | Hide Python cache files |

---

## Step 2: Create `requirements.txt`

Create a `requirements.txt` file to document your dependencies:

```bash
cat > requirements.txt << 'EOF'
dbt-duckdb==1.10.0
dbt-core==1.11.2
EOF
```

This makes it easy for others (or you on another machine) to recreate your environment:

```bash
pip install -r requirements.txt
```

---

## Step 3: Update `.gitignore`

Your project should already have `.gitignore`, but ensure it includes:

```bash
cat > .gitignore << 'EOF'
# DBT
target/
dbt_packages/
logs/

# Python
__pycache__/
*.pyc
*.egg-info/
dist/
build/
.pytest_cache/

# Virtual Environment
dbt_env/
venv/
.venv/

# Editor
.vscode/
.DS_Store
*.swp
*.swo

# Credentials (never commit!)
profiles.yml
.env
.dbt/

# Database
*.duckdb
*.db
EOF
```

---

## Step 4: Install VSCode Extensions

Open VSCode and install these extensions (Cmd+Shift+X):

### Required Extensions

1. **dbt for Visual Studio Code** (Official)
   - Author: dbt Labs
   - ID: `dbt-labs.dbt-power-user`
   - Provides: SQL syntax highlighting, autocomplete, lineage

   ```
   Search: "dbt for visual studio code"
   Click Install
   ```

2. **SQLFluff** (SQL Linting)
   - Author: dorzey
   - ID: `dorzey.vscode-sqlfluff`
   - Provides: SQL linting and formatting for dbt

   ```
   Search: "SQLFluff"
   Click Install
   ```

### Recommended Extensions

3. **find-related** (Quick navigation)
   - Author: eamodio
   - ID: `eamodio.find-related`
   - Provides: Jump between models and compiled SQL

   ```
   Search: "find-related"
   Click Install
   ```

4. **Rainbow CSV** (CSV highlighting)
   - Author: mechatroner
   - ID: `mechatroner.rainbow-csv`
   - Provides: Colorized CSV files (useful for seeds)

   ```
   Search: "Rainbow CSV"
   Click Install
   ```

5. **GitLens** (Git integration)
   - Author: eamodio
   - ID: `eamodio.gitlens`
   - Provides: Git blame, history, authorship

   ```
   Search: "GitLens"
   Click Install
   ```

6. **Jinja** (Template syntax)
   - Author: wholroyd
   - ID: `wholroyd.jinja`
   - Provides: Jinja2 syntax highlighting

   ```
   Search: "Jinja"
   Click Install
   ```

---

## Step 5: Configure Extension Settings

After installing extensions, configure them in VSCode settings:

### 5.1 DBT Power User Settings

Add to `.vscode/settings.json`:

```json
{
  "dbt.pathMatcher": "'^(.*/)?models/(.*/)?(.+\\.sql)$': ['**/compiled/**/$3'], '^(.*/)?compiled/(.*/)?(.+\\.sql)$': ['**/models/**/$3']",
  "dbt.queryTimeout": 60,
  "[jinja]": {
    "editor.defaultFormatter": "wholroyd.jinja"
  }
}
```

### 5.2 SQL Formatting

Add to `.vscode/settings.json`:

```json
{
  "sqlfluff.rules": {
    "tab_space_size": 4,
    "max_line_length": 88,
    "indent_unit": "space"
  }
}
```

### 5.3 Python Settings

Add to `.vscode/settings.json`:

```json
{
  "python.linting.enabled": true,
  "python.linting.pylintEnabled": true,
  "python.linting.mypyEnabled": false
}
```

---

## Step 6: Complete `.vscode/settings.json`

Here's the complete settings file with all configurations:

```json
{
  "python.defaultInterpreterPath": "${workspaceFolder}/dbt_env/bin/python",
  "python.formatting.provider": "black",
  "python.linting.enabled": true,
  "python.linting.pylintEnabled": true,
  "[python]": {
    "editor.defaultFormatter": "ms-python.python",
    "editor.formatOnSave": true
  },
  "[sql]": {
    "editor.defaultFormatter": "dorzey.vscode-sqlfluff",
    "editor.formatOnSave": true
  },
  "[jinja]": {
    "editor.defaultFormatter": "wholroyd.jinja"
  },
  "search.exclude": {
    "**/target": true,
    "**/dbt_packages": true,
    "**/logs": true
  },
  "files.exclude": {
    "**/__pycache__": true,
    "**/.pytest_cache": true
  },
  "sqlfluff.dialect": "duckdb",
  "sqlfluff.rules": {
    "tab_space_size": 4,
    "max_line_length": 88
  },
  "dbt.pathMatcher": "'^(.*/)?models/(.*/)?(.+\\.sql)$': ['**/compiled/**/$3'], '^(.*/)?compiled/(.*/)?(.+\\.sql)$': ['**/models/**/$3']",
  "dbt.queryTimeout": 60,
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true
}
```

---

## Step 7: Verify Setup

### 7.1 Check Python Interpreter

1. Open VSCode
2. Cmd+Shift+P
3. Type "Python: Select Interpreter"
4. Choose: `./dbt_env/bin/python`

You should see it shows: `./dbt_env/bin/python`

### 7.2 Check Extensions

1. Open Extensions (Cmd+Shift+X)
2. Search for "dbt" - should see DBT Power User installed
3. Search for "sqlfluff" - should see SQLFluff installed
4. Search for "find-related" - should see it installed

### 7.3 Test DBT in Terminal

1. Open VSCode Terminal (Ctrl+`)
2. Run:
   ```bash
   source activate.sh
   dbt debug
   ```
3. Should show: ✅ All checks passed!

---

## Step 8: Using VSCode with DBT

### VSCode Commands for DBT

Open Command Palette (Cmd+Shift+P) and type:

| Command | Purpose |
|---------|---------|
| `dbt: run` | Execute all models |
| `dbt: test` | Run all tests |
| `dbt: compile` | Compile models to SQL |
| `dbt: parse` | Parse project |
| `dbt: docs generate` | Generate documentation |
| `dbt: freshness` | Check source freshness |

### File Navigation

With `find-related` extension:

- **Cmd+Click** on `{{ ref('model_name') }}` → Jump to model file
- **Cmd+Click** on `{{ source('source', 'table') }}` → Jump to source
- **Cmd+Shift+U** → Find related files

### SQL Formatting

- **Cmd+Shift+P** → "Format Document" to auto-format SQL
- Or use: `Cmd+K Cmd+F` to format selection

---

## Step 9: Recommended Workflow

### 1. Open Project in VSCode
```bash
cd /Users/skarangi/projects/trainings/my-dbt-learning-plan
code .
```

### 2. Select Python Interpreter
- Cmd+Shift+P → "Python: Select Interpreter"
- Choose: `./dbt_env/bin/python`

### 3. Open Terminal
- Cmd+` (backtick)
- Run: `source activate.sh`

### 4. Create a Model File
- New file: `models/marts/my_model.sql`
- VSCode shows SQL syntax highlighting
- Type with autocomplete from dbt extension

### 5. Run Model
- Cmd+Shift+P → "dbt: run"
- Or in terminal: `dbt run --select my_model`

### 6. View Compiled SQL
- Right-click on model → "Find Related Files"
- Jump to compiled version in `target/compiled/`

### 7. Format & Lint
- Cmd+Shift+P → "Format Document"
- Automatically formats SQL using SQLFluff

---

## Troubleshooting

### Issue: "Python interpreter not found"

**Solution**:
1. Cmd+Shift+P → "Python: Select Interpreter"
2. Click "Enter interpreter path"
3. Type: `/Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_env/bin/python`

### Issue: "dbt commands not working in terminal"

**Solution**: Make sure to activate environment first
```bash
source activate.sh
dbt run
```

### Issue: "SQL formatting not working"

**Solution**:
1. Install SQLFluff extension
2. Make sure `.vscode/settings.json` has sqlfluff config
3. Try: Cmd+Shift+P → "Format Document"

### Issue: "autocomplete not showing"

**Solution**:
1. Restart VSCode
2. Run: `dbt parse` first (generates manifest.json)
3. Make sure dbt extension is installed and enabled

### Issue: "find-related not jumping to files"

**Solution**:
1. Make sure extension is installed
2. Check `.vscode/settings.json` has pathMatcher config
3. Try Cmd+Shift+U instead of Cmd+Click

---

## File Structure After Setup

```
my-dbt-learning-plan/
├── .vscode/
│   └── settings.json              # ✅ Created
├── dbt_project/
│   ├── dbt_project.yml
│   ├── models/
│   ├── tests/
│   └── ...
├── dbt_env/                       # Virtual environment
├── .gitignore                     # ✅ Updated
├── requirements.txt               # ✅ Created
├── activate.sh
├── README.md
├── CURRICULUM.md
└── ...
```

---

## Quick Checklist

- [x] `.vscode/settings.json` created with Python path
- [x] `requirements.txt` created with dependencies
- [x] `.gitignore` updated with dbt_env
- [x] DBT Power User extension installed
- [x] SQLFluff extension installed
- [x] find-related extension installed (optional)
- [x] Rainbow CSV extension installed (optional)
- [x] Python interpreter selected in VSCode
- [x] Terminal tested with `dbt debug`
- [x] SQL formatting verified

---

## Extensions Summary

| Extension | Purpose | Required |
|-----------|---------|----------|
| DBT Power User | Syntax highlighting, autocomplete | ✅ Yes |
| SQLFluff | SQL linting & formatting | ✅ Yes |
| find-related | Navigate between files | ⭐ Recommended |
| Rainbow CSV | CSV syntax highlighting | ⭐ Recommended |
| GitLens | Git integration | ⭐ Recommended |
| Jinja | Jinja2 syntax | ⭐ Recommended |

---

## Next Steps

1. ✅ Create `.vscode/settings.json`
2. ✅ Create `requirements.txt`
3. ✅ Update `.gitignore`
4. ✅ Install VSCode extensions
5. ✅ Select Python interpreter
6. → Start building your first model!
7. → Follow CURRICULUM.md Day 1

---

## Resources

- [DBT Power User Extension](https://marketplace.visualstudio.com/items?itemName=dbt-labs.dbt-power-user)
- [SQLFluff Extension](https://marketplace.visualstudio.com/items?itemName=dorzey.vscode-sqlfluff)
- [VSCode Python Setup](https://code.visualstudio.com/docs/python/python-tutorial)
- [Original DBT Discourse Guide](https://discourse.getdbt.com/t/setting-up-vscode-to-use-with-the-dbt-cli/3291)

---

*VSCode setup complete! You're ready to develop DBT models efficiently.* 🚀

EOF
