use sakila;
-- CHALLENGE
-- Write SQL queries to perform the following tasks using the Sakila database:
-- 1. Determine the number of copies of the film "Hunchback 	Impossible" that exist in the inventory system.

SELECT *
FROM (SELECT title FROM film WHERE title LIKE 'Hunchback%') AS t
WHERE COUNT(t) > 1;


-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT a.actor_id, a.first_name, a.last_name
FROM actor a 
JOIN film_actor AS fa USING (actor_id)
JOIN film AS f USING (film_id)
WHERE f.title = 'Alone Trip';
-- THIS EXERCICE WAS SUPPOSED TO BE DONE WITH SUBQUERIES, TRY DOING THAT
