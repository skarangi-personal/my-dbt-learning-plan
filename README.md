# DBT Learning Plan for SQL-Strong Data Engineers

A comprehensive 10-day hands-on curriculum for data engineers with strong SQL skills who want to master DBT and modern data engineering practices.

## 📚 Quick Start

### What's Included
- **10-Day Curriculum** with daily learning objectives and hands-on projects
- **3 Progressive Projects** (E-commerce → Analytics Platform → Production Pipeline)
- **Complete Reference Materials** with 37+ curated resources
- **Data Modeling Guide** focused on Kimball methodology
- **Quick Reference Sheets** for SQL-to-DBT translation

### Who This Is For
- Data engineers with strong SQL skills
- Limited Python coding experience (but willing to learn)
- Want to understand DBT fundamentals to advanced production patterns
- Prefer hands-on, project-based learning

### Time Commitment
- **Duration**: 10 days
- **Daily Time**: 6-8 hours (2 hours concepts + 4-6 hours hands-on)
- **Total**: ~70 hours
- **Self-paced**: Follow at your own speed

## 📖 Curriculum Overview

### Learning Path
```
Days 1-3:   Foundations & E-commerce Project
Days 4-7:   Advanced Patterns & Analytics Platform
Days 8-10:  Production-Ready & Enterprise Pipeline
```

### What You'll Master
By the end of Day 10, you'll be able to:

✓ Design 3-layer data models (staging → intermediate → marts)
✓ Apply Kimball dimensional modeling to DBT projects
✓ Build testable, documented DBT projects
✓ Implement slowly changing dimensions (SCD Type 2)
✓ Optimize with incremental models (40%+ performance gains)
✓ Deploy to production with CI/CD automation
✓ Write Jinja macros for reusable patterns
✓ Debug and monitor data pipelines

## 📁 File Structure

```
my-dbt-learning-plan/
├── README.md                          # This file
├── CURRICULUM.md                      # Complete 10-day curriculum
├── dbt-learning-plan-prompt.md        # Original comprehensive prompt
├── QUICK_REFERENCE.md                 # Cheat sheets & translations
└── projects/
    ├── project-1-ecommerce/          # Days 1-3: E-commerce data warehouse
    ├── project-2-analytics/          # Days 4-7: Multi-source analytics
    └── project-3-production/         # Days 8-10: Enterprise pipeline
```

## 🚀 Getting Started

### Step 1: Choose Your Data Warehouse

| Warehouse | Best For | Cost | Setup |
|-----------|----------|------|-------|
| **DuckDB** | Local learning, quick prototyping | Free | 5 mins |
| **PostgreSQL** | Local learning, SQL strength | Free | 10 mins |
| **Snowflake** | Production-like, full features | $400 free credits | 5 mins |
| **BigQuery** | Large scale, public datasets | Free tier available | 10 mins |

**Recommendation**: Start with DuckDB or PostgreSQL locally.

### Step 2: Set Up DBT Environment

```bash
# Install dbt (choose your warehouse adapter)
pip install dbt-duckdb          # For DuckDB
pip install dbt-postgres        # For PostgreSQL

# Initialize your first project
dbt init my_dbt_project
cd my_dbt_project

# Test connection
dbt debug
```

### Step 3: Follow the Curriculum
1. Read `CURRICULUM.md` for your day's objectives
2. Review recommended resources for that day
3. Complete hands-on project work
4. Use `QUICK_REFERENCE.md` for SQL-to-DBT translations

## 📅 Daily Breakdown

### Days 1-3: Foundations (E-commerce Project)
**Focus**: DBT basics, materializations, testing, documentation

**Time**: 18-24 hours
**Complexity**: ⭐ Beginner

### Days 4-7: Intermediate (Analytics Platform)
**Focus**: Sources, SCD Type 2, incremental models, Jinja macros

**Time**: 24-32 hours
**Complexity**: ⭐⭐ Intermediate

### Days 8-10: Production (Enterprise Pipeline)
**Focus**: Reference data, data quality, CI/CD deployment

**Time**: 18-24 hours
**Complexity**: ⭐⭐⭐ Advanced

## 🎯 Key Concepts

### 1. DBT Fundamentals
- **Project Structure**: How DBT projects are organized
- **Models**: SQL files that become tables/views
- **Materializations**: View, table, ephemeral, incremental, snapshot
- **DAG**: Directed Acyclic Graph showing dependencies
- **Ref & Source**: How to link models to each other and raw data

### 2. Data Modeling (Kimball)
- **Fact Tables**: Measurable events (orders, clicks, sales)
- **Dimension Tables**: Context/attributes (customers, products, dates)
- **Grain**: Atomic level of a fact (one row = one order)
- **SCD Type 2**: Historical tracking of dimension changes
- **Surrogate Keys**: Generated stable identifiers

### 3. Advanced Patterns
- **Incremental Models**: Process only new data (faster, cheaper)
- **Snapshots**: Built-in SCD Type 2 implementation
- **Macros & Jinja**: Template-based reusable SQL
- **Testing Framework**: Generic and custom tests
- **CI/CD**: Automated testing and deployment

## 💡 Pro Tips

1. **Start with DuckDB**: No cloud setup needed, great for learning
2. **Use `dbt docs serve`**: Visualize lineage while building
3. **Test frequently**: Run tests after each model
4. **Name models clearly**: stg_*, int_*, fct_*, dim_* prefixes
5. **Document as you go**: Add descriptions in YAML files
6. **Use dbt-utils**: Great macros for common patterns

## 📞 Getting Help

### Resources

1. **dbt Documentation**: https://docs.getdbt.com
2. **dbt Learn**: https://learn.getdbt.com (free interactive)
3. **dbt Slack Community**: https://community.getdbt.com
4. **Stack Overflow**: Tag your questions with `dbt`

## ✅ Quick Checklist

- [ ] Choose your data warehouse
- [ ] Install DBT with appropriate adapter
- [ ] Run `dbt debug` successfully
- [ ] Read through this README
- [ ] Review curriculum overview in `CURRICULUM.md`
- [ ] Set aside dedicated learning time

## 🚀 Start Here

1. **First**: Open `CURRICULUM.md` and read the "Curriculum Overview" section
2. **Next**: Choose your warehouse and set up DBT
3. **Then**: Start with Day 1 in `CURRICULUM.md`
4. **Build**: Complete Project 1 (E-commerce) in Days 1-3

Good luck! 🎉

---

*Last Updated: December 2024*
*Version: 1.0*
