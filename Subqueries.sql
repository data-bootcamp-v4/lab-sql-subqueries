--  1.Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(*) AS total_copies
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');

 --  2.List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

--  3.List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (SELECT fa.actor_id 
                     FROM film_actor fa
                     WHERE fa.film_id = (SELECT f.film_id FROM film f WHERE f.title = 'Alone Trip'));


