USE sakila;


SELECT f.title, COUNT(i.inventory_id) AS total_copies
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.title;

SELECT
title,
length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

SELECT a.first_name, a.last_name
FROM film AS f
JOIN film_actor AS fa ON f.film_id = fa.film_id
JOIN actor AS a ON fa.actor_id = a.actor_id
WHERE f.title = 'Alone Trip';

SELECT
title,
c.name
FROM film as f
JOIN film_category as fc
ON f.film_id = fc.film_id
JOIN category as c
ON fc.category_id = c.category_id
WHERE c.name = 'Family';

SELECT first_name, last_name, email
FROM customer AS cu
JOIN address AS a ON cu.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';


SELECT f.title
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE a.actor_id = (
    SELECT actor_id 
    FROM film_actor 
    GROUP BY actor_id 
    ORDER BY COUNT(film_id) DESC 
    LIMIT 1
);

SELECT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
);

SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total_per_client)
    FROM (
        SELECT SUM(amount) AS total_per_client
        FROM payment
        GROUP BY customer_id
    ) AS subquery_avg
);