USE sakila;

SELECT f.title, COUNT(i.inventory_id) AS number_of_copies
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'HUNCHBACK IMPOSSIBLE'
GROUP BY f.title;

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC;

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
SELECT actor_id
FROM film_actor
WHERE film_id = (
SELECT film_id
FROM film
WHERE title = 'ALONE TRIP'
)
);

SELECT f.title
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family';


SELECT cu.first_name, cu.last_name, cu.email
FROM customer cu
INNER JOIN address a ON cu.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

SELECT f.title
FROM film f
INNER JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(*) DESC
LIMIT 1
);

SELECT f.title
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
SELECT customer_id
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 1
);
