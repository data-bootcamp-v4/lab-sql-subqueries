USE sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(title) AS number_of_copies FROM sakila.inventory i
JOIN sakila.film f
ON i.film_id=f.film_id
GROUP BY title
HAVING title LIKE 'Hunchback Impossible';

-- 2. List all films whose length is longer than the average length of all the films in the Sakila 
-- database.
SELECT film_id, title, length FROM sakila.film
WHERE length > (SELECT AVG(length) FROM sakila.film);



-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT a.first_name AS Actor_name, a.last_name AS Actor_last_name FROM sakila.film f
JOIN sakila.film_actor fi ON f.film_id= fi.film_id
JOIN sakila.actor a ON a.actor_id=fi.actor_id
WHERE f.film_id = (SELECT film_id FROM sakila.film
WHERE title LIKE 'Alone Trip');

-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. 
-- Identify all movies categorized as family films.

SELECT f.title FROM sakila.category ca
JOIN sakila.film_category fc ON ca.category_id=fc.category_id
JOIN sakila.film f ON fc.film_id=f.film_id
WHERE ca.category_id = (SELECT ca.category_id FROM sakila.category ca WHERE ca.name LIKE '%family%');

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, 
-- you will need to identify the relevant tables and their primary and foreign keys.
-- 5. JOIN:
SELECT cu.first_name AS customer_name, cu.last_name AS customer_last_name, cu.email FROM sakila.country co
JOIN sakila.city ci ON co.country_id=ci.country_id
JOIN sakila.address a ON ci.city_id=a.city_id
JOIN sakila.customer cu ON a.address_id= cu.address_id
WHERE co.country  LIKE 'Canada';

-- 5. subqueries
SELECT cu.first_name AS customer_name, cu.last_name AS customer_last_name, cu.email AS email FROM sakila.customer cu
WHERE cu.address_id IN (
	SELECT a.address_id FROM sakila.address a
	WHERE a.city_id IN (
		SELECT ci.city_id FROM sakila.city ci
		WHERE ci.country_id IN (
			SELECT co.country_id FROM sakila.country co
			WHERE co.country LIKE 'Canada')
			)
            );



-- 6. Determine which films were starred by the most prolific actor in the Sakila database. 
-- A prolific actor is defined as the actor who has acted in the most number of films. First, 
-- you will need to find the most prolific actor and then use that actor_id to find the different 
-- films that he or she starred in.

SELECT f.title FROM sakila.film f
JOIN sakila.film_actor fa
ON f.film_id=fa.film_id
WHERE fa.actor_id = (
	SELECT fa.actor_id
	FROM sakila.film_actor fa
	GROUP BY fa.actor_id 
    ORDER BY COUNT(fa.film_id) DESC LIMIT 1
	);