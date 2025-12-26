# DBT Learning Plan - Complete Index

Your complete guide to all curriculum materials organized by learning goal.

---

## 📍 Where to Start

### If you're brand new to DBT:
1. **First**: Read `README.md` (5 min) - Overview of entire program
2. **Then**: Read Day 1 in `CURRICULUM.md` (15 min) - Get oriented
3. **Next**: Set up DBT following Day 1 instructions (30 min)
4. **Finally**: Start Project 1 hands-on work

### If you're continuing from a previous day:
1. Open `CURRICULUM.md`
2. Find your current day (Days 1-10)
3. Follow the learning objectives and hands-on work
4. Reference `QUICK_REFERENCE.md` when translating SQL to DBT

### If you're troubleshooting an issue:
→ See `QUICK_REFERENCE.md` Section 9: Troubleshooting Flowchart

---

## 📚 File Guide

### Core Curriculum

| File | Purpose | Read Time | When |
|------|---------|-----------|------|
| `README.md` | Quick start & overview | 5 min | First thing |
| `CURRICULUM.md` | Full 10-day curriculum | 45 min | Browse before starting |
| `QUICK_REFERENCE.md` | SQL-to-DBT translation | 20 min | While building |
| `dbt-learning-plan-prompt.md` | Original prompt with 37+ resources | 15 min | For deep resources |

---

## 📅 10-Day Curriculum Structure

### Days 1-3: Foundations & E-commerce Project
**Files**: `CURRICULUM.md` (Days 1-3 sections)
**Key Topics**:
- DBT project structure and setup
- Model materializations (view, table, ephemeral)
- Testing and documentation
- Sources and data modeling basics

**Time**: 18-24 hours
**Deliverable**: E-commerce data warehouse with 8 models

**Quick Links in CURRICULUM.md**:
- Day 1: DBT Fundamentals & Setup
- Day 2: Models & Materializations Deep Dive
- Day 3: Testing & Documentation

---

### Days 4-7: Advanced Patterns & Analytics Platform
**Files**: `CURRICULUM.md` (Days 4-7 sections)
**Key Topics**:
- Sources and freshness management
- Slowly changing dimensions (SCD Type 2)
- Incremental models for performance
- Jinja templating and macros

**Time**: 24-32 hours
**Deliverable**: Multi-source analytics platform with 18+ models

**Quick Links in CURRICULUM.md**:
- Day 4: Sources & Freshness Management
- Day 5: SCD Type 2 & Snapshots
- Day 6: Incremental Models & Optimization
- Day 7: Jinja, Macros & Reusable Patterns

---

### Days 8-10: Production Ready & Enterprise Pipeline
**Files**: `CURRICULUM.md` (Days 8-10 sections)
**Key Topics**:
- Seeds and reference data
- Advanced testing and data quality
- CI/CD and production deployment
- Monitoring and alerting

**Time**: 18-24 hours
**Deliverable**: Production-grade pipeline with 25+ models

**Quick Links in CURRICULUM.md**:
- Day 8: Seeds & Reference Data Management
- Day 9: Testing at Scale & Data Quality
- Day 10: CI/CD & Production Deployment

---

## 🎯 Key Concepts by Location

### Materializations
**Quick Reference**: `QUICK_REFERENCE.md` Section 2
**Full Curriculum**: `CURRICULUM.md` Day 2
**Guides**: Decision tree in `QUICK_REFERENCE.md` Section 5

### Data Modeling (Kimball Methodology)
**Fundamentals**: `CURRICULUM.md` "Data Modeling Reference" section
**Examples**: `CURRICULUM.md` "3 Progressive Projects" section
**Patterns**: `QUICK_REFERENCE.md` Section 7

### Testing
**Quick Guide**: `QUICK_REFERENCE.md` Section 8
**Full Curriculum**: `CURRICULUM.md` Day 3 & Day 9
**Examples**: `QUICK_REFERENCE.md` Testing Cheat Sheet

### Jinja & Macros
**Quick Guide**: `QUICK_REFERENCE.md` Section 4
**Full Curriculum**: `CURRICULUM.md` Day 7
**Patterns**: `QUICK_REFERENCE.md` Section 11

