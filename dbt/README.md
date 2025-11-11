# dbt Project: electrostore_dbt

This dbt project is configured to work with Azure SQL Server using the `dbt_debby` profile.

## Setup

This project uses **uv** for dependency management and **dbt-sqlserver** for Azure SQL connectivity.

### Prerequisites

- Python 3.12+ (managed via uv)
- ODBC Driver 18 for SQL Server (already installed)
- uv package manager (already installed)

### Installation

Dependencies are managed in the root `pyproject.toml` and installed automatically by uv:

```bash
# From the repo root (/home/eirikteigland/projects/electrostore)
uv sync
```

## Running dbt Commands

**Important:** Always use `uv run dbt` to ensure you're using the project's virtual environment.

### Basic Commands

```bash
# Check your connection and configuration
uv run dbt debug

# Compile your models (check for errors without running)
uv run dbt compile

# Run all models
uv run dbt run

# Run specific model
uv run dbt run --select my_model

# Test your models
uv run dbt test

# Generate and serve documentation
uv run dbt docs generate
uv run dbt docs serve
```

### Common Workflows

```bash
# Full refresh (rebuild all models from scratch)
uv run dbt run --full-refresh

# Run models and tests
uv run dbt build

# Run only changed models (requires state)
uv run dbt run --select state:modified+

# Run a specific directory of models
uv run dbt run --select staging.*
```

## Project Structure

```
dbt/
├── dbt_project.yml       # Project configuration
├── models/               # SQL models (transformations)
│   ├── staging/         # Raw data transformations
│   ├── intermediate/    # Business logic
│   └── marts/           # Analytics-ready models
├── seeds/               # CSV files to load
├── snapshots/           # Type-2 slowly changing dimensions
├── tests/               # Custom data tests
├── macros/              # Reusable SQL macros
├── analyses/            # Ad-hoc queries
└── README.md           # This file
```

## Configuration

### Profile Configuration

This project uses the `dbt_debby` profile defined in `~/.dbt/profiles.yml`:

```yaml
dbt_debby:
  target: dev
  outputs:
    dev:
      type: sqlserver
      driver: 'ODBC Driver 18 for SQL Server'
      server: debby-server.database.windows.net
      database: little-debby
      schema: dbt_eirik
      authentication: CLI
```

### Adding Models

1. Create a new SQL file in `models/` (e.g., `models/staging/stg_customers.sql`)
2. Use `{{ ref('model_name') }}` to reference other models
3. Add a schema file for documentation: `models/staging/schema.yml`

Example model:

```sql
-- models/staging/stg_customers.sql

{{ config(
    materialized='view',
    schema='staging'
) }}

select
    customer_id,
    email,
    created_at
from {{ source('raw', 'customers') }}
where deleted_at is null
```

### Adding Sources

Define source tables in `models/sources.yml`:

```yaml
version: 2

sources:
  - name: raw
    database: little-debby
    schema: dbo
    tables:
      - name: customers
      - name: orders
```

## dbt vs dbtf (dbt-fusion)

**Two dbt installations exist on this system:**

| Command | Uses | When to Use |
|---------|------|-------------|
| `uv run dbt` | Project venv dbt-sqlserver | **Always use this** for electrostore project |
| `dbtf` | Global dbt-fusion binary | For other projects using dbt-fusion |

The project's `.venv/bin/dbt` takes priority over the global `/home/eirikteigland/.local/bin/dbt` (dbt-fusion).

## Troubleshooting

### Connection Issues

```bash
# Test your connection
uv run dbt debug

# Common fixes:
# 1. Check profiles.yml exists: ~/.dbt/profiles.yml
# 2. Verify ODBC driver: odbcinst -q -d
# 3. Test Azure CLI auth: az account show
```

### ODBC Driver Issues

```bash
# Verify ODBC Driver 18 is installed
odbcinst -q -d | grep "ODBC Driver 18"

# If missing, install:
sudo ACCEPT_EULA=Y apt-get install -y msodbcsql18
```

### Wrong dbt Version

```bash
# Always use uv run to ensure correct version
uv run dbt --version

# Should show:
# - dbt-core: 1.10.x
# - dbt-sqlserver: 1.9.x
```

## Resources

- [dbt Documentation](https://docs.getdbt.com/)
- [dbt-sqlserver Documentation](https://docs.getdbt.com/reference/warehouse-setups/mssql-setup)
- [Azure SQL Server with dbt](https://docs.getdbt.com/reference/warehouse-setups/mssql-setup)
- [dbt Best Practices](https://docs.getdbt.com/guides/best-practices)

## Creating Models Without Examples

Unlike `dbt init`, this project was set up manually to avoid the jaffle_shop example models. To start building:

1. Define your sources in `models/sources.yml`
2. Create staging models in `models/staging/`
3. Build intermediate models in `models/intermediate/`
4. Create final marts in `models/marts/`

Example starter structure:

```
models/
├── sources.yml
├── staging/
│   ├── _staging.yml
│   └── stg_customers.sql
├── intermediate/
│   └── int_customer_orders.sql
└── marts/
    └── fct_orders.sql
```
