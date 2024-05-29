#3. Use a subquery to display all actors who appear in the film "Alone Trip".
USE sakila;

SELECT 
    a.first_name, a.last_name,
    (SELECT title FROM film WHERE film_id = fa.film_id) AS film_title
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip');




