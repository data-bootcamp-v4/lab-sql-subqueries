use sakila;

-- =============================================
-- Challenge 
-- =============================================
-- Write SQL queries to perform the following tasks using the Sakila database:

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT (
	SELECT COUNT(*) 
	FROM inventory  as i 
	WHERE i.film_id = (
		SELECT f.film_id 
        FROM film AS f
        WHERE f.title = "Hunchback Impossible"
	)
) AS number_of_copies;


-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM film
WHERE length >  ( 
	SELECT  ROUND(AVG(length)) AS average_length 
    FROM film
    );


-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT a.actor_id, a.first_name, a.last_name
FROM actor AS a
JOIN film_actor AS fac ON a.actor_id = fac.actor_id
WHERE fac.film_id = (
    SELECT f.film_id
    FROM film AS f
    WHERE f.title = 'Alone Trip'
);


