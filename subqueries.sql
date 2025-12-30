SELECT COUNT(*) AS copies_HI
FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.title = "HUNCHBACK IMPOSSIBLE";

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN(SELECT fa.actor_id
FROM film_actor fa
WHERE fa.film_id =(SELECT f.film_id FROM film f WHERE f.title = "ALONE TRIP"));