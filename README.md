# 10-Day DBT Learning Plan for SQL-Strong Data Engineers

A comprehensive, hands-on learning curriculum designed specifically for data engineers with strong SQL skills who want to master DBT and learn the top 30% of features that solve 80% of real-world problems.

## Overview

This project provides a structured 10-day learning plan focused on:

- **Data modeling** using Kimball methodology within DBT
- **Practical, hands-on projects** (3 progressive real-world scenarios)
- **Top 30% DBT features** that you'll use in 80% of cases
- **Production-ready patterns** and best practices
- **Curated learning resources** including videos, courses, books, and communities

The curriculum is tailored for:
- Data engineers with **strong SQL expertise**
- Those with **weak Python coding skills** (gradual Python introduction Days 6-10)
- Learners who prefer **project-based learning**
- Professionals wanting **production-grade knowledge**

## What's Inside

```
my-dbt-learning-plan/
├── README.md                          # This file
├── dbt-learning-plan-prompt.md        # Complete curriculum prompt (ready to use)
└── (future) /curriculum/
    ├── day-1-2-fundamentals.md
    ├── day-3-testing.md
    ├── day-4-5-modeling.md
    ├── day-6-7-advanced.md
    ├── day-8-10-production.md
    ├── project-1-ecommerce/
    ├── project-2-analytics-platform/
    └── project-3-production-pipeline/
```

## Quick Start

### 1. Generate the Full Curriculum

