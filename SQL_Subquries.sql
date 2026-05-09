-- 1.
USE sakila;
SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');

-- 2. 
SELECT title,length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- 3. 
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip'));

-- Bouns: Question 1
SELECT f.title
FROM film f
JOIN film_category fc 
ON f.film_id = fc.film_id
JOIN category c 
ON fc.category_id = c.category_id
WHERE c.name = 'Family';


-- 2. 
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (SELECT address_id FROM address WHERE city_id IN (SELECT city_id FROM city WHERE country_id = (SELECT country_id FROM country WHERE country = 'Canada')));

-- 3.
SELECT cu.first_name, cu.last_name,cu.email
FROM customer cu
JOIN address a 
ON cu.address_id = a.address_id
JOIN city ci 
ON a.city_id = ci.city_id
JOIN country co 
ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

-- 4. 
SELECT DISTINCT f.title
FROM film f
JOIN inventory i 
ON f.film_id = i.film_id
JOIN rental r 
ON i.inventory_id = r.inventory_id
WHERE r.customer_id = ( SELECT customer_id FROM payment GROUP BY customer_id ORDER BY SUM(amount) DESC LIMIT 1);

-- 5. 
SELECT customer_id AS client_id, SUM(amount) AS total_amount_spent 
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (SELECT AVG(total_spent) FROM (SELECT customer_id, SUM(amount) AS total_spent FROM payment GROUP BY customer_id) AS client_totals);