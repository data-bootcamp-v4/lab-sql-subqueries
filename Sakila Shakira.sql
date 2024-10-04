USE SAKILA;

#1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(*) AS number_of_copies
FROM inventory AS i
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible');

#2 List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT f.title
FROM film AS f
WHERE f.length > (
	SELECT AVG(length) 
    FROM film);

#3 Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT CONCAT(a.first_name, ' ', a.last_name) AS actor_name
FROM actor AS a
JOIN film_actor AS fa ON a.actor_id = fa.actor_id
JOIN film AS f ON fa.film_id = f.film_id
WHERE f.title = 'Alone Trip';

#Have to work backwords, from the most inside to the most outside. 
#When several subqueries, you have to you the IN
SELECT concat(first_name," ", last_name) AS full_name
FROM actor
WHERE actor_id IN (
	SELECT actor_id
	FROM film_actor
	WHERE film_id = (
		SELECT film_id
		FROM film
		WHERE title = "Alone Trip"));
