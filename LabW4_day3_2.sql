-- Write SQL queries to perform the following tasks using the Sakila database:
USE sakila;
-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(f.title) FROM sakila.film AS f
JOIN sakila.inventory AS i
ON f.film_id = i.film_id
WHERE f.title = "Hunchback Impossible";

SELECT COUNT(film_id) FROM sakila.inventory AS i WHERE film_id IN (SELECT f.film_id FROM sakila.film AS f WHERE f.title = "Hunchback Impossible");

-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT f.title, f.length FROM sakila.film AS f WHERE f.length>(SELECT AVG(f.length) FROM sakila.film AS f) 
ORDER BY f.length DESC;

-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT concat(a.first_name," ",a.last_name) AS actor_name FROM sakila.actor AS a
WHERE a.actor_id IN (SELECT fa.actor_id FROM sakila.film_actor AS fa
WHERE fa.film_id = (SELECT f.film_id FROM sakila.film AS f WHERE f.title = 'Alone Trip'));

SELECT concat(a.first_name," ",a.last_name) AS actor_name FROM sakila.actor AS a
JOIN sakila.film_actor as fa
ON a.actor_id = fa.actor_id
JOIN sakila.film as f
ON fa.film_id = f.film_id
WHERE f.title = 'Alone Trip';

-- Bonus:
-- Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
SELECT cat.name, f.title FROM sakila.category AS cat
JOIN sakila.film_category AS fc
ON cat.category_id = fc.category_id
JOIN sakila.film as f
ON fc.film_id = f.film_id
WHERE cat.name IN (SELECT cat.name FROM sakila.category AS cat WHERE cat.name = "Family");

-- Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.

SELECT CONCAT(cust.first_name,' ',cust.last_name) AS customer_name, cust.email FROM sakila.customer AS cust
WHERE cust.address_id IN (SELECT addr.address_id FROM sakila.address AS addr
WHERE addr.city_id IN (SELECT city.city_id FROM sakila.city AS city
WHERE city.country_id IN (SELECT country.country_id FROM sakila.country AS country WHERE country.country = 'Canada')));


-- Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
SELECT fa.actor_id, COUNT(fa.film_id) FROM sakila.film_actor AS fa GROUP BY fa.actor_id ORDER BY COUNT(fa.film_id) DESC LIMIT 1;

SELECT f.title FROM sakila.film AS f WHERE f.film_id IN (SELECT fa.actor_id FROM sakila.film_actor AS fa WHERE (SELECT COUNT(fa.film_id) FROM sakila.film_actor AS fa GROUP BY fa.actor_id ORDER BY COUNT(fa.film_id) DESC LIMIT 1));


-- Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.

-- Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.