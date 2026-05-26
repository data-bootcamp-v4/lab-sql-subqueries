USE sakila;

SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id FROM film_actor WHERE film_id = (
        SELECT film_id FROM film WHERE title = 'Alone Trip'
    )
);

SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id FROM film_category WHERE category_id = (
        SELECT category_id FROM category WHERE name = 'Family'
    )
);

SELECT c.first_name, c.last_name, c.email
FROM customer AS c
INNER JOIN address AS a ON c.address_id = a.address_id
INNER JOIN city AS ci ON a.city_id = ci.city_id
INNER JOIN country AS co ON ci.country_id = co.country_id
WHERE country = 'Canada'
ORDER BY c.last_name;

SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
    SELECT address_id FROM address WHERE city_id IN (
        SELECT city_id FROM city WHERE country_id = (
            SELECT country_id FROM country WHERE country = 'Canada'
        )
    )
);

SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id FROM film_actor WHERE actor_id = (
        SELECT actor_id FROM film_actor
        GROUP BY actor_id
        ORDER BY COUNT(film_id) DESC
        LIMIT 1
    )
);

SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id FROM inventory WHERE inventory_id IN (
        SELECT inventory_id FROM rental WHERE customer_id = (
            SELECT customer_id FROM payment
            GROUP BY customer_id
            ORDER BY SUM(amount) DESC
            LIMIT 1
        )
    )
);

SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(amount) AS total_spent
        FROM payment
        GROUP BY customer_id
    ) AS subquery
);