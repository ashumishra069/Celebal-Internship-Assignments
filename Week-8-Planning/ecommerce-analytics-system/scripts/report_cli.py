
import sqlite3
import pandas as pd
import argparse

def run_report(report_name):

    try:
        conn = sqlite3.connect("ecommerce.db")

        if report_name == "revenue":

            query = """
            SELECT
                strftime('%Y-%m', o.order_date) AS month,
                SUM(
                    oi.quantity * oi.unit_price *
                    (1 - oi.discount_percent / 100.0)
                ) AS revenue
            FROM orders o
            JOIN order_items oi
                ON o.order_id = oi.order_id
            GROUP BY month
            ORDER BY month
            """

        elif report_name == "top_customers":

            query = """
            SELECT
                c.customer_id,
                c.customer_name,
                SUM(
                    oi.quantity * oi.unit_price *
                    (1 - oi.discount_percent / 100.0)
                ) AS total_spend
            FROM customers c
            JOIN orders o
                ON c.customer_id = o.customer_id
            JOIN order_items oi
                ON o.order_id = oi.order_id
            GROUP BY c.customer_id, c.customer_name
            ORDER BY total_spend DESC
            LIMIT 10
            """

        elif report_name == "retention":

            query = """
            SELECT
                strftime('%Y-%m', order_date) AS purchase_month,
                COUNT(DISTINCT customer_id) AS active_customers
            FROM orders
            WHERE customer_id IS NOT NULL
            GROUP BY purchase_month
            ORDER BY purchase_month
            """

        else:
            print("Invalid report name")
            return

        result = pd.read_sql(query, conn)

        if result.empty:
            print("No results found")
        else:
            print(result.to_string(index=False))

        conn.close()

    except sqlite3.Error:
        print("Database connection failed")


parser = argparse.ArgumentParser(
    description="E-Commerce Analytics Reporting Tool"
)

parser.add_argument(
    "--report",
    choices=["revenue", "top_customers", "retention"],
    required=True
)

args = parser.parse_args()

run_report(args.report)
