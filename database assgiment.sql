SHOW DATABASES;
use pw ;
''' Questions 1. Create a table called employees with the following structure?
: emp_id (integer, should not be NULL and should be a primary key)Q
: emp_name (text, should not be NULL)Q
: age (integer, should have a check constraint to ensure the age is at least 18)Q
: email (text, should be unique for each employee)Q
: salary (decimal, with a default value of 30,000).

Write the SQL query to create the above table with all constraints.
'''
CREATE TABLE employees (
    emp_id INT NOT NULL PRIMARY KEY,             -- emp_id is integer, not NULL, and is the primary key
    emp_name TEXT NOT NULL,                      -- emp_name is text, not NULL
    age INT CHECK (age >= 18),                    -- age must be at least 18
    email VARCHAR(255) UNIQUE,                   -- email is now VARCHAR(255), unique for each employee
    salary DECIMAL(10, 2) DEFAULT 30000          -- salary with a default value of 30,000 and two decimal places
);
show tables 
''' Questions 2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
examples of common types of constraints.


### Purpose of Constraints in Databases

Constraints are rules enforced on data in a database to ensure its accuracy, reliability, and integrity. They restrict the type of data that can be stored in tables and enforce certain relationships between tables. By defining constraints, a database ensures that the data adheres to specified rules, minimizing errors and inconsistencies.

### How Constraints Maintain Data Integrity

1. **Prevent Invalid Data Entry**: Constraints ensure that only valid data that meets specific criteria can be entered into the database.
2. **Enforce Relationships**: Constraints help maintain logical relationships between tables (e.g., foreign key constraints enforce relationships between tables).
3. **Maintain Consistency**: They ensure that the data remains consistent across the database, even when updates, deletions, or insertions occur.
4. **Enhance Data Reliability**: With constraints in place, users and applications can trust the data stored in the database.

---

### Common Types of Constraints

1. **Primary Key**  
   - Ensures that each row in a table is unique and not null.  
   - Example:  '''
   
     CREATE TABLE Students (
         StudentID INT PRIMARY KEY,
         Name VARCHAR(100),
         Age INT
     );
     ```
   - *Purpose*: Guarantees that no two students have the same `StudentID` and that it cannot be left blank.

2. **Foreign Key**  
   - Establishes a link between two tables, ensuring that a value in one table corresponds to a value in another.  
   - Example:  
     ```
     
     CREATE TABLE Orders (
         OrderID INT PRIMARY KEY,
         CustomerID INT,
         FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
     );
     ```
   - *Purpose*: Ensures that all `CustomerID` values in the `Orders` table exist in the `Customers` table.

3. **Unique**  
   - Ensures that all values in a column are unique.  
   - Example:  
     ```
     CREATE TABLE Employees (
         EmployeeID INT PRIMARY KEY,
         Email VARCHAR(100) UNIQUE
     );
     ```
   - *Purpose*: Prevents duplicate email addresses in the `Employees` table.

4. **Not Null**  
   - Ensures that a column cannot have a null value.  
   - Example:  
     ```
     CREATE TABLE Products (
         ProductID INT PRIMARY KEY,
         ProductName VARCHAR(100) NOT NULL
     );
     ```
   - *Purpose*: Guarantees that every product has a name.

5. **Check**  
   - Enforces a condition on the values in a column.  
   - Example:  
     ```
     CREATE TABLE Accounts (
         AccountID INT PRIMARY KEY,
         Balance DECIMAL(10, 2),
         CHECK (Balance >= 0)
     );
     ```
   - *Purpose*: Ensures that the account balance cannot be negative.

6. **Default**  
   - Assigns a default value to a column if no value is provided.  
   - Example:  
     ```
     CREATE TABLE Users (
         UserID INT PRIMARY KEY,
         JoinDate DATE DEFAULT GETDATE()
     );
     ```
   - *Purpose*: Automatically assigns the current date as the `JoinDate` if none is specified.

---

### Summary

Constraints are essential for maintaining the accuracy, consistency, and reliability of data in a database. By using constraints like **Primary Key**, **Foreign Key**, **Unique**, **Not Null**, **Check**, and **Default**, databases can enforce rules that align with business logic and ensure the integrity of stored data.'''

''' Questions 3 .Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify
Answer. ### Why Apply the **NOT NULL** Constraint?

The **NOT NULL** constraint is applied to a column when you want to ensure that every record in the table has a valid (non-null) value for that column. This is important in situations where the column is essential for the integrity of the record and the database as a whole.

**Reasons to apply the `NOT NULL` constraint:**
1. **Ensure Required Data**: For fields where data is mandatory (e.g., `employee_name`, `order_date`), the `NOT NULL` constraint guarantees that a value must always be provided.
2. **Prevent Data Integrity Issues**: Allowing `NULL` values in critical columns can lead to incomplete or inconsistent data. For example, if a `salary` column allows `NULL`, it may be difficult to perform accurate calculations or reports.
3. **Avoid Errors in Operations**: NULL values can complicate calculations, filtering, and data retrieval. The `NOT NULL` constraint helps maintain consistency and ensures that you can always work with complete data.

**Example of applying `NOT NULL`**: ```
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,  -- emp_name cannot be NULL
    emp_salary DECIMAL(10, 2) NOT NULL -- emp_salary cannot be NULL
);
```  Can a Primary Key Contain **NULL** Values?

No, a **primary key** **cannot** contain `NULL` values.

**Justification**:
1. **Uniqueness Requirement**: A primary key must uniquely identify each row in a table. If a primary key could contain `NULL`, then it would violate this requirement because `NULL` is not considered a valid value for comparison. Different rows with `NULL` values would not be distinct, which would undermine the integrity of the primary key.
   
2. **Non-Nullable**: By definition, a primary key must always have a value (not `NULL`) for every record in the table. The purpose of the primary key is to ensure that each row can be uniquely identified and retrieved, so it must always have a meaningful, non-null value.

**Example of primary key**: ```
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,   -- emp_id cannot be NULL
    emp_name VARCHAR(100)
);

