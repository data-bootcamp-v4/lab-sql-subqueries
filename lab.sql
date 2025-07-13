USE sakila;

SELECT COUNT(*) AS copies
FROM inventory
JOIN film ON inventory.film_id = film.film_id
WHERE film.title = 'Hunchback Impossible';

SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length) 
    FROM film
);

SELECT f.title, c.name AS category
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music');

SELECT fa.actor_id
FROM film_actor fa
GROUP BY fa.actor_id
ORDER BY COUNT(fa.film_id) DESC
LIMIT 1;

SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (

    SELECT fa.actor_id
    FROM film_actor fa
    GROUP BY fa.actor_id
    ORDER BY COUNT(fa.film_id) DESC
    LIMIT 1
);

SELECT c.first_name, c.last_name, SUM(p.amount) AS total_paid
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_paid DESC
LIMIT 1;