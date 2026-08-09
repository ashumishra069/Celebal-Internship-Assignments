
import pandas as pd
import random
from faker import Faker

fake = Faker()

random.seed(42)
Faker.seed(42)


# Generate customers

customers = []

for i in range(600):

    customers.append([
        f"CUST{i+1:04d}",
        fake.name(),
        fake.email(),
        fake.date_between(
            start_date="2023-01-01",
            end_date="2026-08-01"
        ),
        random.choice([
            "REGULAR",
            "PREMIUM",
            "VIP"
        ])
    ])

customers = pd.DataFrame(
    customers,
    columns=[
        "customer_id",
        "customer_name",
        "email",
        "registration_date",
        "customer_type"
    ]
)

# Add duplicate customer IDs

customers.loc[598, "customer_id"] = "CUST0100"
customers.loc[599, "customer_id"] = "CUST0100"


# Generate products

categories = {
    "Books": [
        "History Book",
        "SQL Book",
        "Data Science Book",
        "Novel"
    ],
    "Home": [
        "Sofa",
        "Table",
        "Chair",
        "Curtains",
        "Pillow"
    ],
    "Clothing": [
        "Hoodie",
        "Shirt",
        "Jeans"
    ],
    "Electronics": [
        "Laptop",
        "Mobile",
        "Headphones",
        "Keyboard",
        "Mouse",
        "Monitor"
    ]
}

products = []

for i in range(600):

    category = random.choice(list(categories.keys()))

    product_name = random.choice(
        categories[category]
    )

    products.append([
        f"PROD{i+1:04d}",
        product_name,
        category,
        category + " - General",
        round(random.uniform(18, 1000), 2)
    ])

products = pd.DataFrame(
    products,
    columns=[
        "product_id",
        "product_name",
        "category",
        "subcategory",
        "cost_price"
    ]
)


# Generate orders

orders = []

for i in range(1000):

    customer_id = random.choice(
        customers["customer_id"].unique().tolist()
    )

    order_date = fake.date_time_between(
        start_date="2024-01-01",
        end_date="2026-08-01"
    )

    orders.append([
        f"ORD{i+1:05d}",
        customer_id,
        order_date,
        random.choice([
            "PLACED",
            "SHIPPED",
            "DELIVERED",
            "CANCELLED",
            "RETURNED"
        ]),
        random.choice([
            "NORTH",
            "SOUTH",
            "EAST",
            "WEST"
        ])
    ])

orders = pd.DataFrame(
    orders,
    columns=[
        "order_id",
        "customer_id",
        "order_date",
        "status",
        "region_code"
    ]
)

# Add missing customer IDs

orders.loc[:49, "customer_id"] = None

# Add invalid dates

for i in range(10):
    orders.loc[i, "order_date"] = "invalid-date"


# Generate order items

order_items = []

for i in range(2000):

    order_items.append([
        f"ITEM{i+1:06d}",
        random.choice(
            orders["order_id"].tolist()
        ),
        random.choice(
            products["product_id"].tolist()
        ),
        random.randint(1, 5),
        round(random.uniform(24, 1500), 2),
        random.choice([
            0, 5, 10, 15, 20, 25, 30
        ])
    ])

order_items = pd.DataFrame(
    order_items,
    columns=[
        "item_id",
        "order_id",
        "product_id",
        "quantity",
        "unit_price",
        "discount_percent"
    ]
)

# Add negative quantities

for i in range(60):
    order_items.loc[i, "quantity"] = -random.randint(1, 3)

# Add invalid order IDs

for i in range(20):
    order_items.loc[
        100 + i,
        "order_id"
    ] = f"INVALID{i+1:03d}"


# Save raw files

customers.to_csv(
    "data/raw/customers.csv",
    index=False
)

products.to_csv(
    "data/raw/products.csv",
    index=False
)

orders.to_csv(
    "data/raw/orders.csv",
    index=False
)

order_items.to_csv(
    "data/raw/order_items.csv",
    index=False
)

print("Synthetic datasets generated successfully")