''' In this example, the `emp_id` column is the primary key, so it cannot contain `NULL` values. It must have a unique value for each row.

### Conclusion:
- **NOT NULL** is applied to columns to ensure that essential data is always provided.
- A **primary key** cannot contain `NULL` values because it needs to uniquely identify each row and cannot have duplicates, including `NULL`.'''



Questions4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint.
Answer : ### Steps and SQL Commands to Add or Remove Constraints on an Existing Table

In relational databases, constraints help maintain the integrity and accuracy of the data. Sometimes, you may need to modify constraints after the table has been created, either to **add** a new constraint or **remove** an existing one. Here's an explanation of the steps and the SQL commands used to do both.

---

### 1. **Adding Constraints**

To add a constraint to an existing table, the SQL command is `ALTER TABLE`, followed by the type of constraint you want to add. Depending on the type of constraint, the SQL syntax will differ slightly.

#### Common Syntax for Adding Constraints:
```sql
ALTER TABLE table_name
ADD CONSTRAINT constraint_name constraint_type (column_name);
```

#### Example of Adding Constraints:

- **Add a `NOT NULL` Constraint**:
  If you want to ensure that a column doesn't allow `NULL` values, you can use the following syntax:

  ```sql
  ALTER TABLE employees
  MODIFY emp_name VARCHAR(100) NOT NULL;
  ```

  In this case, the `emp_name` column in the `employees` table is modified to ensure it cannot contain `NULL` values.

- **Add a `UNIQUE` Constraint**:
  To make a column unique (e.g., `email` column), ensuring no duplicate values are allowed:

  ```sql
  ALTER TABLE employees
  ADD CONSTRAINT unique_email UNIQUE (email);
  ```

  This ensures that every `email` value in the `employees` table is unique.

- **Add a `FOREIGN KEY` Constraint**:
  To create a foreign key relationship with another table:

  ```sql
  ALTER TABLE employees
  ADD CONSTRAINT fk_dept_id FOREIGN KEY (dept_id) REFERENCES departments(dept_id);
  ```

  This ensures that the `dept_id` column in the `employees` table must have values that exist in the `departments` table.

---

### 2. **Removing Constraints**

To remove a constraint from an existing table, the SQL command is again `ALTER TABLE`, but this time you use the `DROP CONSTRAINT` clause. The syntax varies depending on the type of constraint being removed.

#### Common Syntax for Removing Constraints:
```sql
ALTER TABLE table_name
DROP CONSTRAINT constraint_name;
```

#### Example of Removing Constraints:

- **Remove a `NOT NULL` Constraint**:
  If you previously applied a `NOT NULL` constraint and want to remove it (allowing `NULL` values again), the SQL command is as follows:

  ```sql
  ALTER TABLE employees
  MODIFY emp_name VARCHAR(100) NULL;
  ```

  This allows the `emp_name` column to accept `NULL` values.

- **Remove a `UNIQUE` Constraint**:
  To remove the `UNIQUE` constraint applied to a column:

  ```sql
  ALTER TABLE employees
  DROP CONSTRAINT unique_email;
  ```

  This removes the unique restriction on the `email` column, allowing duplicate email addresses.

- **Remove a `FOREIGN KEY` Constraint**:
  To remove a foreign key relationship:

  ```sql
  ALTER TABLE employees
  DROP CONSTRAINT fk_dept_id;
  ```

  This removes the foreign key relationship between the `employees` table and the `departments` table.

