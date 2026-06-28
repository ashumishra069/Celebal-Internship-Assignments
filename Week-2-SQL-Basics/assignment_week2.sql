create database sales_db;
use sales_db;
CREATE TABLE customers ( 
    customer_id   INT           PRIMARY KEY, 
    first_name    VARCHAR(50)   NOT NULL, 
    last_name     VARCHAR(50)   NOT NULL, 
    email         VARCHAR(100)  UNIQUE NOT NULL, 
    city          VARCHAR(50)   NOT NULL, 
    state         VARCHAR(50)   NOT NULL, 
    join_date     DATE          NOT NULL, 
    is_premium    BOOLEAN       DEFAULT FALSE 
);
CREATE INDEX idx_customers_city ON customers(city); 
CREATE INDEX idx_customers_state ON customers(state);
CREATE TABLE products ( 
    product_id    INT           PRIMARY KEY, 
    product_name  VARCHAR(100)  NOT NULL, 
    category      VARCHAR(50)   NOT NULL, 
    brand         VARCHAR(50)   NOT NULL, 
    unit_price    DECIMAL(10,2) NOT NULL  CHECK (unit_price > 0), 
    stock_qty     INT           NOT NULL  DEFAULT 0  CHECK (stock_qty >= 0) 
); 
CREATE INDEX idx_products_category ON products(category);
CREATE TABLE orders ( 
    order_id      INT           PRIMARY KEY, 
    customer_id   INT           NOT NULL, 
    order_date    DATE          NOT NULL, 
    status        VARCHAR(20)   NOT NULL  DEFAULT 'Pending' 
                  CHECK (status IN ('Pending','Shipped','Delivered','Cancelled')), 
    total_amount  DECIMAL(12,2) NOT NULL  CHECK (total_amount >= 0), 
     
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
); 
CREATE INDEX idx_orders_date ON orders(order_date); 
CREATE INDEX idx_orders_status ON orders(status);
CREATE TABLE order_items ( 
    item_id       INT           PRIMARY KEY, 
    order_id      INT           NOT NULL, 
    product_id    INT           NOT NULL, 
    quantity      INT           NOT NULL  CHECK (quantity > 0), 
    unit_price    DECIMAL(10,2) NOT NULL  CHECK (unit_price > 0), 
    discount_pct  DECIMAL(5,2)  DEFAULT 0 CHECK (discount_pct BETWEEN 0 AND 100), 
     
    FOREIGN KEY (order_id)   REFERENCES orders(order_id), 
    FOREIGN KEY (product_id) REFERENCES products(product_id) 
); 
-- ========== INSERT: customers ========== 
INSERT INTO customers VALUES 
(101, 'Aarav',  'Sharma', 'aarav.s@email.com',  'Mumbai',    'Maharashtra', '2024-01-15', TRUE), 
(102, 'Priya',  'Patel',  'priya.p@email.com',  'Ahmedabad', 'Gujarat',     '2024-02-20', FALSE), 
(103, 'Rohan',  'Gupta',  'rohan.g@email.com',  'Delhi',     'Delhi',       '2024-03-10', TRUE), 
(104, 'Sneha',  'Reddy',  'sneha.r@email.com',  'Hyderabad', 'Telangana',   '2024-04-05', FALSE), 
(105, 'Vikram', 'Singh',  'vikram.s@email.com', 'Jaipur',    'Rajasthan',   '2024-05-12', TRUE), 
(106, 'Ananya', 'Iyer',   'ananya.i@email.com', 'Chennai',   'Tamil Nadu',  '2024-06-18', FALSE), 
(107, 'Karan',  'Mehta',  'karan.m@email.com',  'Pune',      'Maharashtra', '2024-07-22', TRUE), 
(108, 'Divya',  'Nair',   'divya.n@email.com',  'Kochi',     'Kerala',      '2024-08-30', FALSE); 


-- ========== INSERT: products ========== 
INSERT INTO products VALUES 
(201, 'Wireless Earbuds',     'Electronics', 'BoAt',          1499.00, 250), 
(202, 'Cotton T-Shirt',       'Clothing',    'Levis',         799.00,  500), 
(203, 'Smart Watch',          'Electronics', 'Noise',         2999.00, 150), 
(204, 'Running Shoes',        'Clothing',    'Nike',          4599.00, 120), 
(205, 'Bluetooth Speaker',    'Electronics', 'JBL',           3499.00, 200), 
(206, 'Bedsheet Set',         'Home',        'Spaces',        1299.00, 300), 
(207, 'Laptop Stand',         'Electronics', 'AmazonBasics',  899.00,  180), 
(208, 'Cushion Covers (Set)', 'Home',        'HomeCenter',    599.00,  400); 

