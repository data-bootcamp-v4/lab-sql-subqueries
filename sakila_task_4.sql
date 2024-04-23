USE sakila;

SELECT COUNT(inventory.film_id) as count_movie
FROM inventory
WHERE film_id IN (SELECT film_id
					FROM film
                    WHERE title LIKE "HUNCHBACK%");
                    
SELECT *
FROM film
WHERE length > (SELECT AVG(length)
				FROM film);
                
SELECT CONCAT(first_name, " ", last_name) AS full_name
FROM actor
WHERE actor_id IN (SELECT actor_id
					FROM film_actor
                    WHERE film_id IN (SELECT film_id
										FROM film
                                        WHERE title = "Alone Trip"));