---

### Example Scenario: Adding and Removing Constraints

#### Scenario:
You have a table called `employees` with the following structure:
```sql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    email VARCHAR(100),
    salary DECIMAL(10, 2),
    dept_id INT
);
```

1. **Step 1: Add a UNIQUE Constraint on the `email` Column**:

```sql
ALTER TABLE employees
ADD CONSTRAINT unique_email UNIQUE (email);
```

This ensures that no two employees can have the same email address.

2. **Step 2: Add a FOREIGN KEY Constraint on the `dept_id` Column**:

Assuming you already have a `departments` table with a `dept_id` column:
```sql
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100)
);
```

Now, add the foreign key to ensure the `dept_id` in `employees` matches a valid `dept_id` in `departments`:
```sql
ALTER TABLE employees
ADD CONSTRAINT fk_dept_id FOREIGN KEY (dept_id) REFERENCES departments(dept_id);
```

3. **Step 3: Remove the `UNIQUE` Constraint on the `email` Column**:

```sql
ALTER TABLE employees
DROP CONSTRAINT unique_email;
```

This will allow employees to have duplicate email addresses in the `email` column.

4. **Step 4: Remove the `FOREIGN KEY` Constraint on the `dept_id` Column**:

```sql
ALTER TABLE employees
DROP CONSTRAINT fk_dept_id;
```

This removes the relationship between `employees` and `departments` tables, meaning `dept_id` no longer needs to reference `departments`.

---

### Summary

- **Adding Constraints**: Use `ALTER TABLE ... ADD CONSTRAINT` to add constraints like `NOT NULL`, `UNIQUE`, `FOREIGN KEY`, etc.
- **Removing Constraints**: Use `ALTER TABLE ... DROP CONSTRAINT` to remove constraints.

By using `ALTER TABLE` for adding or removing constraints, you can modify an existing table structure while preserving the integrity of the data.

Questions 5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
Provide an example of an error message that might occur when violating a constraint.
Answer : ### Consequences of Violating Constraints

When you attempt to insert, update, or delete data in a way that violates a database constraint, the following consequences can occur:

1. **Data Integrity Issues**: Violating constraints can lead to inconsistent, incorrect, or invalid data in the database. For example, inserting a `NULL` value into a column that has a `NOT NULL` constraint may result in incomplete or unreliable data.

2. **Operation Failure**: The database management system (DBMS) will prevent the operation from completing and return an error message. This prevents the invalid data from being written to the database, ensuring that the database remains consistent and adheres to its defined rules.

3. **Rollback of Transactions**: In some cases (such as in transactional systems), if an operation violates a constraint, the DBMS will automatically roll back the entire transaction to maintain data integrity. This ensures that the database remains in a consistent state and no partial data changes are made.

4. **Performance Issues**: Constantly violating constraints might indicate a poorly designed database, which can affect performance. For example, having incorrect foreign key relationships or duplicate data can cause unnecessary complexity during queries and updates.

---

### Examples of Violating Constraints

1. **Violation of a `NOT NULL` Constraint**:
   - If you attempt to insert a `NULL` value into a column that has a `NOT NULL` constraint, the DBMS will reject the operation.
   - **Example SQL Command**:
     ```sql
     INSERT INTO employees (emp_id, emp_name, email)
     VALUES (1, NULL, 'john@example.com');  -- emp_name cannot be NULL
     ```
   - **Error Message**:
     ```
     ERROR 1048 (23000): Column 'emp_name' cannot be null
     ```

2. **Violation of a `PRIMARY KEY` Constraint**:
   - If you try to insert a duplicate value into a column that has a `PRIMARY KEY` constraint, the DBMS will reject the operation because primary keys must be unique.
   - **Example SQL Command**:
     ```sql
     INSERT INTO employees (emp_id, emp_name, email)
     VALUES (1, 'John Doe', 'john@example.com');  -- emp_id must be unique
     ```
   - **Error Message**:
     ```
     ERROR 1062 (23000): Duplicate entry '1' for key 'PRIMARY'
     ```

3. **Violation of a `FOREIGN KEY` Constraint**:
   - If you try to insert a value into a foreign key column that doesn't exist in the referenced table, the DBMS will reject the operation to maintain referential integrity.
   - **Example SQL Command**:
     ```sql
     INSERT INTO employees (emp_id, emp_name, dept_id)
     VALUES (2, 'Jane Doe', 999);  -- dept_id must exist in the departments table
     ```
   - **Error Message**:
     ```
     ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails
     ```

