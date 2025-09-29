USE sakila;

SELECT COUNT(*) AS num_copies
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'HUNCHBACK IMPOSSIBLE'
);

SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
);

SELECT a.first_name, a.last_name
FROM actor AS a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor AS fa
    WHERE fa.film_id = (
	    SELECT film_id
        FROM film
        WHERE title = 'ALONE TRIP'
	)
);

SELECT f.title
FROM film AS f
WHERE f.film_id IN (
    SELECT fc.film_id
    FROM film_category AS fc
    WHERE fc.category_id = (
        SELECT category_id
        FROM category
        WHERE name = 'Family'
    )
);

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
FROM customer AS c
JOIN address AS a
    ON c.address_id = a.address_id
JOIN city AS ci
    ON a.city_id = ci.city_id
JOIN country AS co
    ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

SELECT f.title
FROM film AS f
WHERE f.film_id IN (
    SELECT fa.film_id
    FROM film_actor AS fa
    WHERE fa.actor_id = (
        SELECT actor_id
        FROM film_actor
        GROUP BY actor_id
        ORDER BY COUNT(*) DESC
        LIMIT 1
    )
);

SELECT DISTINCT f.title
FROM film AS f
JOIN inventory AS i
    ON f.film_id = i.film_id
JOIN rental AS r
    ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
    SELECT p.customer_id
    FROM payment AS p
    GROUP BY p.customer_id
    ORDER BY SUM(p.amount) DESC
    LIMIT 1
);    

SELECT p.customer_id, SUM(p.amount) AS total_amount_spent
FROM payment AS p
GROUP BY p.customer_id
HAVING SUM(p.amount) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(amount) AS total_spent
        FROM payment
        GROUP BY customer_id
    ) AS sub
);