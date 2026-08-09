# E-Commerce Data Pipeline

## Project Overview

This project is an end-to-end data pipeline for an e-commerce dataset. The main purpose of the project is to take raw CSV data, process and clean it using PySpark and Delta Lake, and finally create business-ready tables for analysis.

The project follows the Medallion Architecture:

**Landing → Bronze → Silver → Gold**

The pipeline handles four main datasets:

- Orders
- Order Items
- Customers
- Inventory

## Technologies Used

- Azure Data Lake Storage Gen2
- Azure Data Factory
- Azure Databricks
- PySpark
- Apache Spark
- Delta Lake
- Hive Metastore

## Pipeline Layers

### 1. Landing Layer

The Landing layer stores the incoming CSV data as it is received.

The four tables are:

- `orders`
- `order_items`
- `customers`
- `inventory`

Metadata such as the landing timestamp and source file name is also added.

### 2. Bronze Layer

The Bronze layer keeps a raw copy of the Landing data and adds additional ingestion metadata.

The tables are stored as Delta tables and partitioned using `load_date`.

Tables:

- `orders`
- `order_items`
- `customers`
- `inventory`

### 3. Silver Layer

The Silver layer is where most of the data cleaning and validation is performed.

The main operations include:

- Data type conversion
- Duplicate removal
- Data quality checks
- Invalid record handling
- Quarantine of rejected records

The Silver layer contains:

- `orders`
- `order_items`
- `customers`
- `inventory`
- `orders_quarantine`
- `order_items_quarantine`

Rejected orders and order items are kept in quarantine tables with a `quarantine_reason` column so that they can be corrected and replayed later.

### Customer SCD Type-1

Customers arrive as full daily snapshots.

SCD Type-1 is implemented using Delta `MERGE`.

If a customer already exists, the latest information overwrites the previous values. If the customer is new, the record is inserted.

### 4. Gold Layer

The Gold layer contains business-ready tables created from the cleaned Silver data.

The following tables were created:

- `daily_revenue`
- `fulfillment_kpi`
- `inventory_health`
- `customer_ltv`

These tables are intended for reporting and business analysis.

### Reconciliation and DQ Summary

Two additional Gold tables are created to monitor the pipeline:

- `reconciliation_row_counts`
- `reconciliation_dq_summary`

The reconciliation tables help compare row counts between the different layers.

The DQ summary contains:

- Bronze row count
- Silver row count
- Quarantined rows
- Pass rate
- Quarantine rate

## Hive Metastore

The project uses the Hive Metastore to manage the metadata of the Delta tables.

Separate databases were created for each layer:

- `ecommerce_landing`
- `ecommerce_bronze`
- `ecommerce_silver`
- `ecommerce_gold`

This makes the tables easy to access using Spark SQL and PySpark.

## Final Result

The completed pipeline takes raw e-commerce CSV files and processes them through multiple stages of validation and transformation.

The final Gold layer provides business-ready data, while the reconciliation and quarantine tables help with data quality and monitoring.

This project helped me understand practical concepts such as:

- Medallion Architecture
- PySpark
- Delta Lake
- Data Quality
- Quarantine handling
- SCD Type-1
- Gold-layer aggregations
- Reconciliation
- Hive Metastore
- Azure data engineering workflow

## Author
Ashutosh Mishra
