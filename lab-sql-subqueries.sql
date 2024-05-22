use sakila;

Select *
from rental;

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(*) AS 'Copies'
FROM inventory
WHERE film_id = (	SELECT film_id
					FROM film
					WHERE title = 'Hunchback Impossible');

-- List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length 
FROM film
where length > (SELECT AVG(length) as 'avg length'
				from film);
                
-- Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT a.first_name, a.last_name
from actor as a
WHERE actor_id IN (	SELECT fa.actor_id
					FROM film_actor as fa
                    WHERE fa.film_id = (SELECT film_id
										FROM film
										WHERE title = 'Alone Trip'));

