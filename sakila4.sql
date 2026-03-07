USE sakila;

-- Write SQL queries to perform the following tasks using the Sakila database:

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT count(f.title)
FROM sakila.film as f
JOIN sakila.inventory i
ON f.film_id = i.film_id 
WHERE f.title = 'Hunchback Impossible';

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT f.title, f.length
FROM sakila.film AS f
WHERE f.length > (SELECT AVG(length) AS avg_length FROM sakila.film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT * FROM sakila.film;
SELECT concat(a.first_name, ' ', a.last_name) AS actor_name
FROM sakila.actor as a
JOIN sakila.film_actor fa
ON a.actor_id = fa.actor_id
where fa.film_id = 
(SELECT f.film_id FROM sakila.film AS f
WHERE f.title = 'Alone Trip');


-- Bonus:
-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. 
-- Identify all movies categorized as family films.
SELECT * FROM sakila.film_category;
SELECT * FROM sakila.category;
SELECT f.title
FROM sakila.film AS f
JOIN sakila.film_category fc
ON f.film_id = fc.film_id
WHERE fc.category_id = 
(SELECT c.category_id FROM sakila.category AS ca
WHERE ca.name = 'family');
-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. 
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT concat(c.first_name, ' ', c.last_name) AS customer_name, c.email
FROM sakila. customer AS c
WHERE c.address_id IN 
(SELECT a.address_id 
FROM sakila.address AS a
JOIN sakila.city AS ci
ON a.city_id = ci.city_id
JOIN sakila.country as co
ON ci.country_id = co.country_id
WHERE co.country = 'Canada');

-- 6. Determine which films were starred by the most prolific actor in the Sakila database. 
-- A prolific actor is defined as the actor who has acted in the most number of films. 
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
-- Step 1: Find the actor_id of the most prolific actor
SELECT fa.actor_id
FROM sakila.film_actor AS fa
GROUP BY fa.actor_id
ORDER BY COUNT(fa.film_id) DESC
LIMIT 1;

-- Step 2: Find all films starring the most prolific actor
SELECT f.title
FROM sakila.film AS f
JOIN sakila.film_actor AS fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
  SELECT fa.actor_id
  FROM sakila.film_actor AS fa
  GROUP BY fa.actor_id
  ORDER BY COUNT(fa.film_id) DESC
  LIMIT 1
);
-- 7. Find the films rented by the most profitable customer in the Sakila database. 
-- You can use the customer and payment tables to find the most profitable customer, 
-- i.e., the customer who has made the largest sum of payments.
-- Step 1: Find the customer_id of the most prolific customer
SELECT c.customer_id, SUM(p.amount) AS total_amount
FROM sakila.customer AS c
JOIN sakila.payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_amount DESC
LIMIT 1;

-- Step 2: Find all films rented by the most prolific customer
SELECT f.title
FROM sakila.film AS f
JOIN sakila.inventory AS i ON f.film_id = i.film_id
JOIN sakila.rental AS r ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
  SELECT c.customer_id
  FROM sakila.customer AS c
  JOIN sakila.payment AS p ON c.customer_id = p.customer_id
  GROUP BY c.customer_id
  ORDER BY SUM(p.amount) DESC
  LIMIT 1
);
-- 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.
SELECT c.customer_id, SUM(p.amount) AS total_amount
FROM sakila.customer AS c
JOIN sakila.payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id
HAVING total_amount >
(SELECT AVG(customer_total) 
FROM (SELECT SUM(p1.amount)
AS customer_total
FROM sakila.payment AS p1
GROUP BY p1.customer_id)
AS subquery_amount);