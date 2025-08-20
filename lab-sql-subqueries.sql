USE sakila;

USE sakila;

SELECT COUNT(*) AS num_copies
FROM inventory
WHERE film_id = (
    SELECT film_id 
    FROM film 
    WHERE title = 'Hunchback Impossible'
);
SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length) 
    FROM film
);
SELECT first_name, last_name
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
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family';
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
    SELECT address_id
    FROM address
    WHERE city_id IN (
        SELECT city_id
        FROM city
        WHERE country_id = (
            SELECT country_id
            FROM country
            WHERE country = 'Canada'
        )
    )
);
SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';
SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
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
HAVING total_spent > (
    SELECT AVG(total_customer_spent)
    FROM (
        SELECT SUM(amount) AS total_customer_spent
        FROM payment
        GROUP BY customer_id
    ) sub
);
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING total_spent > (
    SELECT AVG(total_customer_spent)
    FROM (
        SELECT SUM(amount) AS total_customer_spent
        FROM payment
        GROUP BY customer_id
    ) sub
);
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING total_spent > (
    SELECT AVG(total_customer_spent)
    FROM (
        SELECT SUM(amount) AS total_customer_spent
        FROM payment
        GROUP BY customer_id
    ) sub
);
