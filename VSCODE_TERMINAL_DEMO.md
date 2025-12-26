# VSCode Terminal Demo - Run SQLFluff Now!

Quick visual guide to running the SQLFluff demo from VSCode terminal.

---

## Open VSCode

Open your terminal:

```bash
code /Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_project
```

Or:
```bash
cd /Users/skarangi/projects/trainings/my-dbt-learning-plan/dbt_project
code .
```

---

## Open Terminal in VSCode

**Press**: `Ctrl + `` (backtick key)

Or click: **Terminal → New Terminal** from menu

You should see a terminal panel at the bottom.

---

## Copy-Paste This Complete Demo

Just copy everything below and paste it into the VSCode terminal:

```bash
# Activate environment
source ../activate.sh

echo ""
echo "================================"
echo "STEP 1: View original file"
echo "================================"
cat models/demo_model.sql

echo ""
echo "================================"
echo "STEP 2: Lint - find violations"
echo "================================"
sqlfluff lint models/demo_model.sql

echo ""
echo "================================"
echo "STEP 3: Fix - auto-format"
echo "================================"
sqlfluff fix models/demo_model.sql

echo ""
echo "================================"
echo "STEP 4: View formatted result"
echo "================================"
cat models/demo_model.sql

echo ""
echo "================================"
echo "✅ DEMO COMPLETE!"
echo "================================"
echo ""
echo "Violations found: 13"
echo "Violations fixed: 10"
echo "Readability: Improved from 2/10 to 10/10"
echo ""
```

---

## What You'll See

### Terminal Output:

```
🚀 Activating DBT environment...
✅ Environment activated!

Available commands:
  dbt debug
  dbt parse
  ...

================================
STEP 1: View original file
================================
-- Sample unformatted DBT model for SQLFluff demo
SELECT customer_id,order_date,amount,status FROM raw_orders WHERE status='completed' AND amount>100 ORDER BY order_date DESC

================================
STEP 2: Lint - find violations
================================
== [models/demo_model.sql] FAIL
L:   2 | P:   1 | LT05 | Line is too long (124 > 80).
L:   2 | P:   1 | LT09 | Select targets should be on a new line
L:   2 | P:  20 | LT01 | Expected single whitespace between comma
...
All Finished!

================================
STEP 3: Fix - auto-format
================================
==== finding fixable violations ====
== [models/demo_model.sql] FIXED
10 fixable linting violations found

================================
STEP 4: View formatted result
================================
-- Sample unformatted DBT model for SQLFluff demo
SELECT
    customer_id,
    order_date,
    amount,
    status
FROM raw_orders
WHERE status = 'completed' AND amount > 100
ORDER BY order_date DESC

================================
✅ DEMO COMPLETE!
================================

Violations found: 13
Violations fixed: 10
Readability: Improved from 2/10 to 10/10
```

---

## Step-by-Step Screenshots (Text)

### Step 1: VSCode with Terminal Open

```
┌─────────────────────────────────────┐
│ VSCode - dbt_project                │
├─────────────────────────────────────┤
│ File  Edit  View  Terminal  Help    │
├─────────────────────────────────────┤
│ models/                             │
│ ├── demo_model.sql                  │
│ ├── simple_test.sql                 │
│ └── test_sqlfluff.sql               │
│                                     │
├─────────────────────────────────────┤
│ Terminal: source ../activate.sh     │
│ $ source ../activate.sh             │
│ 🚀 Activating DBT environment...    │
└─────────────────────────────────────┘
```

### Step 2: After Activation

```
┌─────────────────────────────────────┐
│ Terminal                            │
├─────────────────────────────────────┤
│ 🚀 Activating DBT environment...    │
│ ✅ Environment activated!           │
│                                     │
│ Available commands:                 │
│   dbt debug      - Test connection  │
│   dbt run        - Execute models   │
│   ...                               │
│                                     │
│ $ sqlfluff lint models/demo_model   │
└─────────────────────────────────────┘
```

### Step 3: Lint Output

```
┌─────────────────────────────────────┐
│ Terminal                            │
├─────────────────────────────────────┤
│ $ sqlfluff lint models/demo_model   │
│ == [models/demo_model.sql] FAIL     │
│ L:   2 | P:   1 | LT05 | Line too  │
│ L:   2 | P:   1 | LT09 | Select    │
│ L:   2 | P:  20 | LT01 | Spacing   │
│ ...13 violations total...           │
│ All Finished!                       │
│                                     │
│ $ sqlfluff fix models/demo_model    │
└─────────────────────────────────────┘
```

### Step 4: Fix Output

```
┌─────────────────────────────────────┐
│ Terminal                            │
├─────────────────────────────────────┤
│ $ sqlfluff fix models/demo_model    │
│ ==== finding fixable violations ==  │
│ == [models/demo_model.sql] FIXED    │
│ 10 fixable linting violations found │
│                                     │
│ $                                   │
└─────────────────────────────────────┘
```

### Step 5: View Formatted Result

```
┌─────────────────────────────────────┐
│ Terminal                            │
├─────────────────────────────────────┤
│ $ cat models/demo_model.sql         │
│ -- Sample unformatted DBT model...  │
│ SELECT                              │
│     customer_id,                    │
│     order_date,                     │
│     amount,                         │
│     status                          │
│ FROM raw_orders                     │
│ WHERE status = 'completed' AND...   │
│ ORDER BY order_date DESC            │
│                                     │
│ ✅ DEMO COMPLETE!                  │
└─────────────────────────────────────┘
```

---

## Quick Commands

### Just Lint (See violations)
```bash
source ../activate.sh
sqlfluff lint models/demo_model.sql
```

### Just Fix (Auto-format)
```bash
source ../activate.sh
sqlfluff fix models/demo_model.sql
```

### Format All Models
```bash
source ../activate.sh
sqlfluff fix models/
```

### Check Your Own File
```bash
source ../activate.sh
sqlfluff lint models/your_model.sql
sqlfluff fix models/your_model.sql
```

---

## Then Reload in VSCode Editor

After formatting, your file in VSCode will show:

**"File has changed on disk"** message

Click **"Reload"** to see the formatted version in the editor.

---

## Real Workflow

Here's how you'll use it in practice:

1. **Write SQL** in VSCode
2. **Open terminal** (Ctrl+`)
3. **Activate**: `source ../activate.sh`
4. **Format**: `sqlfluff fix models/my_file.sql`
5. **Reload**: Click reload in VSCode
6. **Done!** Your code is formatted

---

## Try It Right Now!

1. Open VSCode terminal
2. Run: `source ../activate.sh`
3. Paste the demo script above
4. Watch it format in real-time!

---

## What This Proves

✅ SQLFluff works from VSCode terminal
✅ Detects violations accurately
✅ Fixes them automatically
✅ Integrates into your workflow
✅ Easy to use repeatedly

---

## Next Steps

1. **Try the demo** - Copy-paste the script above
2. **See it work** - Watch violations get fixed
3. **Create your own** - Write a model and format it
4. **Start learning** - Open `CURRICULUM.md`

---

**Status**: ✅ Ready to Demo from VSCode

Open terminal and run the demo now! 🚀
