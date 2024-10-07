use sakila;
#Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT film.title, inventory.film_id, COUNT(inventory.film_id) AS film_count
FROM inventory
JOIN film ON inventory.film_id = film.film_id
WHERE film.title = 'Hunchback Impossible'
GROUP BY inventory.film_id;

#List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT AVG(length) FROM film; #calculating average length of films to check further results
SELECT title, length FROM film
WHERE length > (SELECT AVG(length) FROM film AS avg_length)
ORDER BY length DESC; #films displayed should have a length>115.27

#Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT l.actor_id, l.first_name, l.last_name
FROM actor l
JOIN film_actor fa ON l.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Alone Trip';


