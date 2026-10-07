-- Challenge

USE sakila;

-- Write SQL queries to perform the following tasks using the Sakila database:
-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(inventory_id) AS number_of_copies FROM inventory WHERE film_id IN (SELECT film_id FROM film WHERE title = "Hunchback Impossible"); 

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length FROM film WHERE length >  (SELECT AVG(length) FROM film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT first_name, last_name FROM actor WHERE actor_id IN (
SELECT actor_id FROM film_actor WHERE film_id IN (
SELECT film_id FROM film WHERE title = "Alone Trip"));

-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

SELECT title FROM film WHERE film_id IN (SELECT film_id FROM film_category WHERE category_id IN (SELECT category_id FROM category WHERE name = "family"));

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.

SELECT first_name, last_name, email FROM customer WHERE address_id IN(
SELECT address_id FROM address WHERE city_id IN(
SELECT city_id FROM city WHERE country_id IN (
SELECT country_id FROM country WHERE country = "Canada")));

SELECT first_name, last_name, email
FROM customer AS cu
JOIN address AS a
ON cu.address_id = a.address_id
JOIN city AS ci
ON a.city_id = ci.city_id
JOIN country as co
ON ci.country_id = co.country_id
WHERE co.country ="Canada";

-- 6. Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

SELECT f.title
FROM film AS f
JOIN film_actor AS fa 
ON f.film_id = fa.film_id
WHERE fa.actor_id = (
SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1);

-- 7. Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.

SELECT DISTINCT f.title
FROM film AS f
JOIN inventory AS i 
ON f.film_id = i.film_id
JOIN rental AS r 
ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
SELECT customer_id
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 1)
ORDER BY f.title;

-- 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.

SELECT customer_id AS client_id, SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
SELECT AVG(total_spent)
FROM (
SELECT SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id) AS customer_totals)
ORDER BY total_amount_spent DESC;