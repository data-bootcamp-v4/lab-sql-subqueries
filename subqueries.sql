SELECT
    COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'HUNCHBACK IMPOSSIBLE'
);


SELECT
    title,
    length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
)
ORDER BY length DESC;


SELECT
    actor_id,
    first_name,
    last_name
FROM actor
WHERE actor_id IN (
    SELECT film_actor.actor_id
    FROM film_actor
    WHERE film_actor.film_id = (
        SELECT film_id
        FROM film
        WHERE title = 'ALONE TRIP'
    )
)
ORDER BY last_name, first_name;


SELECT
    first_name,
    last_name,
    email
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
)
ORDER BY last_name, first_name;


SELECT
    customer.first_name,
    customer.last_name,
    customer.email
FROM customer
INNER JOIN address
    ON customer.address_id = address.address_id
INNER JOIN city
    ON address.city_id = city.city_id
INNER JOIN country
    ON city.country_id = country.country_id
WHERE country.country = 'Canada'
ORDER BY customer.last_name, customer.first_name;


SELECT
    film.title
FROM film
WHERE film.film_id IN (
    SELECT film_actor.film_id
    FROM film_actor
    WHERE film_actor.actor_id = (
        SELECT actor_id
        FROM film_actor
        GROUP BY actor_id
        ORDER BY COUNT(*) DESC
        LIMIT 1
    )
)
ORDER BY film.title;


SELECT DISTINCT
    film.title
FROM film
INNER JOIN inventory
    ON film.film_id = inventory.film_id
INNER JOIN rental
    ON inventory.inventory_id = rental.inventory_id
WHERE rental.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
)
ORDER BY film.title;


SELECT
    payment.customer_id AS client_id,
    SUM(payment.amount) AS total_amount_spent
FROM payment
GROUP BY payment.customer_id
HAVING SUM(payment.amount) > (
    SELECT AVG(total_per_customer.total_spent)
    FROM (
        SELECT
            customer_id,
            SUM(amount) AS total_spent
        FROM payment
        GROUP BY customer_id
    ) AS total_per_customer
)
ORDER BY total_amount_spent DESC;


