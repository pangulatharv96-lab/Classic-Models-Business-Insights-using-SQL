select * from customers ;
select * from employees;
select * from products;
select * from employees;
select * from offices;
select * from orderdetails;
select * from payments;
select *  from orders ;
select * from customers;


#Total revenue by year
SELECT YEAR(orderDate) AS year, ROUND(SUM(quantityOrdered * priceEach), 2) AS total_revenue
FROM orders JOIN orderdetails USING (orderNumber) GROUP BY year ORDER BY year;

#Top 5 Customers by Total Payments
SELECT customerName, SUM(amount) AS total_payments FROM customers JOIN payments USING (customerNumber) 
GROUP BY customerName ORDER BY total_payments DESC LIMIT 5;

#List the customers in the United States with a credit limit higher than \$1000.
select * from customers where country="USA" and creditlimit>1000;

#List the employee codes for sales representatives of customers in Spain, France and Italy. Make another query to list the names and email addresses of those employees.
select customerName,salesRepEmployeeNumber,customerNumber from customers where country in("USA","Spain","Italy");

#Change the job title "Sales Rep" to "Sales Representative"
use classicmodels;
select * from employees;
update employees set jobTitle="sales rep" where jobTitle="Sales Representatives";

#Delete the entries for Sales Representatives working in London.
 select * from offices;
 select * from offices where city="london";
 select * from employees where officeCode=7;
 delete from employee where officeCode=7;
 
#Show a list of employees who are not sales representatives
select * from employees where jobTitle <>"Sales Rep" ;

#Show a list of customers with "Toys" in their name
select * from customers;
select * from customers where customerName like "%toy%";

#List the 5 most expensive products from the "Planes" product line
select * from products;
select * from products where productLine="Planes" order by buyprice desc limit 5;

#Identify the products that are about to run out of stock (quantity in stock < 100)
select * from products where quantityInStock<100;

#Most Popular Product Lines
select pl.productLine, count(p.productCode) as total_products from productlines pl
join  products p using (productLine) group by pl.productLine order by total_products desc;#classicmodels

#List 10 products in the "Motorcycles" category with the lowest buy price and more than 1000 units in stock
select * from products where productLine="Motorcycles" and quantityInStock>1000 order by buyPrice limit	10;
 
 use classicmodels;
 select * from customers ;
select * from employees;
select * from payments;
select * from productlines;
select *  from orders ;
select *  from orderdetails;
select * from products;
 
 #caculate no. of payments done by every customer in each year
select year(paymentDate),customerNumber,count(customerNumber) from payments group by year(paymentDate),customerNumber;
select year(paymentDate) as years,customerNumber,count(customerNumber) from payments group by year(paymentDate),customerNumber;
select year(paymentDate) as years,customerNumber,count(customerNumber) from payments where customerNumber=471 group by year(paymentDate),customerNumber;

#count of order by every customer
select * from orders;
select customerNumber,count(orderNumber) from orders group by customerNumber;
select customerNumber,count(orderNumber) from orders  where customerNumber=181 group by customerNumber;
select customerNumber,count(orderNumber) from orders group by customerNumber having customerNumber=181;

#the column which we want show need to be included in group by  for e.g orderNumber
select orderNumber,customerNumber,count(orderNumber) from orders group by customerNumber ,orderNumber having customerNumber=181;

#total no. of payments made by each customer before october 28,2024
select customerNumber,count(checkNumber) from payments where paymentDate<"2024-10-28" group by customerNumber;
select customerNumber,count(paymentDate) from payments group by customerNumber having paymentDate<"2024-10-28";# will get error becoz we dont have column of payment date . having clause used to filetr value in column which is already group by

#calculate the total no. of unit sold for each product
select * from products;
select * from orderdetails;
select * from payments;
select productCode,sum(quantityOrdered)from orderdetails group by productCode;

 
# Report total payments for Atelier graphique.
select c.customerName,sum(p.amount) from payments p inner join customers c on c.customerNumber=p.customerNumber where customerName="Atelier graphique";

# Report the total payments by date
select paymentDate,sum(amount) from payments group by paymentDate;



# List the amount paid by each customer.
select c.customerName,sum(p.amount) from payments p inner join customers c on p.customerNumber=c.customerNumber group by customerName ;

# How many orders have been placed by Herkku Gifts?
select count(o.customerNumber),c.customerName from customers c inner join orders o on c.customerNumber=o.customerNumber where customerName="Herkku Gifts" group by customerName ;

# Who are the employees in Boston?
select * from offices;
select e.firstName,e.lastName from employees e inner join offices o on e.officeCode=o.officeCode where city="Boston";

# Report those payments greater than \$100,000. Sort the report so the customer who made the highest payment appears first.
select c.customerName,p.amount from customers c inner join payments p on c.customerNumber=p.customerNumber where amount>100000 order by amount;


-- List products sold by order date.
select *  from orders ;
select *  from orders where orderDate=shippedDate;
select *  from orderdetails;
select * from products;
select productName from products p inner join orderdetails od on od.productCode=p.productCode inner join orders o on o.orderNumber=od.orderNumber where orderDate=shippedDate;

# List the order dates in descending order for orders for the 1940 Ford Pickup Truck.
select *  from orderdetails;
select * from products;
select *  from orders;
select orderDate from orderdetails od inner join products p on  od.productCode=p.productCode inner join orders o on o.orderNumber=o.orderNumber where productName="1940 Ford Pickup Truck";

# List the names of customers and their corresponding order number where a particular order from that customer has a 13. value greater than $25,000?
select *  from orders ;
select *  from orderdetails;
select * from customers;
select o.customerNumber from orders o inner join customers c on od;

# find the first amount which is greater than average amount
select avg(amount) from payments;
select amount from payments where amount>32431.645531135546 order by amount limit 1;
#using subquery
select amount from payments where amount>(select avg(amount) from payments)order by amount limit 1;

#find 2nd highest amount
select max(amount) from payments;
select amount from payments where amount<(select max(amount) from payments) order by amount desc limit 1;