4. **Violation of a `CHECK` Constraint**:
   - If you attempt to insert or update a value that does not meet the condition specified in a `CHECK` constraint (e.g., an age that is less than 18), the DBMS will reject the operation.
   - **Example SQL Command**:
     ```sql
     INSERT INTO employees (emp_id, emp_name, age)
     VALUES (3, 'Alice', 16);  -- age must be at least 18
     ```
   - **Error Message**:
     ```
     ERROR 3819 (HY000): Check constraint 'employees_age_check' is violated
     ```

5. **Violation of a `UNIQUE` Constraint**:
   - If you try to insert a value into a column that has a `UNIQUE` constraint, and the value already exists in the column, the DBMS will reject the operation.
   - **Example SQL Command**:
     ```sql
     INSERT INTO employees (emp_id, emp_name, email)
     VALUES (4, 'Bob Smith', 'john@example.com');  -- email must be unique
     ```
   - **Error Message**:
     ```
     ERROR 1062 (23000): Duplicate entry 'john@example.com' for key 'unique_email'
     ```

---

### Key Points:

- **Insertions**: Inserting data that violates a constraint (e.g., `NULL` where `NOT NULL` is required, or a duplicate `PRIMARY KEY`) will result in an error, and the data will not be inserted.
- **Updates**: Updating data that violates a constraint (e.g., changing a primary key to a duplicate value or setting a foreign key to a non-existent value) will cause the update to fail.
- **Deletions**: Deleting data that violates referential integrity (such as deleting a record that is referenced by a foreign key in another table) will result in an error unless `ON DELETE CASCADE` or similar rules are set for the foreign key.

---

### Conclusion:
Violating constraints results in errors that protect the database from inconsistent or invalid data. By enforcing these rules, constraints help ensure that the database maintains data integrity, consistency, and business logic.

6. You created a products table without constraints as follows:

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10, 2));  
Now, you realise that?
: The product_id should be a primary keyQ
: The price should have a default value of 50.00

 Answer : To modify the `products` table based on your requirements (making `product_id` a **primary key** and setting a default value for `price`), you can use the `ALTER TABLE` statement. Below are the steps to make the necessary changes.

### Steps to Modify the `products` Table:

1. **Make `product_id` a Primary Key**: To set the `product_id` as the primary key, use the `ALTER TABLE` statement to add the `PRIMARY KEY` constraint.
2. **Set the Default Value for `price`**: Use the `ALTER TABLE` statement to modify the `price` column and set a default value of 50.00.

### SQL Queries:

1. **Set `product_id` as Primary Key**:
   ```sql
   ALTER TABLE products
   ADD PRIMARY KEY (product_id);
   ```

2. **Set Default Value for `price`**:
   ```sql
   ALTER TABLE products
   MODIFY price DECIMAL(10, 2) DEFAULT 50.00;
   ```

### Complete Solution:
If you're executing both changes in one sequence, you can run the following SQL commands:

```sql
-- Make product_id the primary key
ALTER TABLE products
ADD PRIMARY KEY (product_id);

-- Set the default value for price
ALTER TABLE products
MODIFY price DECIMAL(10, 2) DEFAULT 50.00;
```

### Explanation:
1. **PRIMARY KEY**: This constraint ensures that the `product_id` is unique and not `NULL`, and it will be used to uniquely identify each row in the `products` table.
2. **DEFAULT**: This sets the default value of `price` to 50.00 if no value is provided during an insert operation.

By running these queries, the table will be updated to meet the requirements.


 


To fetch the `student_name` and `class_name` for each student using an **INNER JOIN** between the `Students` and `Classes` tables, the SQL query would look like this:

```sql
SELECT 
    Students.student_name,
    Classes.class_name
FROM 
    Students
INNER JOIN 
    Classes
ON 
    Students.class_id = Classes.class_id;
```

### Explanation:
1. **FROM Students**: Start with the `Students` table.
2. **INNER JOIN Classes**: Join the `Classes` table with the `Students` table.
3. **ON Students.class_id = Classes.class_id**: Match rows from both tables where the `class_id` column is the same.
4. **SELECT student_name, class_name**: Choose the columns to display in the output.

Would you like help with running this query or understanding the result?
 

Write a query to show all order_id, customer_name, and product_name, ensuring that all products are listed even if they are not associated with an order.

sql
Copy code
SELECT 
    Orders.order_id,
    Customers.customer_name,
    Products.product_name
FROM 
    Products
LEFT JOIN 
    Orders
ON 
    Products.order_id = Orders.order_id
LEFT JOIN 
    Customers
ON 
    Orders.customer_id = Customers.customer_id;
o	Use a LEFT JOIN to include all products, even those not associated with an order.
o	Chain the joins: Products → Orders → Customers.


 
Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.
sql
Copy code
SELECT 
    Products.product_name,
    SUM(Sales.amount) AS total_sales
