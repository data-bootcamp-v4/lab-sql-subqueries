USE sakila;

SELECT 
    COUNT(*) AS number_of_copies
FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible';

SELECT 
    title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC;

SELECT 
    first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    WHERE f.title = 'Alone Trip'
)
ORDER BY first_name, last_name;

SELECT 
    f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family'
ORDER BY f.title;


SELECT 
    cu.first_name, cu.last_name, cu.email
FROM customer cu
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada'
ORDER BY cu.first_name, cu.last_name;

SELECT 
    actor_id,
    COUNT(film_id) AS film_count
FROM film_actor
GROUP BY actor_id
ORDER BY film_count DESC
LIMIT 1;

SELECT 
    f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1
);

SELECT 
    customer_id,
    SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 1;

SELECT DISTINCT
    f.title
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
)
ORDER BY f.title;

SELECT 
    customer_id,
    SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING total_amount_spent > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(amount) AS total_spent
        FROM payment
        GROUP BY customer_id
    ) AS customer_totals
)
ORDER BY total_amount_spent DESC;










