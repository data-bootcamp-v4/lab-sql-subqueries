USE sakila;

-- SQL SUBQUERIES

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT
	title,
    COUNT(inv.film_id)
FROM inventory inv
JOIN film fl
	ON inv.film_id = fl.film_id
WHERE title = "Hunchback Impossible";

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT AVG(length) FROM film;
-- this returned 115

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);
-- so all these lengths should be longer than 115

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

-- This returns a list of 1 and 0 because it is evaluating the expression to be TRUE or FALSE
SELECT title = "Alone Trip" FROM film;

-- Therefore will not be helpful to return just one value to use as a criteria in this example.
-- The film_id is going to be the common key, and will be a unique value. So use:
SELECT film_id FROM film WHERE title = "Alone Trip";

SELECT
	f.title,
	a.first_name,
    a.last_name
FROM actor AS a
JOIN film_actor AS fa
	ON a.actor_id = fa.actor_id
JOIN film AS f
	ON fa.film_id = f.film_id
WHERE fa.film_id = (SELECT film_id FROM film WHERE title = "Alone Trip");



-- BONUS:

-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion.
-- Identify all movies categorized as family films.
SELECT DISTINCT name FROM category;

SELECT
	title,
    name AS category_name 
FROM film f
JOIN film_category fc
	ON f.film_id = fc.film_id
JOIN category c
	ON fc.category_id = c.category_id
WHERE c.name = (SELECT name FROM category WHERE name = "Family");

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins.
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT
	cu.first_name,
    cu.last_name,
    cu.email
FROM customer cu
JOIN address ad
	ON cu.address_id = ad.address_id
JOIN city ci
	ON ad.city_id = ci.city_id
JOIN country co
	ON ci.country_id = co.country_id
WHERE co.country_id = (SELECT country_id FROM country WHERE country= "Canada");


-- 6. Determine which films were starred by the most prolific actor in the Sakila database.
-- A prolific actor is defined as the actor who has acted in the most number of films.
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
SELECT
	a.first_name,
    a.last_name,
    f.title
FROM film AS f
JOIN film_actor AS fa
	ON f.film_id = fa.film_id
JOIN actor as a
	ON fa.actor_id = a.actor_id
WHERE a.actor_id = (
	SELECT
		a.actor_id
	FROM actor AS a
    JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id 
    GROUP BY a.actor_id
    ORDER BY COUNT(fa.film_id) DESC
    LIMIT 1);
    

-- 7. Find the films rented by the most profitable customer in the Sakila database.
-- You can use the customer and payment tables to find the most profitable customer,
-- i.e., the customer who has made the largest sum of payments.
SELECT
	f.title,
    cu.first_name,
    cu.last_name
FROM film f
JOIN inventory i
	ON f.film_id = i.film_id
JOIN rental r
	ON i.inventory_id = r.inventory_id
JOIN payment p
	ON r.rental_id = p.rental_id
JOIN customer cu
	ON p.customer_id = cu.customer_id
WHERE cu.customer_id = (
	SELECT cu.customer_id
    FROM customer cu
    JOIN payment as p
		ON cu.customer_id = p.customer_id
    GROUP BY cu.customer_id
    ORDER BY SUM(p.amount) DESC
    LIMIT 1
);

-- Max would be used in the following way
SELECT MAX(number_of_movies)
FROM (
    SELECT COUNT(*) AS number_of_movies
    FROM film_actor
    GROUP BY actor_id
) AS movie_counts;

-- 8. Retrieve the client_id and the total_amount_spent of those clients 
-- who spent more than the average of the total_amount spent by each client.
-- You can use subqueries to accomplish this.

-- I have to:
-- Compute each customer's total.
-- Compute the average of those totals.
-- Compare each customer's total to that average.

SELECT
	cu.customer_id AS client_id,
    SUM(p.amount) AS total_amount_spent
FROM customer cu
JOIN payment p
	ON cu.customer_id = p.customer_id
GROUP BY cu.customer_id
HAVING SUM(p.amount) > (
	SELECT AVG(customer_total)
	FROM (
		SELECT
			customer_id,
            SUM(amount) AS customer_total
            FROM payment
			GROUP BY customer_id
    ) AS totals
);