FROM 
    Sales
INNER JOIN 
    Products
ON 
    Sales.product_id = Products.product_id
GROUP BY 
    Products.product_name;
________________________________________
Explanation:
o	Use an INNER JOIN to connect Sales and Products via product_id.
o	Use SUM() to calculate total sales grouped by product_name.


 
To display the order_id, customer_name, and the quantity of products ordered by each customer using an INNER JOIN between the three tables, the SQL query would be as follows:
SELECT 
    o.order_id,
    c.customer_name,
    SUM(od.quantity) AS total_quantity
FROM 
    Orders o
INNER JOIN 
    Customers c
ON 
    o.customer_id = c.customer_id
INNER JOIN 
    Order_Details od
ON 
    o.order_id = od.order_id
GROUP BY 
    o.order_id, c.customer_name;
Explanation:
1.	INNER JOIN:
o	Join Orders and Customers tables on customer_id.
o	Join Orders and Order_Details tables on order_id.
2.	SUM():
o	Use SUM() to calculate the total quantity of products ordered per order.
3.	GROUP BY:
o	Group by order_id and customer_name to aggregate the results correctly for each customer and their respective orders.

Here are the SQL commands and explanations for each question based on a hypothetical "Maven Movies" database structure:

```---Functions

 ### Questions 1. Identify the primary keys and foreign keys in Maven Movies DB. Discuss the differences.**

#### SQL Example:```

-- Example: Identifying primary keys and foreign keys
SELECT TABLE_NAME, COLUMN_NAME, CONSTRAINT_TYPE 
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
WHERE CONSTRAINT_SCHEMA = 'maven_movies_db';
```

#### Explanation:
- **Primary Keys**: Unique identifiers for records in a table (e.g., `actor_id`, `customer_id`, `film_id`).
- **Foreign Keys**: Establish relationships between tables by referencing primary keys in another table (e.g., `film_id` in `inventory` references `film_id` in `films`).

---

### Questions 2. List all details of actors.**

```
SELECT * FROM actors;
```

---

### Questions 3. List all customer information from the database.**

```
SELECT * FROM customers;
```

---

### Questions 4. List different countries.**

```
SELECT DISTINCT country FROM addresses;
```

---

### Questions 5. Display all active customers.**

```
SELECT * FROM customers WHERE active = 1;
```

---

### Questions 6. List all rental IDs for a customer with ID 1.**

```
SELECT rental_id FROM rentals WHERE customer_id = 1;
```

---

### Questions 7. Display all films whose rental duration is greater than 5.**

```
SELECT * FROM films WHERE rental_duration > 5;
```

---

### Questions 8. List the total number of films whose replacement cost is greater than $15 and less than $20.**

```
SELECT COUNT(*) AS total_films 
FROM films 
WHERE replacement_cost > 15 AND replacement_cost < 20;
```

---

### Questions 9. Display the count of unique first names of actors.**

```
SELECT COUNT(DISTINCT first_name) AS unique_first_names 
FROM actors;
```

---

### Questions 10. Display the first 10 records from the customer table.**

```
SELECT * FROM customers LIMIT 10;
```

---

### Questions 11. Display the first 3 records from the customer table whose first name starts with ‘B’.**

```
SELECT * 
FROM customers 
WHERE first_name LIKE 'B%' 
LIMIT 3;
```

---

### Questions 12. Display the names of the first 5 movies rated as ‘G’.**

```
SELECT title 
FROM films 
WHERE rating = 'G' 
LIMIT 5;
```

---

### Questions 13. Find all customers whose first name starts with "A".**

```
SELECT * 
FROM customers 
WHERE first_name LIKE 'A%';
```

---

### Questions 14. Find all customers whose first name ends with "A".**

```
SELECT * 
FROM customers 
WHERE first_name LIKE '%A';
```

---

### Questions 15. Display the list of the first 4 cities that start and end with ‘A’.**

```
SELECT DISTINCT city 
FROM addresses 
WHERE city LIKE 'A%' AND city LIKE '%A' 
LIMIT 4;
```

---

### Questions 16. Find all customers whose first name has "NI" in any position.**

```
SELECT * 
FROM customers 
WHERE first_name LIKE '%NI%';
```

---

### Questions 17. Find all customers whose first name has "R" in the second position.**

```
SELECT * 
FROM customers 
WHERE first_name LIKE '_R%';
```

---

### Questions 18. Find all customers whose first name starts with "A" and is at least 5 characters in length.**

```
SELECT * 
FROM customers 
WHERE first_name LIKE 'A%' AND LENGTH(first_name) >= 5;
```

---

### Questions 19. Find all customers whose first name starts with "A" and ends with "O".**

```
SELECT * 
FROM customers 
WHERE first_name LIKE 'A%O';
```

---

### Questions 20. Get the films with PG and PG-13 ratings using the IN operator.**

```
SELECT * 
FROM films 
WHERE rating IN ('PG', 'PG-13');


