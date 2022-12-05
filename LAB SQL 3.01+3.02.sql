-- LAB SQL 3.01
-- Activity 1: 1.Drop column picture from staff
USE SAKILA;
ALTER TABLE staff
DROP COLUMN picture;

-- LAB SQL 3.02
USE SAKILA;
-- 1. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT title, COUNT(inventory_id)
FROM sakila.film f
JOIN sakila.inventory i
ON i.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible';

-- 2. List all films whose length is longer than the average of all the films
SELECT avg(length) from sakila.film; -- First step is to find the average of all the films
SELECT title,length FROM sakila.film
WHERE length > (
  SELECT avg(length)
  FROM sakila.film
);

-- 3. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT film_id FROM film WHERE title like "Alone Trip"; -- First setting up the subquery 
SELECT last_name, first_name FROM actor
WHERE actor_id in (
SELECT actor_id FROM film_actor
	WHERE film_id in actor
		(SELECT film_id FROM film
		WHERE title = "Alone Trip"));

-- 4. Identify all movies categorized as family films.
(SELECT category_id FROM category WHERE NAME = "Family" ); -- subquery

SELECT title FROM film 
WHERE film_id in (
SELECT film_id from film_category 
	WHERE category_id IN
		(SELECT category_id FROM category 
        WHERE NAME = "Family")
        );

-- 5. Get name and email from customers from Canada using subqueries.
(SELECT country_id from country where country = 'Canada'); -- subquery

SELECT first_name,last_name,email AS name -- 3rd step in asking what we want
FROM customer 
	WHERE customer_id IN (
	  SELECT address_id FROM address 
      WHERE city_id IN(
		SELECT city_id FROM city WHERE country_id IN (
			SELECT country_id from country 
            where country = 'Canada')));

-- 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. 
-- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
SELECT actor_id FROM film_actor; -- subquery

SELECT title from film
WHERE film_id IN(
	SELECT film_id
    FROM film_actor
	  WHERE actor_id LIKE (
		SELECT actor_id 
		FROM film_actor
		GROUP BY actor_id
		ORDER BY count(*) DESC
		LIMIT 1));

-- 7. Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer 
-- ie the customer that has made the largest sum of payments
SELECT customer_id FROM payment; -- subquery

SELECT title from film WHERE film_id in (
	SELECT film_id from inventory
		WHERE inventory_id in (
SELECT DISTINCT inventory_id from rental
WHERE customer_id LIKE (
SELECT customer_id FROM payment
GROUP BY customer_id
ORDER BY sum(amount) DESC
limit 1))); 

-- 8. Customers who spent more than the average payments.
SELECT AVG(amount) from payment; -- subquery

SELECT concat('first_name','last_name') as total 
from customer
WHERE customer_id LIKE (
SELECT AVG(amount) from payment
GROUP BY 
HAVING BY  DESC
limit 5);  -- I will resubmit this at another time, mind is having a blocker from long day of travelling. 
    