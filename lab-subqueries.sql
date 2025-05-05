use sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT count(distinct inventory_id)
FROM inventory
WHERE film_id IN (
	SELECT film_id
	FROM film
	WHERE title='Hunchback Impossible');

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT *
FROM film
WHERE length > (
	SELECT AVG(length)
	FROM film)
ORDER BY length DESC;

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT first_name, last_name
FROM actor
WHERE actor_id IN
	(SELECT actor_id
	FROM film_actor
    WHERE film_id = 
		(select film_id
		FROM film f
		WHERE title='Alone Trip'));

-- Bonus excersises
-- 4.  Identify all movies categorized as family films
SELECT *
FROM film
WHERE film_id IN (
	SELECT film_id
	FROM film_category
	WHERE category_id IN (
		SELECT category_id
		FROM category
		WHERE name LIKE 'Family')
        );

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins.
--    To use joins, you will need to identify the relevant tables and their primary and foreign keys.
select * 
from customer c
INNER JOIN
	(select address_id
	from address
	WHERE city_id IN (
		select city_id
		from city
		where country_id IN (
			select country_id
			from country
			where country='Canada'))) AS t
ON c.address_id=t.address_id;

-- 6. Determine which films were starred by the most prolific actor in the Sakila database
SELECT *
FROM film
WHERE film_id IN (
	SELECT film_id
	FROM film_actor
	WHERE actor_id IN (
		SELECT actor_id
		FROM film_actor
		GROUP BY actor_id
		HAVING COUNT(DISTINCT film_id) = (
			SELECT MAX(film_count)
			FROM (
				SELECT actor_id, COUNT(DISTINCT film_id) AS film_count
				FROM film_actor
				GROUP BY actor_id
			) AS temp
		)
	)
);

-- 7. Find the films rented by the most profitable customer in the Sakila database.
-- You can use the customer and payment tables to find the most profitable customer, 
-- .e., the customer who has made the largest sum of payments.

select customer_id, SUM(amount) AS amount
from payment
GROUP BY customer_id
ORDER BY amount DESC
LIMIT 1;

            