---

``` ### Questions 21. Get the films with lengths between 50 to 100 using the BETWEEN operator.**```


SELECT * 
FROM films 
WHERE length BETWEEN 50 AND 100;


---

``` ### Questions 22. Get the top 50 actors using the LIMIT operator.** ```


SELECT * 
FROM actors 
LIMIT 50;


---

``` ### Questions 23. Get the distinct film IDs from the inventory table.**  ```


SELECT DISTINCT film_id 
FROM inventory;

``` Here are the SQL queries for the given questions:

---

### **Basic Aggregate Functions**

#### Question1. Retrieve the total number of rentals made in the Sakila database.**

```
SELECT COUNT(*) AS total_rentals 
FROM rental;
```

---

#### Question2. Find the average rental duration (in days) of movies rented from the Sakila database.**

```
SELECT AVG(rental_duration) AS average_rental_duration 
FROM film;
```

---

### **String Functions**

#### Question 3. Display the first name and last name of customers in uppercase.**

```
SELECT UPPER(first_name) AS first_name_uppercase, 
       UPPER(last_name) AS last_name_uppercase 
FROM customer;
```

---

#### Question 4. Extract the month from the rental date and display it alongside the rental ID.**

```
SELECT rental_id, 
       MONTH(rental_date) AS rental_month 
FROM rental;
```

---

### **GROUP BY**

#### Question 5. Retrieve the count of rentals for each customer (display customer ID and the count of rentals).**

```
SELECT customer_id, 
       COUNT(*) AS rental_count 
FROM rental 
GROUP BY customer_id;
```

---

#### Question 6. Find the total revenue generated by each store.**

```
SELECT store_id, 
       SUM(amount) AS total_revenue 
FROM payment 
GROUP BY store_id;
```

---

#### Question 7. Determine the total number of rentals for each category of movies.**

```
SELECT fc.category_id, 
       c.name AS category_name, 
       COUNT(r.rental_id) AS total_rentals 
FROM film_category fc
JOIN category c ON fc.category_id = c.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY fc.category_id, c.name;
```

---

#### Question 8. Find the average rental rate of movies in each language.**

```
SELECT l.language_id, 
       l.name AS language_name, 
       AVG(f.rental_rate) AS average_rental_rate 
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.language_id, l.name;

  

---
```
### Question 9. Display the title of the movie, customer's first name, and last name who rented it.**
```
sql
SELECT f.title AS movie_title, 
       c.first_name AS customer_first_name, 
       c.last_name AS customer_last_name
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id;
```

---

### **10. Retrieve the names of all actors who have appeared in the film "Gone with the Wind."**

```sql
SELECT a.first_name AS actor_first_name, 
       a.last_name AS actor_last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';
```

---

### **11. Retrieve the customer names along with the total amount they've spent on rentals.**

```sql
SELECT c.first_name AS customer_first_name, 
       c.last_name AS customer_last_name, 
       SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;
```

---

### **12. List the titles of movies rented by each customer in a particular city (e.g., 'London').**

```sql
SELECT c.first_name AS customer_first_name, 
       c.last_name AS customer_last_name, 
       ci.city AS customer_city, 
       f.title AS movie_title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
GROUP BY c.customer_id, c.first_name, c.last_name, ci.city, f.title;
```  
### **13. Display the top 5 rented movies along with the number of times they've been rented.**

```
SELECT f.title AS movie_title, 
       COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 5;
```

---

### **14. Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).**

```sql
SELECT c.customer_id, 
       c.first_name AS customer_first_name, 
       c.last_name AS customer_last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2;


---
```
### **Explanation**

- **Query 13**: 
  - Counts the number of rentals for each movie by joining the `film`, `inventory`, and `rental` tables.  
  - Results are grouped by `film_id` and ordered in descending order of rentals, limiting the output to the top 5.

- **Query 14**:
  - Identifies customers who have rented from both store IDs 1 and 2.  
  - The `HAVING COUNT(DISTINCT i.store_id) = 2` ensures that the customer has rentals from **both** stores. ```
  
 ``` ### Questions 1. Rank the customers based on the total amount they've spent on rentals.**```


SELECT c.customer_id, 
       c.first_name AS customer_first_name, 
       c.last_name AS customer_last_name, 
       SUM(p.amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(p.amount) DESC) AS customer_rank
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;
```

---

### Questions2. Calculate the cumulative revenue generated by each film over time.**

```
SELECT f.title AS film_title, 
       p.payment_date, 
       SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY p.payment_date) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id;
