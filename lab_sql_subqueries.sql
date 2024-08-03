USE sakila;

SELECT COUNT(*) AS num_copies
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');

SELECT title
FROM film
WHERE length > (SELECT AVG(length) FROM film);

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip')
);

SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_category
    WHERE category_id = (SELECT category_id FROM category WHERE name = 'Family')
);

SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
    SELECT address_id
    FROM address
    WHERE city_id IN (
        SELECT city_id
        FROM city
        WHERE country_id = (SELECT country_id FROM country WHERE country = 'Canada')
    )
);


SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';


WITH MostProlificActor AS (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1
)

SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (SELECT actor_id FROM MostProlificActor);


WITH MostProfitableCustomer AS (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
)

SELECT f.title
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.customer_id = (SELECT customer_id FROM MostProfitableCustomer);


SELECT customer_id, total_amount_spent
FROM (
    SELECT customer_id, SUM(amount) AS total_amount_spent
    FROM payment
    GROUP BY customer_id
) AS client_spending
WHERE total_amount_spent > (SELECT AVG(total_amount_spent) FROM (
    SELECT SUM(amount) AS total_amount_spent
    FROM payment
    GROUP BY customer_id
) AS avg_spending);











