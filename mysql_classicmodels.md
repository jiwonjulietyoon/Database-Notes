The MySQL sample database schema consists of the following tables:

- **Customers**: stores customer’s data.
- **Products**: stores a list of scale model cars.
- **ProductLines**: stores a list of product line categories.
- **Orders**: stores sales orders placed by customers.
- **OrderDetails**: stores sales order line items for each sales order.
- **Payments**: stores payments made by customers based on their accounts.
- **Employees**: stores all employee information as well as the organization structure such as who reports to whom.
- **Offices**: stores sales office data.

---

![classicmodels_diagram](./classicmodels_diagram.png)



##### Employees with highest amount of total customer payments

1. Find total amount of payment per customer

   ```sql
   SELECT cus.*, pay.totalAmount
   FROM customers AS cus
   LEFT JOIN (
   	SELECT customerNumber, SUM(amount) as totalAmount
   	FROM payments
   	GROUP BY customerNumber
   ) AS pay
   USING (customerNumber);
   ```

   - => Save as view `customerpayments`

2. Find total amount of payment per employee

   ```sql
   SELECT salesRepEmployeeNumber, SUM(totalAmount)
   FROM customerpayments
   GROUP BY salesRepEmployeeNumber;
   ```

3. List all employees with each of their total payments, in the order of total payments

   ```sql
   SELECT emp.*, tot.totalAmt
   FROM employees AS emp
   LEFT JOIN (
   	SELECT salesRepEmployeeNumber, SUM(totalAmount) AS totalAmt
   	FROM customerpayments
   	GROUP BY salesRepEmployeeNumber
   ) AS tot
   ON emp.employeeNumber = tot.salesRepEmployeeNumber
   ORDER BY tot.totalAmt DESC;
   ```

   In a single query, without creating views:

   ```sql
   SELECT emp.*, tot.totalAmt
   FROM employees AS emp
   LEFT JOIN (
   	SELECT tmp.salesRepEmployeeNumber, SUM(tmp.totalAmount) AS totalAmt
   	FROM (
   		SELECT cus.*, pay.totalAmount
   		FROM customers AS cus
   		LEFT JOIN (
   			SELECT customerNumber, SUM(amount) as totalAmount
   			FROM payments
   			GROUP BY customerNumber
   		) AS pay
   		USING (customerNumber)
       ) AS tmp
   	GROUP BY salesRepEmployeeNumber
   ) AS tot
   ON emp.employeeNumber = tot.salesRepEmployeeNumber
   ORDER BY tot.totalAmt DESC;
   ```





##### Employees with most customers

```sql
SELECT emp.*, cus.cnt AS numOfCustomers
FROM employees AS emp
LEFT JOIN (
	SELECT salesRepEmployeeNumber, COUNT(*) AS cnt
    FROM customers
    GROUP BY salesRepEmployeeNumber
) AS cus
ON emp.employeeNumber = cus.salesRepEmployeeNumber
ORDER BY numOfCustomers DESC;
```



##### List of all customers with corresponding employee

```sql
SELECT cus.customerNumber, cus.customerName, cus.contactLastName, cus.contactFirstName, cus.country, cus.salesRepEmployeeNumber,
	emp.employeeNumber, emp.lastName, emp.firstName
FROM customers AS cus
LEFT JOIN employees AS emp
ON cus.salesRepEmployeeNumber = emp.employeeNumber;
```



##### 

