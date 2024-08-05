USE sakila;
#1.
SELECT COUNT(inventory_id) AS number_of_copies
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');

#2.
SELECT *
FROM film
WHERE length >= (SELECT AVG(length) FROM film);

#3.
SELECT CONCAT(first_name, ' ' , last_name) AS Alone_Trip_movie_actors
FROM actor AS a
JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip');
									
