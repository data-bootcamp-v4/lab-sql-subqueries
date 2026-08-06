USE sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" 
-- that exist in the inventory system.
SELECT COUNT(i.film_id)
FROM sakila.inventory as i
WHERE i.film_id IS NOT NULL AND i.film_id in (
	SELECT f.film_id
	FROM sakila.film as f
	WHERE f.title = "Hunchback Impossible"
    );

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT ff.film_id, ff.title, ff.description, length, ROUND((SELECT AVG(f.length)
FROM sakila.film as f), 2) as AVG_length
FROM sakila.film ff
WHERE ff.length > (
	SELECT AVG(f.length)
	FROM sakila.film as f
    );

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip"
SELECT *
FROM film_actor;

SELECT f.film_id
FROM sakila.film as f
WHERE f.title = "Alone Trip";

SELECT actor_id
FROM film_actor
WHERE film_id in (
	SELECT f.film_id
	FROM sakila.film as f
	WHERE f.title = "Alone Trip"
    );

SELECT a.actor_id, a.first_name, a.last_name
FROM sakila.actor as a
WHERE a.actor_id in (
	SELECT ff.actor_id
	FROM sakila.film_actor as ff
	WHERE ff.film_id in (
		SELECT f.film_id
		FROM sakila.film as f
		WHERE f.title = "Alone Trip"
    )
    ); 
    
-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
SELECT c.category_id
FROM category as c
WHERE c.name = "family"; 

SELECT fc.film_id
FROM film_category as fc
WHERE fc.category_id in (
	SELECT c.category_id
	FROM category as c
	WHERE c.name = "family"
    );    

SELECT *
FROM film as f
WHERE f.film_id in (
	SELECT fc.film_id
	FROM film_category as fc
	WHERE fc.category_id in (
		SELECT c.category_id
		FROM category as c
		WHERE c.name = "family"
    ));     

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. 
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT a.address_id
FROM address as a 
JOIN city as ci
ON a.city_id = ci.city_id
JOIN country as co
ON ci.country_id = co.country_id
WHERE co.country = "Canada";

SELECT cu.first_name, cu.last_name, email 
FROM customer as cu
WHERE cu.address_id in (
	SELECT a.address_id
	FROM address as a 
	JOIN city as ci
	ON a.city_id = ci.city_id
	JOIN country as co
	ON ci.country_id = co.country_id
	WHERE co.country = "Canada"
    );

-- 6. Determine which films were starred by the most prolific actor in the Sakila database. 
-- A prolific actor is defined as the actor who has acted in the most number of films. 
-- First, you will need to find the most prolific actor and then use that actor_id 
-- to find the different films that he or she starred in.

SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1;


SELECT f.film_id, f.title, f.description
FROM film as f 
JOIN film_actor as fa
ON f.film_id = fa.film_id
WHERE fa.actor_id = (
	SELECT actor_id
	FROM film_actor
	GROUP BY actor_id
	ORDER BY COUNT(film_id) DESC
	LIMIT 1
);

