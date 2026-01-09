#!/bin/bash
# DBT Environment Activation Script
# Usage: source activate.sh

PROJECT_ROOT="/Users/skarangi/projects/trainings/my-dbt-learning-plan"

echo "🚀 Activating DBT environment..."
source "$PROJECT_ROOT/dbt_env/bin/activate"

# Change to dbt_project directory - this affects the current shell when sourced
cd "$PROJECT_ROOT/dbt_project" || exit 1

echo "✅ Environment activated!"
echo "📍 Location: $(pwd)"
echo ""
echo "Available commands:"
echo "  dbt debug                              - Test database connection"
echo "  dbt parse                              - Check for syntax errors"
echo "  dbt run                                - Execute all models"
echo "  dbt test                               - Run all tests"
echo "  dbt docs generate && dbt docs serve    - View documentation (http://localhost:8000)"
echo ""
echo "Quick start: dbt debug"
echo ""
