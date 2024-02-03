--1 Create a new user with the username "rentaluser" and the password "rentalpassword". Give the user the ability to connect to the database but no other permissions.
CREATE USER rental_user WITH PASSWORD 'rental_password';
GRANT CONNECT ON DATABASE dvdrental TO rental_user;
--2 Grant "rentaluser" SELECT permission for the "customer" table. Сheck to make sure this permission works correctly—write a SQL query to select all customers.
GRANT SELECT ON customer TO rental_user;
--3 Create a new user group called "rental" and add "rentaluser" to the group. 
CREATE ROLE rental;
GRANT rental TO rental_user;
--4 Grant the "rental" group INSERT and UPDATE permissions for the "rental" table. Insert a new row and update one existing row in the "rental" table under that role.
GRANT INSERT, SELECT, UPDATE ON TABLE rental TO rental;

 SET ROLE rentaluser;
 SHOW ROLE;
 
 INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
 VALUES (CURRENT_DATE , 119, 222, CURRENT_DATE , 3, NOW());
 
 UPDATE rental SET return_date = '2024-02-04' WHERE rental_id = 1;
 
 RESET ROLE;
--5 Revoke the "rental" group's INSERT permission for the "rental" table. Try to insert new rows into the "rental" table make sure this action is denied.
 REVOKE INSERT ON TABLE rental FROM rental;

  SET ROLE rentaluser;
  SHOW ROLE;
  
  INSERT INTO rental(rental_date,inventory_id , customer_id, return_date,staff_id ,last_update)
  VALUES(CURRENT_DATE , 333, 444, CURRENT_DATE, 3, NOW());
  
  RESET ROLE;
--6 Create a personalized role for any customer already existing in the dvd_rental database. The name of the role name must be client_{first_name}_{last_name} (omit curly brackets). The customer's payment and rental history must not be empty. Configure that role so that the customer can only access their own data in the "rental" and "payment" tables. Write a query to make sure this user sees only their own data.
CREATE VIEW rental_customer AS
SELECT *
FROM rental
WHERE customer_id = 16;

CREATE VIEW payment_customer AS
SELECT *
FROM payment
WHERE customer_id = 16;

CREATE ROLE client_sandra_martin LOGIN PASSWORD 'password_for_sandra_martin'

GRANT SELECT ON rental_customer TO client_sandra_martin;
GRANT SELECT ON payment_customer TO client_sandra_martin;

SET ROLE client_sandra_martin;

SELECT * FROM rental_customer;

SELECT * FROM payment_customer;

--reset role;



