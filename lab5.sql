#Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
USE sakila;
SELECT title, COUNT(*) AS num_of_copies
FROM inventory i
LEFT JOIN film f
ON f.film_id = i.film_id
WHERE title = "Hunchback Impossible";

#List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length)
	FROM film);

#Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT * 
FROM actor
WHERE actor_id IN (
	SELECT actor_id 
	FROM film_actor
	WHERE film_id = (
			SELECT film_id 
			FROM film
			WHERE title = "Alone Trip")
					)
;
