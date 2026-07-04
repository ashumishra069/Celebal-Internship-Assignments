-- STEP 1
create database superstore_db;
use superstore_db;
-- checking whether the dataset is imported correctly or not
select * from superstore_raw
limit 5;

-- created the customer table with the columns needed for step 2 opeations
create table customers(
customer_id varchar(20) primary key,
customer_name varchar(100),
segment varchar(30));

insert into customers (customer_id, customer_name, segment)
select distinct
`Customer ID`,
`Customer Name`,
Segment
from superstore_raw;

-- checking the insertion
select * from customers
limit 5;

-- created the table orders with the columns needed for step 2 operations
create table orders (
order_id varchar(20) ,
customer_id varchar(20),
sales decimal(10,2)
);

insert into orders (order_id, customer_id, sales)
select distinct
`Order ID`,
`Customer ID`,
Sales
from superstore_raw;

-- checking the insertion
select * from orders
limit 5;

-- created the table products with the columns needed for step 2 operations
create table products (
    product_id varchar(20) ,
    product_name varchar(200),
    category varchar(50),
    sub_category varchar(50)
);

insert into products (product_id, product_name, category, sub_category)
select distinct
`Product ID`,
`Product Name`,
Category,
`Sub-Category`
 from superstore_raw;
 
-- checking the insertion 
select * from products
limit 5;

-- STEP 2
-- Q1
select *
from orders
where sales > (select avg(sales) from orders)
limit 5;

-- Q2
create index idx_customer
on orders(customer_id);
/* we created the index on customer id which is like a book,s index where the sql will search
only for the indexed one rather than whole table so it will not lose connection or time out */
 
select * from orders o
where sales = (select max(sales) from orders
where customer_id = o.customer_id)
limit 10;

-- Q3
with customer_sales as
(select customer_id, sum(sales) as total_sales from orders
group by customer_id)
select * from customer_sales
limit 10;

-- Q4
with customer_sales as
(select customer_id, sum(sales) as total_sales from orders
group by customer_id)
select * from customer_sales
where total_sales > (select avg(total_sales) from customer_sales)
limit 10;

-- Q5
with customer_sales as
(select customer_id, sum(sales) as total_sales from orders
group by customer_id)
select customer_id, total_sales, rank() over (order by total_sales desc) as customer_rank from customer_sales
limit 10;

-- Q6
select customer_id, order_id, sales, row_number()
over(partition by customer_id order by sales desc) as row_num
from orders
limit 10;

-- Q7
with customer_sales as
(select customer_id,sum(sales) as total_sales from orders
GROUP BY customer_id)

select * from (select customer_id, total_sales, rank() over (order by total_sales desc) as customer_rank
from customer_sales) as ranked_customers
where customer_rank <= 3;

-- STEP 3 FINAL COMBINED QUERY
with customer_sales as
(select customer_id,sum(sales) as total_sales from orders
group by customer_id)

select c.customer_name, cs.total_sales, rank() over (order by cs.total_sales desc) as customer_rank
from customer_sales cs
join customers c on cs.customer_id = c.customer_id
limit 10;

-- MINI PROJECT CUSTOMER SALES INSIGHTS
-- Q1
with customer_sales as
(select customer_id, sum(sales) as total_sales from orders
group by customer_id)

select c.customer_name, cs.total_sales from customer_sales cs
join customers c on cs.customer_id = c.customer_id
order by total_sales desc
limit 5;

-- Q2
with customer_sales as
(select customer_id, sum(sales) as total_sales from orders
group by customer_id)

select c.customer_name, cs.total_sales from customer_sales cs
join customers c on cs.customer_id = c.customer_id
order by total_sales asc
limit 5;

-- Q3
select c.customer_name,o.customer_id from orders o
join customers c on o.customer_id = c.customer_id
group by o.customer_id, c.customer_name
having count(distinct order_id) = 1;

-- Q4
with customer_sales as
(select customer_id,sum(sales) as total_sales from orders
group by customer_id)

select c.customer_name, cs.total_sales from customer_sales cs
join customers c on cs.customer_id = c.customer_id
where total_sales >
(select avg(total_sales) from customer_sales)
limit 10;

-- Q5
select c.customer_name,max(o.sales) as highest_order_value from orders o
join customers c on o.customer_id = c.customer_id
group by c.customer_name
order by highest_order_value desc
limit 10;