### Slowly Changing Dimensions (SCD Type 2)
**Quick Pattern**: `QUICK_REFERENCE.md` Section 7
**Full Curriculum**: `CURRICULUM.md` Day 5
**Implementation**: Use snapshots in DBT

### Incremental Models
**Quick Pattern**: `QUICK_REFERENCE.md` Section 7
**Full Curriculum**: `CURRICULUM.md` Day 6
**Performance Tips**: `QUICK_REFERENCE.md` Section 10

### CI/CD & Deployment
**Full Curriculum**: `CURRICULUM.md` Day 10
**Quick Reference**: Check commands in `QUICK_REFERENCE.md` Section 1

---

## 🔍 Find Information By Topic

### Setup & Installation
- `README.md` - Quick start section
- `CURRICULUM.md` - Day 1: Setup instructions
- `QUICK_REFERENCE.md` - Section 12: Quick project setup

### Models & Materializations
- `CURRICULUM.md` - Day 2: Complete guide
- `QUICK_REFERENCE.md` - Section 2: Cheat sheet
- `QUICK_REFERENCE.md` - Section 5: Decision tree

### Testing & Quality
- `CURRICULUM.md` - Day 3: Introduction
- `CURRICULUM.md` - Day 9: Advanced testing
- `QUICK_REFERENCE.md` - Section 8: Testing examples

### Sources & Data Integration
- `CURRICULUM.md` - Day 4: Complete guide
- `dbt-learning-plan-prompt.md` - Sections 3-5

### Snapshots & Historical Data
- `CURRICULUM.md` - Day 5: SCD Type 2 guide
- `QUICK_REFERENCE.md` - Section 7: Pattern examples

### Performance Optimization
- `CURRICULUM.md` - Day 6: Incremental models
- `QUICK_REFERENCE.md` - Section 10: Checklist

### Jinja & Macros
- `CURRICULUM.md` - Day 7: Complete guide
- `QUICK_REFERENCE.md` - Section 4: Essentials
- `QUICK_REFERENCE.md` - Section 11: Filter examples

### SQL to DBT Translation
- `QUICK_REFERENCE.md` - Section 3: Pattern translation
- `QUICK_REFERENCE.md` - Section 4: Jinja mapping

### Troubleshooting
- `QUICK_REFERENCE.md` - Section 9: Common issues
- `README.md` - Troubleshooting section

### Commands Reference
- `QUICK_REFERENCE.md` - Section 1: Command cheat sheet
- `README.md` - Getting started commands

---

## 🚀 3 Progressive Projects

### Project 1: E-commerce Data Warehouse
**Days**: 1-3
**Complexity**: ⭐ Beginner
**Location in CURRICULUM.md**: Under "Days 1-3" → "Project 1 Deliverables"
**Key Deliverables**:
- 8 models across 3 layers
- 10+ tests
- Full documentation

### Project 2: Multi-Source Analytics Platform
**Days**: 4-7
**Complexity**: ⭐⭐ Intermediate
**Location in CURRICULUM.md**: Under "Days 4-7" → "Project 2 Deliverables"
**Key Deliverables**:
- 18+ models
- 2+ snapshots (SCD Type 2)
- Incremental fact tables

### Project 3: Production-Grade Enterprise Pipeline
**Days**: 8-10
**Complexity**: ⭐⭐⭐ Advanced
**Location in CURRICULUM.md**: Under "Days 8-10" → "Project 3 Deliverables"
**Key Deliverables**:
- 25+ models
- CI/CD pipeline
- Monitoring & alerts
- Runbook documentation

**All project specs**: See `CURRICULUM.md` section "3 Progressive Projects"

---

## 📖 Daily Learning Flow

### Each Day's Structure:
1. **Learning Objectives** (3-4 goals)
2. **Core Concepts** (explained for SQL experts)
3. **Data Modeling Focus** (Kimball methodology)
4. **Hands-On Project Work** (specific tasks)
5. **SQL Examples** (SQL-to-DBT translation)
6. **Common Pitfalls** (anti-patterns)
7. **Recommended Resources** (videos, blogs, docs)

**Location**: `CURRICULUM.md` - Find your day (Days 1-10)

---

## 🎓 Success Criteria

### By End of Curriculum:
See `CURRICULUM.md` section "Success Criteria" for complete list

