-- LAB Lab | SQL Join (Part II)
USE sakila;
-- 1.Write a query to display for each store its store ID, city, and country.
-- Linking all 4 tables
SELECT * FROM STORE;
SELECT * FROM ADDRESS;
SELECT * FROM CITY;
SELECT * FROM COUNTRY;

SELECT st.store_id, c.city, co.country
FROM sakila.store st
JOIN sakila.address a
ON st.address_id = a.address_id
JOIN sakila.city c
ON c.city_id = a.city_id
JOIN sakila.country co
ON co.country_id = c.country_id
GROUP BY st.store_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT st.store_id, sum(p.amount) as total_business
FROM sakila.store st
JOIN sakila.staff s
ON st.store_id = s.store_id
JOIN sakila.payment p
ON p.staff_id = s.staff_id
GROUP BY st.store_id;

-- 3.Which film categories are longest?
SELECT * FROM CATEGORY;
SELECT * FROM FILM_CATEGORY;
SELECT * FROM FILM;

SELECT c.name, AVG(f.length)
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON  c.category_id = fc.category_id
GROUP BY c.category_id, f.length
ORDER BY f.length DESC;
 
-- 4.Display the most frequently rented movies in descending order.
SELECT * FROM RENTAL;
SELECT * FROM INVENTORY;
SELECT * FROM PAYMENT;

SELECT i.film_id, count(distinct r.rental_id) as total_times
FROM sakila.payment p
JOIN sakila.rental r
ON p.rental_id = r.rental_id
JOIN sakila.inventory i
on i.inventory_id = r.inventory_id
JOIN sakila.film_category fc
on fc.film_id = i.film_id
GROUP BY i.film_id
ORDER BY total_times DESC;

-- 5. List the top five genres in gross revenue in descending order.
SELECT * FROM CATEGORY;
SELECT * FROM PAYMENT;
SELECT * FROM RENTAL;

SELECT cat.name, sum(p.amount) as gross_revenue
FROM sakila.payment p
JOIN sakila.rental r
ON p.rental_id = r.rental_id
JOIN sakila.inventory i
on i.inventory_id = r.inventory_id
JOIN sakila.film_category fc
on fc.film_id = i.film_id
JOIN sakila.category cat
on cat.category_id = fc.category_id
GROUP BY cat.name
ORDER BY gross_revenue DESC
limit 5;

-- 6. Is "Academy Dinosaur" available for rent from Store 1?
SELECT *
FROM sakila.film f
JOIN sakila.inventory i
ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = '1';

-- 7.Get all pairs of actors that worked together.
SELECT *
FROM film_actor as fa1
JOIN film_actor as fa2
ON (fa1.film_id = fa2.film_id) AND (fa1.actor_id > fa2.actor_id)
ORDER BY fa1.film_id ASC;

-- 8. Get all pairs of customers that have rented the same film more than 3 times.
-- Will work on this on Monday
-- 9. For each film, list actor that has acted in more films.
-- Will work on this on Monday