```

---

### Questions 3. Determine the average rental duration for each film, considering films with similar lengths.**

```
SELECT f.title AS film_title, 
       f.length, 
       AVG(f.rental_duration) OVER (PARTITION BY f.length) AS average_rental_duration
FROM film f;
```

---

### Questions 4. Identify the top 3 films in each category based on their rental counts.**

```
SELECT c.name AS category_name, 
       f.title AS film_title, 
       COUNT(r.rental_id) AS rental_count,
       RANK() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS rank_in_category
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, c.name, f.film_id, f.title
HAVING rank_in_category <= 3;
```

---

### Questions 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals.**

```
SELECT c.customer_id, 
       c.first_name AS customer_first_name, 
       c.last_name AS customer_last_name, 
       COUNT(r.rental_id) AS total_rentals,
       AVG(COUNT(r.rental_id)) OVER () AS average_rentals,
       COUNT(r.rental_id) - AVG(COUNT(r.rental_id)) OVER () AS rental_difference
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;
```

---

### Questions 6. Find the monthly revenue trend for the entire rental store over time.**

```
SELECT DATE_FORMAT(p.payment_date, '%Y-%m') AS revenue_month, 
       SUM(p.amount) AS monthly_revenue,
       SUM(SUM(p.amount)) OVER (ORDER BY DATE_FORMAT(p.payment_date, '%Y-%m')) AS cumulative_revenue
FROM payment p
GROUP BY DATE_FORMAT(p.payment_date, '%Y-%m');
```

---

### Questions 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.**

```
WITH CustomerSpending AS (
    SELECT c.customer_id, 
           c.first_name, 
           c.last_name, 
           SUM(p.amount) AS total_spent
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
),
Top20Percent AS (
    SELECT PERCENT_RANK() OVER (ORDER BY total_spent DESC) AS spending_rank, 
           customer_id, 
           first_name, 
           last_name, 
           total_spent
    FROM CustomerSpending
)
SELECT customer_id, 
       first_name, 
       last_name, 
       total_spent
FROM Top20Percent
WHERE spending_rank <= 0.2;
```

---

### Questions 8. Calculate the running total of rentals per category, ordered by rental count.**

```
SELECT c.name AS category_name, 
       COUNT(r.rental_id) AS rental_count,
       SUM(COUNT(r.rental_id)) OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id)) AS running_total
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, c.name;
```

---

### Questions 9. Find the films that have been rented less than the average rental count for their respective categories.**

```
SELECT c.name AS category_name, 
       f.title AS film_title, 
       COUNT(r.rental_id) AS rental_count,
       AVG(COUNT(r.rental_id)) OVER (PARTITION BY c.category_id) AS average_rental_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, c.name, f.film_id, f.title
HAVING rental_count < average_rental_count;
```

---

### Questions 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.**

```
SELECT DATE_FORMAT(p.payment_date, '%Y-%m') AS revenue_month, 
       SUM(p.amount) AS monthly_revenue
FROM payment p
GROUP BY DATE_FORMAT(p.payment_date, '%Y-%m')
ORDER BY monthly_revenue DESC
LIMIT 5;
I'll address your normalization and CTE-related questions systematically using the Sakila database schema assumptions and practices. If required, I can reference the uploaded SQL file to verify specifics.

---

### **1. First Normal Form (1NF)**

#### **a. Identify a table in the Sakila database that violates 1NF.**

A table violates 1NF if:
- It contains repeating groups or arrays (e.g., multiple values in a single column).
- There is no unique identifier (primary key).

Example: **`address` table**
- Suppose `address` allows multiple phone numbers in a single column separated by commas, like `"123-456-7890, 987-654-3210"`.

#### **Normalization to 1NF:**
1. Remove repeating groups by creating a new table, e.g., `phone_number`.
2. Ensure each phone number is stored in a separate row.

**Normalized Structure:**
- **Original Table:**  
  `address (address_id, phone_numbers)`
  
- **Normalized Tables:**  
  `address (address_id, address_details)`  
  `phone_number (phone_id, address_id, phone_number)`

---

### **2. Second Normal Form (2NF)**

#### **a. Choose a table and determine if it is in 2NF.**

To achieve 2NF:
- It must first satisfy 1NF.
- All non-key attributes must depend on the entire primary key (no partial dependency).

Example: **`film_actor` table**  
Primary Key: `(film_id, actor_id)`  
Violation: If `actor_bio` is included in this table, it depends only on `actor_id` (partial dependency).

