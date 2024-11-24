USE sakila;

SELECT COUNT(*) AS number_of_copies
FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible';
	   
SELECT title,
	   length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

SELECT a.first_name,
	   a.last_name,
       f.title
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Alone Trip';