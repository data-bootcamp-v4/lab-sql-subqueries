USE sakila;
-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(*) AS total_copies
FROM (SELECT f.title, f.film_id, i.inventory_id
FROM inventory AS i
JOIN film AS f ON i.film_id = f.film_id) AS number_copies
WHERE title = 'Hunchback Impossible'
;

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
LIMIT 5;

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT 
first_name,
last_name
FROM (SELECT 
a.first_name,
a.last_name,
f.title
FROM film AS f
JOIN film_actor AS fa
ON f.film_id = fa.film_id
JOIN actor AS a
ON fa.actor_id = a.actor_id) AS list
WHERE title = "Alone Trip";

-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films. 
SELECT 
name, 
title
FROM (SELECT 
f.title,
ca.name
FROM film AS f
JOIN film_category AS c
ON f.film_id = c.film_id
JOIN category AS ca
ON c.category_id = ca.category_id) AS family_category
WHERE name = "Family";

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT
co.country,
c.first_name,
c.last_name,
c.email
FROM customer AS c
JOIN address AS a
ON c.address_id = a.address_id
JOIN city AS ci
ON a.city_id = ci.city_id
JOIN country AS co
ON ci.country_id = co.country_id
WHERE country = "Canada";

SELECT country, first_name, last_name, email 
FROM (SELECT
co.country,
c.first_name,
c.last_name,
c.email
FROM customer AS c
JOIN address AS a
ON c.address_id = a.address_id
JOIN city AS ci
ON a.city_id = ci.city_id
JOIN country AS co
ON ci.country_id = co.country_id) AS customer_canada
WHERE country = "Canada"
;

-- 6. Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor 
-- who has acted in the most number of films. First, you will need to find the most prolific actor 
-- and then use that actor_id to find the different films that he or she starred in.

SELECT title FROM film WHERE film_id IN (
  SELECT film_id FROM film_actor WHERE actor_id = (
    SELECT actor_id FROM film_actor GROUP BY actor_id ORDER BY COUNT(film_id) DESC LIMIT 1));

-- 7. Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables 
-- to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
SELECT DISTINCT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
);
-- 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount 
-- spent by each client. You can use subqueries to accomplish this.
SELECT
    c.customer_id,
    SUM(p.amount) AS total_amount_spent
FROM customer AS c
JOIN payment AS p
    ON c.customer_id = p.customer_id
GROUP BY c.customer_id
HAVING SUM(p.amount) > (
    SELECT AVG(amount)
    FROM payment
);











