-- Write SQL queries to perform the following tasks using the Sakila database:
USE sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT f.title, COUNT(i.inventory_id) AS number_of_copies
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
GROUP BY f.title
HAVING title LIKE 'Hunchback Impossible';

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT a.first_name, a.last_name, f.title
FROM actor AS a
JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
JOIN film AS f
ON fa.film_id = f.film_id
WHERE f.film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip');

-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

SELECT c.name, f.title
FROM category AS c
JOIN film_category AS fa
ON c.category_id = fa.category_id
JOIN film AS f
ON fa.film_id = f.film_id
WHERE c.category_id = (SELECT category_id FROM category WHERE name = 'Family');

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.

SELECT c.first_name, c.last_name, c.email, co.country
FROM customer AS c
JOIN address AS a
ON c.address_id = a.address_id
JOIN city as ci
ON a.city_id = ci.city_id
JOIN country as co
ON ci.country_id = co.country_id
WHERE co.country_id = (SELECT country_id FROM country WHERE country = 'Canada');

-- 6. Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films.
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

WITH actor_film_counts AS(
	SELECT 	a.actor_id,
			CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
			COUNT(*) AS number_of_films
	FROM actor AS a
	JOIN film_actor AS fa
	ON a.actor_id = fa.actor_id
	JOIN film AS f
	ON fa.film_id = f.film_id
	GROUP BY actor_id, CONCAT(a.first_name, ' ', a.last_name)),
    
    most_profilic_actor AS(
	SELECT afc.actor_name, afc.number_of_films, fa.film_id
	FROM actor_film_counts AS afc
	JOIN film_actor as fa
	ON afc.actor_id = fa.actor_id
	WHERE number_of_films = (SELECT MAX(number_of_films) FROM actor_film_counts))

SELECT f.title, mpa.actor_name, mpa.number_of_films
FROM most_profilic_actor AS mpa
JOIN film as f
ON mpa.film_id = f.film_id;

-- 7. Find the films rented by the most profitable customer in the Sakila database.
-- You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.


-- 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 
-- You can use subqueries to accomplish this.