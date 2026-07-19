# Spark DataFrame Assignment

This repository contains my Week 5 internship assignment on PySpark. The goal of this assignment was to understand Spark fundamentals and perform data cleaning, transformation, filtering, aggregation, and schema modifications using Spark DataFrames.

## Objective

- Understand the limitations of MapReduce and the advantages of Spark.
- Learn Spark DataFrame concepts and immutability.
- Perform data cleaning by removing duplicates and handling null values.
- Apply filtering conditions on the dataset.
- Use aggregation functions like count, sum, average, minimum, and maximum.
- Group data using `groupBy()`.
- Modify the DataFrame schema by renaming and casting columns.
- Build a complete data processing pipeline using PySpark.

## Dataset

A custom shopping dataset containing 200 records was used. The dataset includes customer details, transaction information, product categories, store details, and intentionally contains duplicate records and missing values to demonstrate data cleaning techniques.

## Tasks Performed

- Created a Spark Session.
- Loaded the CSV dataset into a Spark DataFrame.
- Explored the dataset using `show()` and `printSchema()`.
- Removed duplicate records.
- Handled missing values using `na.fill()` and `na.drop()`.
- Applied filters based on age, subscription type, and region.
- Performed aggregations using `count()`, `sum()`, `avg()`, `min()`, and `max()`.
- Grouped data using `groupBy()`.
- Renamed columns and changed data types.
- Removed records containing null emails and empty usernames.
- Built a complete Spark data processing pipeline.

## Technologies Used

- Python
- PySpark
- Jupyter Notebook

## Conclusion

This assignment helped me understand how Spark DataFrames are used for efficient data processing. I learned how to clean, transform, and analyze data using PySpark while gaining practical knowledge of Spark's in-memory processing, DataFrame operations, and aggregation techniques.

## Author
Ashutosh Mishra