Copy the prompt from `dbt-learning-plan-prompt.md` and paste it into your preferred LLM:
- **Claude** (https://claude.ai)
- **ChatGPT** (https://chat.openai.com)
- Or any other LLM of your choice

Then request: *"Generate the complete 10-day curriculum using this prompt"*

### 2. Choose Your Learning Path

Pick one of three learning paths based on your preference:

**Path A: Video Learner**
- Start with dbt Labs YouTube channel
- Follow Maven Analytics DBT Bootcamp
- Use YouTube resources listed in the prompt

**Path B: Hands-On Project Learner** (Recommended for SQL engineers)
- Jump directly to Project 1 (Days 1-3)
- Use dbt Learn Sandbox for immediate practice
- Reference documentation as needed

**Path C: Book/Article Learner**
- Start with Kimball Group Reader excerpts
- Read dbt blog case studies
- Progress through documentation

### 3. Set Up Your Sandbox Environment

Choose one free option:

**Easiest**: dbt Learn Sandbox
- No installation required
- Pre-configured with sample data
- Access at https://learn.getdbt.com

**Most Flexible**: DuckDB (local)
```bash
# Install DuckDB
brew install duckdb  # macOS
# or download from https://duckdb.org

# Create a project directory
mkdir my-dbt-project && cd my-dbt-project
dbt init my_project
```

**Production-Like**: Snowflake or BigQuery free tier
- Snowflake: $400 free credits
- BigQuery: 1TB/month free queries

## Curriculum Structure

### Days 1-3: Foundations (Project 1: E-Commerce)
- DBT basics and project setup
- Models and materializations (view, table, incremental)
- Writing your first tests
- **By Day 3**: Understand DAG, run your first dbt project

### Days 4-5: Data Modeling (Project 2 Begins)
- Kimball methodology deep dive
- Layered architecture (staging → intermediate → marts)
- Refs and dependencies
- Slowly Changing Dimensions (SCD Type 2)

### Days 6-7: Advanced Transformations
- Variables and Jinja templating (SQL engineers → Python intro)
- Snapshots for historical tracking
- Incremental models for performance
- Complex business logic implementation

### Days 8-10: Production & Deployment (Project 3)
- Exposures and downstream lineage
- CI/CD pipelines
- Monitoring and alerting
- Production deployment patterns

## Learning Resources Included

The prompt includes curated links to:

| Category | Resource Count | Examples |
|----------|---------------|----------|
| Official Documentation | 3 | dbt Docs, dbt Learn, GitHub |
| YouTube Channels | 9 | dbt Labs, Luke Barousse, Seattle Data Guy |
| Online Courses | 6 | Maven Analytics, DataCamp, Coursera |
| Books | 3 | Kimball Group Reader, Fundamentals of Data Engineering |
| Blogs | 3 | dbt Blog, Locally Optimistic, Fishtown Analytics |
| Practice Datasets | 8 | BigQuery, Kaggle, Jaffle Shop, Snowflake |
| Communities | 5 | dbt Slack, Discourse, Stack Overflow, Reddit |

**Total**: 37+ curated resources organized by learning style

## Success Criteria

By the end of 10 days, you should be able to:

✅ Design 3-layer data models using Kimball methodology
✅ Build testable, documented DBT projects
✅ Implement SCD Type 2 patterns for slowly changing dimensions
✅ Optimize performance with incremental models
✅ Deploy to production with CI/CD automation
✅ Debug and monitor data pipelines
✅ Write simple Jinja macros for reusable patterns
✅ Explain data lineage and model dependencies

## What You'll Learn (Top 30%)

### Must-Have DBT Features
- Models and materializations
- Tests (generic and singular)
- Sources and freshness checks
- Refs and dependencies (DAG)
- Documentation and lineage
- Variables and basic Jinja
- Snapshots (SCD Type 2)
- Seeds for reference data
- Incremental models
- CI/CD and production deployment

### Data Modeling Concepts
- Kimball dimensional modeling
- Fact and dimension tables
- Slowly changing dimensions
- Star schema design
- Grain and conformation
- Surrogate keys

### Intentionally Skipped (Not in Top 30%)
- Advanced macro development
- Custom dbt packages
- Complex Python models
- Enterprise dbt Cloud features
- Deep performance tuning

## The 3 Progressive Projects

### Project 1: E-Commerce Data Warehouse (Days 1-3)
- **Goal**: Build foundational DBT skills
- **Datasets**: Orders, customers, products
- **Models**: 5-7 simple models
- **Focus**: Models, tests, basic transformations
- **Data Source**: Thelook E-Commerce (BigQuery public dataset)

### Project 2: Multi-Source Analytics Platform (Days 4-7)
- **Goal**: Master data modeling and transformations
- **Datasets**: Sales, marketing, support channels
- **Models**: 15-20 models across layers
- **Focus**: Kimball methodology, dimensional design, intermediate models
- **Challenge**: Multi-source data integration

### Project 3: Production-Grade Pipeline (Days 8-10)
- **Goal**: Deploy enterprise-ready transformations
- **Datasets**: Real-time transaction data
- **Models**: 25+ models with monitoring
- **Focus**: Incremental models, CI/CD, monitoring, alerts
- **Challenge**: Performance optimization, data quality checks

## Prerequisites

Before starting, ensure you have:

- **SQL Skills**: Comfortable with CTEs, window functions, complex joins
- **Data Warehousing**: Basic understanding of schemas, facts, dimensions
- **Git**: Know how to clone repos, basic git workflows
- **Terminal**: Comfortable with command line basics
- **Code Editor**: VS Code or similar (optional, dbt Learn works without it)

**Python Knowledge**: Not required! Introduced gradually Days 6-10.

## Getting Started Steps

1. **Review the prompt**
   ```bash
   cat dbt-learning-plan-prompt.md
   ```

2. **Generate the curriculum**
   - Copy prompt content
   - Paste into Claude, ChatGPT, or your LLM
   - Request full curriculum output

3. **Set up sandbox**
   - Choose from dbt Learn, DuckDB, Snowflake, or BigQuery
   - Follow setup instructions in the prompt

4. **Start Day 1**
   - Read learning objectives
   - Watch recommended videos
   - Complete hands-on project tasks

5. **Track progress**
   - Follow the daily modules
   - Complete projects in order
   - Test your knowledge with provided exercises

## Recommended Learning Sequence

**Week 1 (Days 1-5): Foundations + Modeling**
- Mon-Tue: DBT fundamentals & setup
- Wed: Testing and quality assurance
- Thu-Fri: Data modeling with Kimball concepts

**Week 2 (Days 6-10): Advanced + Production**
- Mon-Tue: Advanced transformations & Python intro
- Wed-Thu: Snapshots, incremental models, performance
- Fri: Production deployment & CI/CD

## Resource Organization

Resources are organized by:

1. **Learning Style**
   - Video learners
   - Book/article readers
   - Hands-on practitioners
   - Community/Q&A seekers

2. **Topic**
   - DBT fundamentals
   - Data modeling
   - Testing and quality
   - Production & deployment

3. **Day in Curriculum**
   - Resources aligned with each day's objectives
   - Progressive complexity
   - Just-in-time learning

## Tips for Success

1. **Leverage SQL Expertise**: You already know SQL—DBT is about organizing and testing it
2. **Do Projects First**: Start with Project 1 before reading theory
3. **Join Communities**: Ask questions in dbt Slack when stuck
4. **Reference Often**: Documentation is your friend, not the curriculum
5. **Test Everything**: Write tests as you build, don't add them at the end
6. **Document as You Go**: Good docs help you learn and help teammates

## Extending Beyond 10 Days

After completing the curriculum, explore:

- **Advanced Macros**: Write custom macros for your use cases
- **Package Development**: Create reusable dbt packages
- **Performance Tuning**: Profile and optimize your slowest models
- **ML Integration**: Use dbt + Python for ML feature engineering
- **Custom Tests**: Build domain-specific data quality tests

## Troubleshooting

**"I don't have Python experience"**
- Good! Jinja isn't Python. It's simpler. Days 6-10 introduce it gradually.

**"SQL is my strong suit but I'm weak in Python"**
- Perfect! This curriculum is designed for you. SQL translates directly to DBT models.

**"I learn better by doing than reading"**
- Start with Project 1 using dbt Learn Sandbox. Jump to hands-on before videos.

**"I'm stuck on a concept"**
- Check the dbt Slack community (50K+ members) or Discourse forum—your question likely has an answer.

## Contributing

Have improvements or additional resources?
- File an issue or create a PR
- Suggest additional projects
- Add resource recommendations
- Share your learning experience

## License

This learning plan is open source and free to use, modify, and share.

## Acknowledgments

This curriculum draws from:
- Official dbt Labs documentation and best practices
- Ralph Kimball's dimensional modeling principles
- The analytics engineering community (dbt Slack, blogs, courses)
- Real-world data engineering experiences

## Next Steps

1. **Now**: Review `dbt-learning-plan-prompt.md`
2. **Today**: Generate the full curriculum with your LLM
3. **Tomorrow**: Set up your sandbox environment
4. **Day 1**: Begin the 10-day learning journey

---

**Happy learning! Questions?** Check the dbt community resources listed in the prompt or raise an issue in this repository.

*Last Updated: December 2025*