**Quick Summary**:
✓ Design 3-layer data models
✓ Build testable projects
✓ Implement SCD Type 2
✓ Optimize with incremental models
✓ Deploy with CI/CD
✓ Write Jinja macros
✓ Debug pipelines
✓ Explain lineage

---

## 📚 Resource Navigation

### By Learning Style

**Video Learners**:
1. dbt Labs YouTube channel
2. See recommended videos in each day of `CURRICULUM.md`
3. Full resource list in `dbt-learning-plan-prompt.md` Section 11.B

**Hands-On Learners**:
1. Start with Project 1 immediately
2. dbt Learn Sandbox (free, pre-configured)
3. Follow daily hands-on sections in `CURRICULUM.md`

**Book/Blog Learners**:
1. Kimball Group Reader excerpts
2. Locally Optimistic blog posts
3. Full resource list in `dbt-learning-plan-prompt.md` Section 11.D

**Community Learners**:
1. dbt Slack (50,000+ members)
2. Stack Overflow (tag: dbt)
3. Full community resources in `dbt-learning-plan-prompt.md` Section 11.F

---

## 🔧 Quick Lookups

### I need to find...

**"How to set up DBT"**
→ `README.md` "Getting Started"
→ `CURRICULUM.md` "Day 1"
→ `QUICK_REFERENCE.md` Section 12

**"SQL example translated to DBT"**
→ `QUICK_REFERENCE.md` Section 3

**"Materializations compared"**
→ `QUICK_REFERENCE.md` Section 2
→ `CURRICULUM.md` Day 2

**"How to write a test"**
→ `QUICK_REFERENCE.md` Section 8
→ `CURRICULUM.md` Day 3

**"Jinja template examples"**
→ `QUICK_REFERENCE.md` Section 4
→ `QUICK_REFERENCE.md` Section 11

**"Data model design patterns"**
→ `CURRICULUM.md` "Data Modeling Reference"
→ `QUICK_REFERENCE.md` Section 7

**"Common errors and solutions"**
→ `QUICK_REFERENCE.md` Section 9

**"DBT commands"**
→ `QUICK_REFERENCE.md` Section 1

**"Learning resources by topic"**
→ `dbt-learning-plan-prompt.md` Section 11

---

## 📊 File Summary

### Total Content
- **CURRICULUM.md**: 35KB (10 daily modules + 3 projects + data modeling guide)
- **README.md**: 6KB (Quick start guide)
- **QUICK_REFERENCE.md**: 12KB (SQL-to-DBT translation + cheat sheets)
- **dbt-learning-plan-prompt.md**: 20KB (Original prompt with 37+ resources)
- **Total**: ~70KB of comprehensive curriculum

### Reading Recommendations
- **Start**: README.md (5 min)
- **Overview**: CURRICULUM.md intro (15 min)
- **Each Day**: CURRICULUM.md Day X + QUICK_REFERENCE.md as needed
- **Deep Dive**: dbt-learning-plan-prompt.md Section 11 for resources

---

## ✅ Before You Start Checklist

- [ ] Read `README.md`
- [ ] Skim `CURRICULUM.md` overview
- [ ] Bookmark `QUICK_REFERENCE.md`
- [ ] Choose your data warehouse
- [ ] Install DBT
- [ ] Run `dbt debug`
- [ ] Start Day 1 in `CURRICULUM.md`

---

## 🎯 Your Learning Journey

```
START HERE
    ↓
Read README.md (5 min)
    ↓
Choose warehouse & install DBT (30 min)
    ↓
Day 1: Setup & First Model (6-8 hrs)
    ↓
Days 2-3: Complete Project 1 (12-16 hrs)
    ↓
Days 4-7: Advanced patterns & Project 2 (24-32 hrs)
    ↓
Days 8-10: Production & Project 3 (18-24 hrs)
    ↓
YOU ARE NOW DBT READY! 🚀
```

---

## 💬 Questions?

Check these sections in order:
1. `QUICK_REFERENCE.md` Section 9 (Troubleshooting)
2. `CURRICULUM.md` Day's "Common Pitfalls" section
3. `dbt-learning-plan-prompt.md` Section 11 (Resources)
4. dbt Slack community (#questions)

---

**Total Learning Time**: 70 hours (~10 days intensive, or 1-2 weeks part-time)

**Next Step**: Open `README.md` and get started!

