# Week 6 - Spark Intro

## Objective

The objective of this assignment was to understand Apache Spark architecture and perform data processing using PySpark. The assignment focused on Spark DataFrames, transformations, filtering, schema handling, file formats, and basic performance optimization concepts.

## Work Completed

During this assignment, I worked on:

* Spark architecture: Driver, Cluster Manager, and Executors
* Client Mode and Cluster Mode
* Lazy Evaluation and DAG (Lineage Graph)
* Reading CSV and Parquet files
* DataFrame filtering and column selection
* Renaming columns and casting data types
* Creating new calculated columns
* Handling null values
* Transformations and Actions
* Wide transformations and Shuffle
* Predicate Pushdown
* CSV vs Parquet performance
* Building a Read → Transform → Filter → Write pipeline
* Saving processed data in CSV and Parquet formats
* Understanding why `show()` is preferred over `collect()` for large datasets

## Dataset

A sample product transaction dataset was used for the assignment. It contains fields such as product ID, category, price, quantity, transaction status, region, priority, and user ID.

The dataset also contains some null values so that data-cleaning and filtering operations can be performed using Spark.

## Tools Used

* Python
* PySpark
* Apache Spark
* Jupyter Notebook
* Google Colab

## Execution Environment

Most of the assignment was completed locally using Jupyter Notebook on Windows.

During Parquet and output file operations, the local Spark environment encountered a Windows Hadoop configuration (`HADOOP_HOME`) issue. Therefore, Google Colab was used for the Parquet-related execution and the final data pipeline.

The pipeline was successfully executed in Colab and the processed data was saved in both CSV and Parquet formats.

## Key Learning

This assignment helped in understanding how Spark processes data and how Lazy Evaluation and DAG help optimize execution. It also demonstrated how transformations, filtering, null handling, and schema changes can be performed using Spark DataFrames.

Parquet was found to be more suitable for analytical workloads because of its columnar storage and support for optimizations such as Predicate Pushdown. The assignment also highlighted the importance of reducing unnecessary shuffles and avoiding `collect()` when working with very large datasets.

## Final Pipeline

The final Spark pipeline followed:

**Read → Transform → Handle Nulls → Filter → Write**

The processed output was successfully generated in both CSV and Parquet formats.

## Author
Ashutosh Mishra

