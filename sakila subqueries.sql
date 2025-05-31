#1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT f.title, COUNT(*) AS number_copies
FROM film AS f
JOIN (SELECT film_id, inventory_id FROM inventory) AS i ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.title;
#2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT *
FROM film AS f
JOIN (SELECT AVG(length) AS length_avg FROM film) AS l
HAVING f.length > l.length_avg;

#3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT *
FROM actor AS ac
JOIN (SELECT a.actor_id, f.film_id, f.title
		FROM film_actor AS a
		JOIN (SELECT film_id, title FROM film) AS f ON f.film_id = a.film_id
		HAVING f.title = 'Alone Trip') AS fa
ON ac.actor_id = fa.actor_id;