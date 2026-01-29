USE sakila;

SELECT *
FROM film_category;

SELECT 
COUNT(inventory_id)
FROM inventory AS i
WHERE i.film_id = (
    SELECT film_id
    FROM film AS f
    WHERE f.title = 'Hunchback Impossible'
);

SELECT
title
FROM film AS f
WHERE f.length > (SELECT
AVG(length)
FROM film);

SELECT 
    first_name, 
    last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (
        SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
    )
);

SELECT 
title
FROM film
WHERE film_id IN (SELECT
film_id
FROM film_category
WHERE category_id =(SELECT
category_id
FROM category
WHERE name = "Family")
);

SELECT 
    first_name,
    last_name,
    email
FROM customer AS c
JOIN address AS a 
ON c.address_id = a.address_id
JOIN city AS ci 
ON a.city_id = ci.city_id
JOIN country AS co 
ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

SELECT *
FROM film_actor;

SELECT 
actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id)
LIMIT 1;

SELECT
title
FROM film AS f
JOIN film_actor AS fa
ON f.film_id = fa.film_id
WHERE fa.actor_id =(SELECT 
actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id)
LIMIT 1);

SELECT *
FROM payment;

SELECT 
customer_id
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC;

SELECT 
first_name,
last_name,
SUM(amount) AS total_amount
FROM customer AS c
JOIN payment AS p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_amount DESC
LIMIT 1;