-- ========== INSERT: orders ========== 
INSERT INTO orders VALUES 
(1001, 101, '2024-08-01', 'Delivered',  4498.00), 
(1002, 102, '2024-08-03', 'Delivered',  799.00), 
(1003, 103, '2024-08-05', 'Shipped',    7498.00), 
(1004, 101, '2024-08-10', 'Delivered',  3499.00), 
(1005, 104, '2024-08-12', 'Cancelled',  2999.00), 
(1006, 105, '2024-08-15', 'Delivered',  5898.00), 
(1007, 106, '2024-08-18', 'Pending',    1299.00), 
(1008, 103, '2024-08-20', 'Delivered',  899.00), 
(1009, 107, '2024-08-25', 'Shipped',    6098.00), 
(1010, 108, '2024-08-28', 'Delivered',  1598.00); 

-- ========== INSERT: order_items ========== 
INSERT INTO order_items VALUES 
(5001, 1001, 201, 2, 1499.00, 0), 
(5002, 1001, 207, 1, 899.00,  10), 
(5003, 1002, 202, 1, 799.00,  0), 
(5004, 1003, 203, 1, 2999.00, 0), 
(5005, 1003, 204, 1, 4599.00, 5), 
(5006, 1004, 205, 1, 3499.00, 0), 
(5007, 1005, 203, 1, 2999.00, 0), 
(5008, 1006, 201, 1, 1499.00, 10), 
(5009, 1006, 204, 1, 4599.00, 5), 
(5010, 1007, 206, 1, 1299.00, 0), 
(5011, 1008, 207, 1, 899.00,  0), 
(5012, 1009, 205, 1, 3499.00, 0), 
(5013, 1009, 208, 2, 599.00,  15), 
(5014, 1010, 206, 1, 1299.00, 0), 
(5015, 1010, 208, 1, 599.00,  0); 

-- Section A(SQL BASICS)
-- Q1
select * from customers;

-- Q2
select first_name,last_name,city from customers;

-- Q3
select distinct category from products;

-- Q4
DESCRIBE customers; -- primary key of customers is customer_id
DESCRIBE products;  -- primary key of products is product_id
DESCRIBE orders;    -- primary key of orders is order_id
DESCRIBE order_items;  -- primary key of order_items is item_id
/* A primary key uniquely identifies each record in a table
->No two rows can have same primary key value to avoid ambiguity
->The primary key cannot be null as if it will be null the database cannot distinguish between records
 */
 
 -- Q5
 insert into customers values(
 101, 'ashutosh',  'mishra', 'aarav.s@email.com',  'pune',    'Maharashtra', '2024-02-16', FALSE);
 /* The email column has constraint unique and not null.
 If we try to insert a duplicate email it will throw an error of duplicate entry
 */
 
 -- Q6
 insert into products values
 (209, 'charger','Electronics', 'Flipkart',  -50,  110);
 /* the error says that the products_chk_1 is violated because above the constraint 
 is give that the unit_price>0 and not null
 ( unit_price    DECIMAL(10,2) NOT NULL  CHECK (unit_price > 0))
 */
 
 -- Section B(where,indexes)
 -- Q7
 select * from orders
 where status='delivered';
 
-- Q8
select category ,unit_price from products
where category='Electronics' and unit_price>2000; 

-- Q9
select * from customers
where state ='Maharashtra';

-- Q10
select * from orders
where order_date between'2024-08-10' and '2024-08-25'  and not status='cancelled';

-- Q11
/*It helps MySQL find orders by date faster without checking every row in the table.
This improves the performance of queries that search or filter using order_date */
select * from orders
where order_date = '2024-08-15';

-- Q12
/*No the index on join_date is not used effectively because the YEAR() function changes
the original column values before MySQL compares them.Since the database has to evaluate YEAR(join_date) for every record
it cannot directly search using the index.As a result, MySQL scans all rows instead of performing a fast index lookup.
index friendly query: */
select * from customers
where join_date >= '2024-01-01' and join_date < '2025-01-01';

