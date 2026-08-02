# Incremental Data Processing using Delta Lake (SCD Type 1)

## Overview

This project demonstrates how incremental data processing is performed using Delta Lake in Databricks. The customer master dataset was loaded from a CSV file, cleaned by removing null values and duplicate records, and stored as a Delta table. A second CSV file containing incremental customer data was then processed using the Delta Lake **MERGE** operation to update existing customer records and insert new ones, following the **Slowly Changing Dimension Type 1 (SCD Type 1)** approach. Finally, the processed data was validated by checking the row count and ensuring there were no duplicate customer IDs.

## Technologies Used

- Databricks
- Apache Spark (PySpark)
- Delta Lake

## Steps Performed

- Loaded the customer master and incremental datasets from CSV files.
- Cleaned the master dataset by removing null values and duplicate records.
- Created a Delta table from the cleaned data.
- Applied the Delta Lake **MERGE** operation to perform SCD Type 1 updates and inserts.
- Validated the final dataset by checking the row count and duplicate records.

## Author
Ashutosh Mishra
