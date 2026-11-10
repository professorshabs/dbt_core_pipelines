"""Inspect the tables and views built by dbt in dev.duckdb."""
import pathlib
import duckdb

DB_PATH = pathlib.Path(__file__).parent / "dev.duckdb"

with duckdb.connect(str(DB_PATH), read_only=True) as con:
    print("=== Schemas & Relations in dev.duckdb ===")
    relations = con.sql("""
        SELECT table_schema, table_name, table_type
        FROM information_schema.tables
        ORDER BY table_schema, table_name
    """).fetchall()
    for schema, name, rtype in relations:
        print(f"  {schema}.{name} ({rtype})")

    print("\n=== main.dim_customers ===")
    con.sql("SELECT * FROM main.dim_customers ORDER BY customer_id").show()

    print("=== main.fct_orders ===")
    con.sql("SELECT * FROM main.fct_orders ORDER BY order_id").show()

    print("=== snapshots.scd_raw_orders ===")
    con.sql("""
        SELECT order_id, customer_id, status, updated_at, dbt_valid_from, dbt_valid_to
        FROM snapshots.scd_raw_orders
        ORDER BY order_id
    """).show()