-- here no function is used so sql query uses index to find the matching row and gives output


-- Section C(Aggregation)

-- Q13
select count(*) AS total_orders from orders;

-- Q14
select sum(total_amount) as total_revenue from orders
where status = 'Delivered';

-- Q15
select category, avg(unit_price) as average_unit_price from products
group by category;

-- Q16
select status, count(*) as total_orders, sum(total_amount) as total_revenue from orders
group by status
order by  total_revenue desc;

-- Q17
select category,max(unit_price) as most_priced, min(unit_price) as min_priced from products
group by category;

-- Q18
select category, avg(unit_price) as avg_unit_price from products
group by category
having avg(unit_price)>2000;

-- Section D (joins)

-- Q19
select o.order_id, o.order_date, c.first_name, c.last_name, o.total_amount from orders o
inner join customers c on o.customer_id = c.customer_id;

-- Q20
select c.customer_id, c.first_name, c.last_name, o.order_id, o.order_date, o.total_amount from customers c
left join orders o on c.customer_id = o.customer_id;

-- Q21
select o.order_id, p.product_name, oi.quantity, oi.unit_price, oi.discount_pct from orders o
inner join order_items oi on o.order_id = oi.order_id
inner join products p on oi.product_id = p.product_id;

-- Q22
/*left join returns all records from the left table and matching records from the right table.
If there is no matching record the right table columns show null.
*/
select * from customers c
left join orders o on c.customer_id = o.customer_id;
-- returns all customers even those who have not placed any orders.

/* right join returns all records from the right table and matching records from the left table.
If there is no match the left table columns contain null.
*/

select * from customers c
right join orders o on c.customer_id = o.customer_id;
-- returns all orders even if a customer record is missing.

/* we will use a "FULL OUTER JOIN" when we want to see every customer and every order 
including customers without orders and orders without matching customers.*/

-- Q23
/* A foreign key relationship is a link between two tables where a column in one table
(the foreign key) refers to the primary key of another table.
In my schema there are 3 foreign key relationships which are
 child table    |     foreign key      |    parent table   |    primary key
 .orders              .customer_id           .customers        .customer_id
 .order_items         .order_id              .orders           .order_id
 .order_items         .product_id            .products         .product_id
*/ 
insert into orders values
(1011, 999, '2024-09-01', 'Pending', 1500);

-- MySQL will reject the insertion because customer_id = 999 does not exist in the customers table. 

-- Section E(case,acid,transaction)

-- Q24
select product_name, unit_price,
case
when unit_price < 1000 then 'Budget'
when unit_price between 1000 and 3000 then 'Mid-Range'
else 'Premium'
end as price_tier from products;

-- Q25
select sum(case when status = 'Delivered' then 1 else 0 end) as Delivered, 
sum(case when status <> 'Delivered' then 1 else 0 end) as Not_Delivered
from orders;

-- Q26
/*Atomicity:
  A transaction is completed fully or not at all.
  Example: If ₹100 is deducted from Account A but cannot be added to Account B, the deduction is cancelled. Money is not lost.
  Consistency:
  A transaction keeps the database in a valid state.
  Example: Before and after the transfer, the total money in both bank accounts remains the same.
  Isolation:
  Multiple transactions run simultaneously and do not interfere with each other.
  Example: If two people transfer money at the same time, each transaction is processed independently without affecting the other.
  Durability:
  Once a transaction is committed, the changes are permanent.
  Example: After a successful transfer, the updated balances remain saved even if the database server crashes
  */

-- Q27
start transaction;

-- Insert new order
insert into orders
(order_id, customer_id, order_date, status, total_amount)
values
(1011, 102, CURDATE(), 'Pending', 1598.00);

-- Insert order items
insert into order_items
(item_id, order_id, product_id, quantity, unit_price, discount_pct)
values
(5016, 1011, 206, 1, 1299.00, 0),
(5017, 1011, 208, 1, 599.00, 0);

-- Update stock
update products
set stock_qty = stock_qty - 1
where product_id = 206;

update products
set stock_qty = stock_qty - 1
where product_id = 208;

-- If all statements execute successfully
commit;

-- or else if any statement fails before COMMIT
rollback;


 