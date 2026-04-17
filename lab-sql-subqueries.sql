USE sakila;
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Challenge
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Write SQL queries to perform the following tasks using the Sakila database:

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT f.title, COUNT(*) AS number_of_copies
FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.title;

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT f.title AS films, length
FROM film f
WHERE length > (SELECT AVG(length) FROM film); 

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT CONCAT(a.first_name, ' ', a.last_name) AS Actor_name
FROM actor a
WHERE a.actor_id IN 
(SELECT fa.actor_id 
FROM film f 
JOIN film_actor fa ON fa.film_id = f.film_id
WHERE title = "Alone Trip");

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Bonus:
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. 
-- Identify all movies categorized as family films.
SELECT f.title AS Family_Movies FROM film f
WHERE f.film_id IN 
(SELECT fc.film_id FROM film_category fc
JOIN category c ON c.category_id = fc.category_id
WHERE name = 'Family');

-- 5 . Retrieve the name and email of customers from Canada using both subqueries and joins. 
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, c.email
FROM customer c
WHERE c.address_id IN 
(SELECT a.address_id FROM address a
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id);

-- 6. Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the
--  actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that 
-- actor_id to find the different films that he or she starred in.
SELECT f.title AS film_title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
    SELECT actor_id 
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- 7. Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables 
-- to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
SELECT f.title AS film_title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.customer_id =
(SELECT p.customer_id FROM payment p 
GROUP BY p.customer_id
ORDER BY SUM(amount) DESC
LIMIT 1);
-- 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount 
-- spent by each client. You can use subqueries to accomplish this.
SELECT customer_id, SUM(amount) AS total_amount_spent FROM payment
GROUP BY customer_id
HAVING SUM(amount) >= 
(SELECT AVG(p.amount)
FROM payment p
)
ORDER BY total_amount_spent DESC;
