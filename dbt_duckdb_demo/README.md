# dbt + DuckDB Mini-Project (`dbt_duckdb_demo`)

An end-to-end learning project for **dbt Core** and **DuckDB** covering seeds, sources, staging views, Jinja macros, marts (fact & dimension tables), generic & singular data tests, SCD Type 2 snapshots, and documentation/lineage.

## Quick Commands

Run from `/Users/professorshabangu/Documents/dbt_play_ground/dbt_duckdb_demo` (with `source ../.venv/bin/activate`):

```zsh
dbt debug            # Verify DuckDB connection and configuration
dbt seed             # Load CSV files from seeds/ into main_raw schema
dbt run              # Build staging views and marts tables
dbt test             # Run all generic (YAML) and singular (SQL) tests
dbt snapshot         # Capture SCD Type 2 history in snapshots.scd_raw_orders
dbt build            # Run seeds, models, snapshots, and tests in DAG order
dbt docs generate    # Generate catalog and lineage documentation
dbt docs serve       # Open interactive documentation & lineage graph in browser
```

To inspect the resulting DuckDB database (`dev.duckdb`) directly via Python:
```zsh
python query_duckdb.py
```
