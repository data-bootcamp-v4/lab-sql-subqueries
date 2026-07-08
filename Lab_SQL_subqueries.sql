USE sakila;
-- Write SQL queries to perform the following tasks using the Sakila database:
-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT f.title, COUNT(i.inventory_id) AS no_of_copies
FROM film AS f
LEFT JOIN inventory AS i
ON f.film_id = i.film_id
WHERE f.title = "Hunchback Impossible"
GROUP BY f.title;

-- Solution for subqueries:

SELECT COUNT(inventory_id) AS no_of_copies
FROM inventory
WHERE film_id = (SELECT film_id
				FROM film
                WHERE title = "Hunchback Impossible");

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT AVG(length) FROM film;

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);


-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT CONCAT(a.first_name, ' ', a.last_name) AS actors_in_Alone_Trip
FROM actor AS a
LEFT JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
WHERE fa.film_id = (
					SELECT film_id
					FROM film
					WHERE title = "Alone Trip"
	);
 

-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. 
-- Identify all movies categorized as family films.


SELECT f.title AS family_films
FROM film AS f
WHERE f.film_id IN (
			SELECT fc.film_id
			FROM film_category AS fc
			WHERE fc.category_id = (
				SELECT c.category_id
				FROM category AS c
				WHERE c.name = "Family"
		));

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. 
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.

SELECT CONCAT(c.first_name," ",c.last_name) AS cust_name, c.email
FROM customer AS c
JOIN address AS ad
ON ad.address_id = c.address_id
JOIN city AS ci
ON ad.city_id=ci.city_id
WHERE ci.country_id = (
		SELECT country_id
		FROM country AS co
		WHERE co.country = "Canada"
	);


-- 6. Determine which films were starred by the most prolific actor in the Sakila database. 
-- A prolific actor is defined as the actor who has acted in the most number of films. 
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.



SELECT CONCAT(a.first_name, " ", a.last_name) AS prolific_actor, f.title AS films_starred
FROM film AS f
JOIN film_actor AS fa
ON f.film_id = fa.film_id
JOIN actor AS a
ON a.actor_id = fa.actor_id
WHERE fa.actor_id = (
	SELECT fa.actor_id
	FROM film_actor AS fa
	GROUP BY fa.actor_id
	ORDER BY COUNT(fa.film_id) DESC
	LIMIT 1
);


-- 7. Find the films rented by the most profitable customer in the Sakila database. 
-- You can use the customer and payment tables to find the most profitable customer, i.e., 
-- the customer who has made the largest sum of payments.ç


SELECT DISTINCT CONCAT(first_name, " ", last_name) AS vip_customer, f.title AS rented_movies
FROM film AS f
JOIN inventory AS i
ON i.film_id = f.film_id
JOIN rental AS r
ON i.inventory_id = r.inventory_id
JOIN customer AS c
ON c.customer_id = r.customer_id
WHERE r.customer_id = (
		SELECT customer_id 
		FROM payment
		GROUP BY customer_id
		ORDER BY SUM(amount) DESC
		LIMIT 1
	)
ORDER BY rented_movies;


-- 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of 
-- the total_amount spent by each client. You can use subqueries to accomplish this.

SELECT ROUND(AVG(total_paid),2)
FROM (	
	SELECT p.customer_id,
    SUM(p.amount) AS total_paid
	FROM payment AS p
	GROUP BY p.customer_id
)
AS customer_details;

SELECT p.customer_id AS customer, SUM(p.amount) AS total_paid
FROM payment AS p
GROUP BY p.customer_id
HAVING SUM(p.amount) > (
	SELECT ROUND(AVG(total_paid),2)
	FROM (	
		SELECT p.customer_id,
		SUM(p.amount) AS total_paid
		FROM payment AS p
		GROUP BY p.customer_id
	)
	AS customer_details
	);