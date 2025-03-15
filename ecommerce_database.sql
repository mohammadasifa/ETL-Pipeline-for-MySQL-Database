#create database ecommerce_db;
USE ecommerce_db;

select * from Customers;
select * from Orders;
select * from Payment;
select * from Products;

#Write an SQL query to check if all Orders have a valid customer_id present in the Customers table.
select order_id 
from Orders 
where customer_id not in (select customer_id from customers);

# Write an SQL query to find unpaid orders (i.e., orders where no successful payment exists).
select order_id, payment_status
from Payment 
where payment_status!='Completed';

# How can you verify that each Payment record correctly references an existing order_id?
SELECT p.payment_id, p.order_id
FROM Payment p
LEFT JOIN Orders o ON p.order_id = o.order_id
WHERE o.order_id IS NULL;








# 1. Retrieve all customer details.

select * from Customers;

#List all orders with their total amount and status.

select order_id, status , sum(total_amount) as total_amount 
from Orders
group by order_id, status;

#Find all products that belong to the ‘Electronics’ category.

select * from Products
where category = "Electronics";

# Find the total number of orders placed by each customer (customer_id and count).
select c.customer_id, count(o.customer_id) as number_of_order
from Customers as c 
left join Orders as o 
on c.customer_id=o.customer_id
group by c.customer_id;

# Retrieve a list of all orders, including customer names and order status.

select CONCAT(first_name,' ', last_name) as name ,order_id, status 
from Customers as c 
join Orders as o 
on c.customer_id=o.customer_id;

# Find the total revenue (sum of all orders) generated.
select round(sum(total_amount),2) as total_revenue
from Orders;

# Identify customers who have placed more than 3 orders.
SELECT customer_id, COUNT(order_id) AS order_count
FROM Orders
GROUP BY customer_id
HAVING COUNT(order_id) > 3;

select c.customer_id, count(o.customer_id) as number_of_order
from Customers as c 
left join Orders as o 
on c.customer_id=o.customer_id
group by c.customer_id
having count(o.customer_id)>3;

# Retrieve all completed payments and include the associated order details.

select p.payment_id, o.order_date, o.total_amount, p.payment_method, p.payment_status
from Orders as o 
join Payment as p 
on o.order_id=p.order_id
where p.payment_status = 'Completed';

# Find the top 5 customers who have spent the most on orders.

select concat(first_name, ' ', last_name) as name, round(sum(total_amount),2) as total_amount 
from Customers as c 
join Orders as o 
on c.customer_id=o.customer_id
group by name 
order by total_amount desc 
limit 5;

# List all orders where the payment was either ‘Pending’ or ‘Failed’.
select o.order_id, payment_status 
from Orders as o 
join Payment as p 
on o.order_id= p.order_id 
where payment_status in ('Failed', 'Pending')
order by o.order_id;

# Find the most popular product category based on the number of orders.
select category , count(order_id) as number_of_order
from Products as p 
join Orders as o 
on p.product_id=o.product_id 
group by category
order by number_of_order desc
limit 1;

# Identify orders that were placed but have no successful payment recorded.

select o.order_id, payment_status 
from Orders as o 
join Payment as p 
on o.order_id=p.order_id
where payment_status!='Completed'
order by o.order_id;

# Calculate the average order value (AOV) per customer.
select c.customer_id, round(avg(total_amount),2) as avg_amount
from Customers as c 
join Orders as o 
on c.customer_id=o.customer_id 
group by c.customer_id;

# Identify which payment method is most commonly used.

select payment_method, count(payment_method) as count
from Payment
group by payment_method
order by count desc
limit 1;

# Determine the percentage of orders that were canceled.
SELECT 
    (COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) * 100.0 / COUNT(*)) AS canceled_percentage
FROM Orders;

# Find out the month in which the most orders were placed.
select MONTH(order_date) as Month , count(order_id) as count
from Orders 
group by MONTH(order_date)
order by MONTH(order_date), count desc
limit 1;






















