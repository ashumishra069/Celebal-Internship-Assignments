
import pandas as pd

# Load raw data
customers = pd.read_csv("data/raw/customers.csv")
products = pd.read_csv("data/raw/products.csv")
orders = pd.read_csv("data/raw/orders.csv")
order_items = pd.read_csv("data/raw/order_items.csv")

# Remove duplicate customers
customers = customers.drop_duplicates(subset="customer_id")

# Clean product names
products["product_name"] = products["product_name"].str.strip()
products["product_name"] = products["product_name"].str.title()

# Convert order dates
orders["order_date"] = pd.to_datetime(
    orders["order_date"],
    format="mixed",
    dayfirst=True,
    errors="coerce"
)

# Remove invalid order dates
orders = orders.dropna(subset=["order_date"])

# Check referential integrity
order_items = order_items[
    order_items["order_id"].isin(orders["order_id"])
]

# Save cleaned data
customers.to_csv("data/cleaned/customers_clean.csv", index=False)
products.to_csv("data/cleaned/products_clean.csv", index=False)
orders.to_csv("data/cleaned/orders_clean.csv", index=False)
order_items.to_csv("data/cleaned/order_items_clean.csv", index=False)

print("Cleaning completed")