#### **Normalization to 2NF:**
1. Remove attributes that do not depend on the entire primary key.
2. Create a separate table for attributes related only to `actor_id`.

**Normalized Tables:**
- **Original Table:**  
  `film_actor (film_id, actor_id, actor_bio)`
  
- **Normalized Tables:**  
  `film_actor (film_id, actor_id)`  
  `actor_details (actor_id, actor_bio)`

---

### **3. Third Normal Form (3NF)**

#### **a. Identify a table violating 3NF.**

A table violates 3NF if:
- It contains transitive dependencies (non-key attributes depending on other non-key attributes).

Example: **`customer` table**  
- Attributes: `customer_id`, `store_id`, `store_address`  
- `store_address` depends on `store_id`, not `customer_id` (transitive dependency).

#### **Normalization to 3NF:**
1. Remove transitive dependencies.
2. Create a new table for `store` attributes.

**Normalized Tables:**
- **Original Table:**  
  `customer (customer_id, store_id, store_address)`
  
- **Normalized Tables:**  
  `customer (customer_id, store_id)`  
  `store (store_id, store_address)`

---

### **4. Normalization Process**

#### **Example Table: `rental`**

**Unnormalized Form (UNF):**
- Repeating groups: Rental information and customer details in one table.

**Normalization Steps:**
1. **To 1NF:**  
   - Split repeating groups into separate tables (e.g., customer and rental).
2. **To 2NF:**  
   - Remove partial dependencies (e.g., separating store details).
3. **To 3NF:**  
   - Remove transitive dependencies (e.g., customer and store in separate tables).

**Normalized Tables:**
- `rental (rental_id, rental_date, inventory_id, customer_id)`  
- `customer (customer_id, customer_name)`  
- `store (store_id, store_address)`

---

### **5. CTE Basics**

```sql
WITH ActorFilms AS (
    SELECT a.actor_id, 
           CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
           COUNT(fa.film_id) AS film_count
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id
)
SELECT DISTINCT actor_name, film_count
FROM ActorFilms;
```

---

### **6. CTE with Joins**

```sql
WITH FilmLanguage AS (
    SELECT f.title AS film_title, 
           l.name AS language_name, 
           f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT * FROM FilmLanguage;
```

---

### **7. CTE for Aggregation**

```sql
WITH CustomerRevenue AS (
    SELECT c.customer_id, 
           CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
           SUM(p.amount) AS total_revenue
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id
)
SELECT * FROM CustomerRevenue;
```

---

### **8. CTE with Window Functions**

```sql
WITH FilmRanking AS (
    SELECT f.film_id, 
           f.title, 
           f.rental_duration,
           RANK() OVER (ORDER BY f.rental_duration DESC) AS rank_by_duration
    FROM film f
)
SELECT * FROM FilmRanking;
```

---

### **9. CTE and Filtering**

```sql
WITH FrequentRenters AS (
    SELECT c.customer_id, 
           COUNT(r.rental_id) AS rental_count
    FROM customer c
    JOIN rental r ON c.customer_id = r.customer_id
    GROUP BY c.customer_id
    HAVING COUNT(r.rental_id) > 2
)
SELECT fr.*, c.first_name, c.last_name 
FROM FrequentRenters fr
JOIN customer c ON fr.customer_id = c.customer_id;
```

---

### **10. CTE for Date Calculations**

```sql
WITH MonthlyRentals AS (
    SELECT DATE_FORMAT(r.rental_date, '%Y-%m') AS rental_month,
           COUNT(*) AS total_rentals
    FROM rental r
    GROUP BY DATE_FORMAT(r.rental_date, '%Y-%m')
)
SELECT * FROM MonthlyRentals;
```

---

### **11. CTE and Self-Join**

```sql
WITH ActorPairs AS (
    SELECT fa1.actor_id AS actor1_id, 
           fa2.actor_id AS actor2_id, 
           fa1.film_id
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
    WHERE fa1.actor_id < fa2.actor_id
)
SELECT DISTINCT a1.first_name AS actor1_name, 
                a2.first_name AS actor2_name
FROM ActorPairs ap
JOIN actor a1 ON ap.actor1_id = a1.actor_id
JOIN actor a2 ON ap.actor2_id = a2.actor_id;
```

---

### **12. CTE for Recursive Search**

```sql
WITH RECURSIVE EmployeeHierarchy AS (
    SELECT s.staff_id, s.first_name, s.reports_to
    FROM staff s
    WHERE s.reports_to = <manager_id>
    UNION ALL
    SELECT s.staff_id, s.first_name, s.reports_to
    FROM staff s
    JOIN EmployeeHierarchy eh ON s.reports_to = eh.staff_id
)
SELECT * FROM EmployeeHierarchy;
