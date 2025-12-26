# Prompt: 10-Day DBT Learning Plan for SQL-Strong Data Engineers
## (Enhanced with References & Recommended Learning Resources)

```
You are an expert DBT instructor creating a comprehensive 10-day learning plan.

## Context
- **Audience**: Data engineers with strong SQL skills but weak Python coding
- **Goal**: Master the top 30% (80/20 rule) of DBT functionality used in 80% of real-world scenarios
- **Learning Style**: Hands-on project-based learning with multiple progressive projects
- **Focus**: Include data modeling concepts specific to DBT architecture

## Requirements

### 1. Learning Path Structure
- Break down into 10 daily modules (each 6-8 hours of learning + hands-on work)
- Progress from fundamentals to production-ready skills
- Each day should have: Learning objectives, Core concepts, Data modeling principles, Hands-on project
- Leverage existing SQL knowledge while building Python confidence gradually
- Emphasize DBT-specific patterns and anti-patterns

### 2. Data Modeling Principles to Emphasize
- **Kimball methodology** applied to DBT (facts, dimensions, slowly changing dimensions)
- **Layered architecture** in DBT (staging, intermediate, marts)
- **Normalization vs. denormalization** trade-offs in DBT context
- **Grain and conformation** of facts and dimensions
- **Surrogate keys** and slowly changing dimensions (SCD Type 2)
- **Star schema** design with DBT best practices

### 3. Hands-On Projects
- Create **3 progressive real-world projects** throughout the 10 days:
  - **Project 1 (Days 1-3)**: E-commerce data warehouse (simple, foundational)
  - **Project 2 (Days 4-7)**: Multi-source analytics platform (intermediate, complex transformations)
  - **Project 3 (Days 8-10)**: Production-grade data pipeline with monitoring (advanced, enterprise patterns)
- Each project includes:
  - Sample datasets (CSV or SQL scripts provided)
  - Specific business requirements
  - Expected model architecture
  - Testing and documentation requirements

### 4. Python Integration
- Introduce Python gradually (Days 6-10 only)
- Use Python only where it adds value (not for simple SQL tasks)
- Focus on: dbt-utils macros, simple Jinja templating, dbt-python models for ML features
- Provide clear SQL-to-Jinja mapping examples
- Avoid complex Python syntax; prioritize readability

### 5. Top 30% DBT Features to Cover
**Must Include**:
- Models and materializations (view, table, incremental)
- Tests (generic and singular)
- Sources and freshness checks
- Refs and dependencies (DAG)
- Documentation and lineage
- Variables and basic Jinja
- Snapshots (SCD Type 2)
- Seeds for reference data
- Incremental models optimization
- CI/CD and production deployment

**Nice to Have** (lower priority):
- Advanced macros
- Custom packages
- dbt Cloud features
- Complex Python models

### 6. Content Delivery Format
- For each day, provide:
  1. **Learning Objectives** (3-4 clear goals)
  2. **Core Concepts** (explained for SQL experts, not beginners)
  3. **Data Modeling Focus** (Kimball concepts applicable that day)
  4. **Hands-On Project Work** (specific tasks with expected outputs)
  5. **SQL Examples** (show how SQL translates to DBT patterns)
  6. **Common Pitfalls** (anti-patterns specific to this topic)
  7. **Estimated Time**: Breakdown of time for concepts vs. hands-on
  8. **Relevant Reference Materials** (from section below)
  9. **Recommended Learning Resources** (from section below)

### 7. Project Details Needed
For each of the 3 projects, specify:
- Sample data structure (schemas, row counts)
- Business questions to answer
- Data modeling decisions (facts, dimensions, grains)
- Model count and layer structure
- Testing requirements
- Documentation expectations

### 8. Prerequisites & Setup
- Assume: SQL expertise (CTEs, window functions, joins)
- Assume: Basic understanding of data warehousing concepts
- Assume: Git basics
- Provide: Free warehouse setup options (Postgres, DuckDB, or Snowflake free tier)
- Provide: DBT version and compatibility notes

### 9. Success Criteria
By end of Day 10, learners should be able to:
- Design 3-layer data models (staging, intermediate, marts) following Kimball methodology
- Build testable, documented DBT projects
- Implement SCD Type 2 patterns for slowly changing dimensions
- Optimize performance with incremental models
- Deploy to production with CI/CD automation
- Debug and monitor data pipelines
- Write simple Jinja macros for reusable patterns
- Explain data lineage and model dependencies

### 10. Delivery Style
- Use clear, concise explanations (assume technical audience)
- Avoid fluff; focus on practical knowledge
- Use visual diagrams for: DAGs, data flow, model layering, star schemas
- Include copy-paste ready code examples for all major concepts
- Provide model solutions for projects (for self-checking)
- Add "Why this matters" sections for each major concept

---

## 11. REFERENCE MATERIALS & RECOMMENDED LEARNING RESOURCES

### A. OFFICIAL DOCUMENTATION & PRIMARY SOURCES

#### DBT Official Documentation
- **dbt Documentation Hub**: https://docs.getdbt.com
  - Core concepts guide
  - Reference documentation for all DBT features
  - Best practices and FAQ sections
  - Recommended reading path for beginners

- **dbt Learn Portal**: https://learn.getdbt.com
  - Free interactive tutorials
  - Hands-on sandbox environments
  - Beginner to intermediate level courses
  - No credit card required

- **dbt GitHub Repository**: https://github.com/dbt-labs/dbt-core
  - Source code reference
  - Issue discussions and solutions
  - Contributions and community examples

#### Data Modeling & Kimball Methodology
- **Ralph Kimball's Data Warehouse Toolkit** (Book)
  - Classic reference for dimensional modeling
  - Highly relevant for understanding facts and dimensions
  - Available on Amazon and through data engineering courses

- **Kimball Group Website**: https://www.kimballgroup.com
  - Free blog posts on dimensional design
  - Case studies and real-world examples
  - Papers on data warehouse architecture

- **DBT's Viewpoint on Kimball**: https://docs.getdbt.com/guides/best-practices/kimball-dimensional-model
  - How to implement Kimball methodology with DBT
  - Practical patterns and examples

---

### B. RECOMMENDED YOUTUBE CHANNELS & VIDEO COURSES

#### DBT-Focused YouTube Content

1. **dbt Labs Official Channel**: https://www.youtube.com/@dbtlabs
   - Weekly webinars and tutorials
   - Advanced feature walkthroughs
   - Community interviews and case studies
   - **Recommended videos**:
     - "Getting Started with dbt" (start here)
     - "Understanding Models and Materializations"
     - "Testing Your Data Transformations"
     - "Building Production-Grade Data Pipelines"

2. **Analytics Engineering Weekly** (Podcast/Video): https://www.youtube.com/@analyticsengineeringweekly
   - Deep dives into DBT features
   - Guest speakers from major data companies
   - Real-world use cases and challenges
   - **Best for**: Advanced concepts after Day 5

3. **Maven Analytics - DBT Course**: https://www.mavenanalytics.io (Premium, ~$30-50)
   - Comprehensive video course structure
   - Step-by-step project walkthroughs
   - Certificate upon completion
   - **Duration**: 8-10 hours
   - **Best for**: Structured learning alongside this curriculum

4. **Count - The Modern Data Stack**: https://www.countco.studio (YouTube)
   - Data warehouse architecture videos
   - DBT workflow tutorials
   - Performance optimization techniques
   - **Free**: All content on YouTube

5. **Seattle Data Guy** (YouTube Channel): https://www.youtube.com/@SeattleDataGuy
   - DBT project setups and configurations
   - Integration with different data warehouses
   - Real-world pipeline examples
   - **Recommended videos**:
     - "Complete DBT Setup Guide for [Your Warehouse]"
     - "DBT Testing Best Practices"

6. **Data Engineering Simplified** (YouTube): https://www.youtube.com/@dataengineeringsimplified
   - DBT fundamentals explained clearly
   - Jinja and macros for beginners
   - Data modeling concepts
   - **Good for**: SQL engineers new to DBT

---

#### Data Modeling & Dimensional Design Videos

7. **Luke Barousse - Data Engineering Academy** (YouTube): https://www.youtube.com/@LukeBarousse
   - Kimball methodology fundamentals
   - Dimensional modeling deep dive
   - Real-world data warehouse design
   - **Recommended playlists**:
     - Data Warehouse Design
     - Kimball Methodology

8. **Maven Analytics - Data Modeling Course**: https://www.mavenanalytics.io (Premium)
   - Comprehensive dimensional modeling
   - Star schema design patterns
   - Slowly changing dimensions (SCD) types
   - **Duration**: 6-8 hours

9. **Zach Wilson - Introduction to Analytics Engineering**: https://www.youtube.com/@ZachWilsonDataEng
   - Bridging SQL and DBT
   - Analytics engineering best practices
   - Practical transformation patterns
   - **Free on YouTube**

---

#### Jinja & Python for DBT Engineers

10. **dbt Labs - Jinja Tutorial**: https://learn.getdbt.com (Official)
    - Jinja basics for SQL engineers
    - Real dbt examples
    - Interactive sandbox

11. **Real Python - Jinja Template Basics**: https://realpython.com/primer-on-jinja-templating/
    - General Jinja fundamentals
    - Good foundation before advanced macros
    - Code examples and explanations

12. **DataTalks.Club - Data Engineering Zoomcamp**: https://github.com/DataTalksClub/data-engineering-zoomcamp (Free, Open Source)
    - Includes DBT modules
    - Python for data engineering
    - Comprehensive curriculum
    - **Module 4**: Transformations with DBT

---

### C. RECOMMENDED ONLINE COURSES (Comprehensive)

#### Structured, Paid Courses

1. **Maven Analytics - The Complete dbt Bootcamp** (Recommended)
   - **URL**: https://www.mavenanalytics.io/courses/complete-dbt-bootcamp
   - **Duration**: 15-20 hours
   - **Price**: $50-100
   - **Best for**: Comprehensive foundation
   - **Includes**: Video + project exercises + community support
   - **Instructor**: Aaron Mzamane (Analytics Engineering expert)

2. **DataCamp - Introduction to dbt** (Beginner-Friendly)
   - **URL**: https://www.datacamp.com/courses/introduction-to-dbt
   - **Duration**: 4-5 hours
   - **Price**: Subscription-based (~$30/month)
   - **Best for**: Quick start with interactive exercises
   - **Format**: Short videos + hands-on labs

3. **Coursera - Modern Data Stack Specialization** (Advanced)
   - **URL**: https://www.coursera.org/specializations/modern-data-stack
   - **Duration**: 3-4 months part-time
   - **Price**: $40-50/month
   - **Best for**: Comprehensive data engineering journey
   - **Includes**: DBT, data warehousing, analytics

4. **dbt Cloud Academy** (Official, Premium)
   - **URL**: https://courses.dbtuniversity.com (Coming 2025)
   - **Price**: Check dbt website
   - **Best for**: Official certification paths

#### Free Courses & Bootcamps

5. **DataTalks.Club - Data Engineering Zoomcamp**
   - **URL**: https://github.com/DataTalksClub/data-engineering-zoomcamp
   - **Duration**: 9 weeks (self-paced)
   - **Price**: FREE and open-source
   - **Best for**: Comprehensive data engineering + DBT
   - **Format**: Videos + homeworks + community support
   - **Note**: One of the best free resources available

6. **SQL Tutorial for Data Engineers** (A Cloud Guru/Pluralsight)
   - **URL**: https://www.pluralsight.com/paths/sql-for-data-engineers
   - **Duration**: 8-10 hours
   - **Price**: $30-40/month
   - **Best for**: Strengthening SQL before advanced DBT

---

### D. BOOKS & DEEP READING

#### Essential Books for This Learning Path

1. **"The Kimball Group Reader: Relentlessly Practical Tools for Data Warehousing and Business Intelligence"** (Recommended)
   - **Authors**: Ralph Kimball, Margy Ross
   - **Focus**: Foundational dimensional modeling concepts
   - **Best for**: Understanding the "why" behind data models
   - **Time to Read**: 4-6 weeks (reference, not cover-to-cover)

2. **"Fundamentals of Data Engineering"** (Helpful)
   - **Authors**: Joe Reis, Matt Housley
   - **Focus**: Modern data stack and engineering best practices
   - **Best for**: Context on where DBT fits in data architecture
   - **Time to Read**: 2-3 weeks
   - **Has**: Chapter on DBT and transformation tools

3. **"Analytics Engineering with SQL and DBT"** (Advanced, if available)
   - **Focus**: DBT-specific patterns and advanced techniques
   - **Best for**: After completing foundational days

#### Blog Posts & Articles

4. **dbt Blog**: https://blog.getdbt.com
   - Case studies from companies using DBT
   - Feature announcements and explanations
   - Industry best practices
   - **Recommended reading**: "How we think about dbt" series

5. **Locally Optimistic Blog**: https://locallyoptimistic.com
   - Analytics engineering insights
   - DBT patterns and antipatterns
   - Data modeling discussions
   - **Highly technical but practical**

6. **Fishtown Analytics Blog**: https://www.getdbt.com/blog
   - Historical DBT content
   - Strategy and best practices
   - Community contributions

---

### E. PRACTICE DATASETS & SANDBOXES

#### Free Sandbox Environments

1. **dbt Learn Sandbox**: https://learn.getdbt.com
   - Free cloud IDE for learning
   - Pre-configured datasets
   - No installation required
   - **Best for**: Days 1-3 quick start

2. **BigQuery Sandbox**: https://cloud.google.com/bigquery/docs/sandbox
   - Free BigQuery account
   - 1TB/month free queries
   - Public datasets for practice
   - **Best for**: Production-like environment

3. **Snowflake Free Trial**: https://www.snowflake.com/en/try-snowflake/
   - $400 free credits
   - Full functionality for testing
   - **Duration**: 30 days
   - **Best for**: Learning all DBT features

4. **DuckDB**: https://duckdb.org
   - Lightweight, free, embedded database
   - Perfect for local development
   - No cloud account needed
   - **Best for**: Quick prototyping and learning

5. **PostgreSQL Community**: https://www.postgresql.org/download/
   - Free, open-source database
   - Runs locally
   - Ideal for practice projects
   - **Best for**: Learning without cloud costs

#### Sample Datasets

6. **Thelook E-Commerce Dataset** (Free on BigQuery)
   - Public dataset in BigQuery
   - Perfect for Project 1 (E-commerce)
   - 4+ tables, realistic structure
   - **URL**: `bigquery-public-data.thelook_ecommerce`

7. **Kaggle Datasets**: https://www.kaggle.com/datasets
   - Thousands of free datasets
   - Filter by "e-commerce", "sales", "analytics"
   - CSVs available for import
   - **Best for**: Project 2 and 3 data

8. **dbt Jaffle Shop Sample Project**: https://github.com/dbt-labs/jaffle_shop
   - Official dbt example project
   - Complete working setup
   - Perfect template to study
   - **Clone and learn from**: Free and open-source

---

### F. COMMUNITIES & SUPPORT RESOURCES

#### Active Communities

1. **dbt Slack Community**: https://community.getdbt.com
   - 50,000+ members
   - Channel for each topic and warehouse
   - Direct access to dbt staff
   - **Best for**: Q&A and troubleshooting

2. **dbt Discourse Forum**: https://discourse.getdbt.com
   - Searchable Q&A
   - Archived solutions
   - Official responses
   - **Best for**: Finding solutions to common problems

3. **Stack Overflow** (tag: `dbt`)
   - https://stackoverflow.com/questions/tagged/dbt
   - Quick answers from community
   - Indexed by search engines

4. **Reddit - r/dataengineering**: https://www.reddit.com/r/dataengineering/
   - Discussions on DBT and modern data stack
   - Real-world problems and solutions
   - Growing community

5. **Analytics Engineering Craft Slack**: https://www.join.slack.com/t/analyticscraft/shared_invite/zt-...
   - Invite-based community
   - Focused on analytics engineering practices
   - Networking opportunities

---

### G. HANDS-ON LEARNING PATHS BY DAY

#### Day 1-2: Fundamentals & Setup
- **Primary**: dbt Learn (start here)
- **Supplement**: Seattle Data Guy "Complete DBT Setup" video
- **Reference**: dbt docs on Installation & Project Structure

#### Day 3: Testing
- **Primary**: dbt Learn - Testing module
- **Video**: dbt Labs "Testing Your Transformations" (YouTube)
- **Reference**: dbt docs on generic and singular tests

#### Day 4-5: Dependencies & Data Modeling
- **Primary**: Kimball Group website (dimensional modeling)
- **Video**: Luke Barousse - Kimball methodology (YouTube)
- **Book**: Excerpt from "Kimball Group Reader"
- **Reference**: dbt docs on refs and DAG

#### Day 6-7: Advanced Transformations & Intermediate Models
- **Video**: Analytics Engineering Weekly (advanced patterns)
- **Blog**: Locally Optimistic (DBT patterns)
- **Practice**: Jaffle Shop example project on GitHub

#### Day 8-10: Production & Deployment
- **Primary**: dbt Learn - Production setup
- **Course**: Maven Analytics Complete Bootcamp (production module)
- **Reference**: dbt docs on CI/CD and jobs
- **Practice**: DataTalks.Club Data Engineering Zoomcamp

---

### H. QUICK REFERENCE MATERIALS TO CREATE

#### Reference Guides (Include in Curriculum)

1. **SQL to Jinja Quick Reference** (1 page)
   - SQL vs. Jinja syntax
   - Common patterns
   - Escape hatches

2. **DBT Command Cheat Sheet** (1 page)
   - Most used `dbt run` variations
   - Testing commands
   - Documentation commands

3. **Data Modeling Patterns in DBT** (2 pages)
   - Star schema template
   - SCD Type 2 implementation
   - Fact/dimension patterns

4. **Troubleshooting Guide** (2-3 pages)
   - Common errors and solutions
   - Debugging techniques
   - Performance issues

---

### I. RESOURCE ORGANIZATION BY LEARNING STYLE

#### For Video Learners
1. dbt Labs YouTube channel
2. Maven Analytics DBT Bootcamp
3. Seattle Data Guy
4. Luke Barousse Kimball videos

#### For Book/Article Learners
1. Kimball Group Reader
2. Locally Optimistic blog
3. dbt Blog case studies
4. Official dbt documentation

#### For Hands-On/Project Learners
1. dbt Learn Sandbox
2. Jaffle Shop example
3. Kaggle datasets
4. DataTalks.Club Zoomcamp

#### For Community/Q&A Learners
1. dbt Slack community
2. dbt Discourse
3. Stack Overflow
4. Pluralsight Q&A forums

---

## Output Format

Create a complete 10-day curriculum with:
1. **Daily module structure** (all 10 days)
   - Include "Recommended Resources for This Day" section in each day
   - Link to specific videos, blog posts, and documentation
2. **3 full project specifications** with sample data and requirements
3. **Data modeling reference guide** for DBT (1-2 pages)
4. **Python/Jinja quick reference** for SQL engineers
5. **Troubleshooting guide** with common mistakes
6. **Master resource list** (organized by topic and learning style)
7. **Curated learning path** (how to use the resources in order)
8. **"Go Deeper" sections** for each major topic
   - Recommended YouTube video
   - Recommended blog post
   - Recommended course module
   - Recommended book excerpt
```

---

## Key Strengths of This Prompt

- **Comprehensive References**: Links to official docs, blogs, books
- **Multiple Learning Formats**: Videos, courses, books, blogs, communities
- **Organized by Day**: Resources aligned with curriculum timing
- **Learning Style Flexibility**: Options for visual, reading, hands-on, and community learners
- **Free & Paid Options**: Mix of free and premium resources
- **Real Datasets**: Practical sandbox environments and datasets
- **Community Support**: Active communities for Q&A
- **Go Deeper Sections**: For each major topic after Day 10

---

## How to Use This Prompt

1. Copy the entire prompt from the code block above
2. Paste into your preferred LLM (Claude, ChatGPT, etc.)
3. Request the full curriculum with all reference materials
4. Ask follow-ups like:
   - "Create a recommended learning sequence from the resources list"
   - "Add a daily resource consumption guide (which video to watch when)"
   - "Expand the troubleshooting guide with solutions from common Slack questions"

---

## Next Steps

1. Generate the complete curriculum using this prompt
2. Choose one of the 3 projects to start with
3. Set up a free sandbox environment (dbt Learn, DuckDB, or Postgres)
4. Follow the daily modules and hands-on projects
5. Engage with the recommended resources for deeper learning
