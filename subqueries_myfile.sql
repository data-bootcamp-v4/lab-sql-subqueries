-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.



SELECT count(*) FROM sakila.film as f
JOIN sakila.inventory AS i
ON f.film_id = i.film_id
WHERE title = 'Hunchback Impossible';


SELECT COUNT(*) from inventory 
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');


-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.


SELECT title, length FROM sakila.film
WHERE length > (SELECT (AVG(length)) FROM sakila.film);


-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT * from film_actor 
JOIN actor as a
ON a.actor_id = film_actor.actor_id
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip');
