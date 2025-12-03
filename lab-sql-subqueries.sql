-- Challenge
-- Write SQL queries to perform the following tasks using the Sakila database:
-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(i.film_id) AS number_of_copies, f.title FROM sakila.film AS f
LEFT JOIN sakila.inventory AS i ON f.film_id = i.film_id WHERE f.title = 'Hunchback Impossible'
GROUP BY f.title;

-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length FROM sakila.film WHERE length > (SELECT AVG(length) FROM sakila.film);

-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT film_id
FROM sakila.film
WHERE title = 'Alone Trip';

SELECT a.first_name, a.last_name
FROM sakila.actor AS a
JOIN sakila.film_actor AS fa ON a.actor_id = fa.actor_id  
WHERE fa.film_id = (SELECT f.film_id FROM sakila.film AS f WHERE f.title = 'Alone Trip'); 

-- sakila.film_actor (actor_id, film_id, last_update) as fa 
-- sakila.film (film_id, title) as f
-- sakila.actor(actor_id, first_name, last_name, last_update)  as a



