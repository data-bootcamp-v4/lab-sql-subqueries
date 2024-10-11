# Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system
SELECT COUNT(inventory.film_id) AS film_copies
FROM inventory
INNER JOIN film
ON inventory.film_id = film.film_id
WHERE film.title = 'Hunchback Impossible';

# List all films whose length is longer than the average length of all the films in the Sakila database
SELECT film_id, title
FROM film
WHERE length < (SELECT AVG(length) FROM film);


# Use a subquery to display all actors who appear in the film "Alone Trip"    
SELECT actor.actor_id, actor.first_name, actor.last_name
FROM actor 
WHERE actor.actor_id IN (
    SELECT actor_id
    FROM film_actor 
    JOIN film  ON film_actor.film_id = film.film_id
    WHERE film.title = 'Alone Trip');

# Sales have been lagging among young families, and you want to target family movies for a promotion.
#  Identify all movies categorized as family films.

SELECT film.film_id, film.title
FROM film
WHERE film.film_id IN (
	SELECT film_category.category_id
    FROM film_category
    JOIN category on film_category.category_id = category.category_id
    WHERE category.name = "Family");
    
