#!/bin/bash
# DBT Environment Activation Script
# Usage: source activate.sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "🚀 Activating DBT environment..."
source "$SCRIPT_DIR/dbt_env/bin/activate"
cd "$SCRIPT_DIR/dbt_project"

echo "✅ Environment activated!"
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
