USE sakila;

SELECT COUNT(*) AS total_copias
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

SELECT film_id, title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_category
    WHERE category_id = (
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

SELECT
    c.first_name,
    c.last_name,
    c.email
FROM customer AS c
INNER JOIN address AS a
    ON c.address_id = a.address_id
INNER JOIN city AS ci
    ON a.city_id = ci.city_id
INNER JOIN country AS co
    ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(*) AS total_peliculas
FROM actor AS a
INNER JOIN film_actor AS fa
    ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(*) = (
    SELECT MAX(total_peliculas)
    FROM (
        SELECT COUNT(*) AS total_peliculas
        FROM film_actor
        GROUP BY actor_id
    ) AS recuentos
);

SELECT film_id, title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_actor
    WHERE actor_id IN (
        SELECT actor_id
        FROM film_actor
        GROUP BY actor_id
        HAVING COUNT(*) = (
            SELECT MAX(total_peliculas)
            FROM (
                SELECT COUNT(*) AS total_peliculas
                FROM film_actor
                GROUP BY actor_id
            ) AS recuentos
        )
    )
);

SELECT film_id, title
FROM film
WHERE film_id IN (
    SELECT i.film_id
    FROM inventory AS i
    INNER JOIN rental AS r
        ON i.inventory_id = r.inventory_id
    WHERE r.customer_id IN (
        SELECT customer_id
        FROM payment
        GROUP BY customer_id
        HAVING SUM(amount) = (
            SELECT MAX(total_gastado)
            FROM (
                SELECT SUM(amount) AS total_gastado
                FROM payment
                GROUP BY customer_id
            ) AS gastos
        )
    )
);

SELECT
    c.customer_id AS client_id,
    COALESCE(SUM(p.amount), 0) AS total_amount_spent
FROM customer AS c
LEFT JOIN payment AS p
    ON c.customer_id = p.customer_id
GROUP BY c.customer_id
HAVING COALESCE(SUM(p.amount), 0) > (
    SELECT AVG(total_gastado)
    FROM (
        SELECT
            c2.customer_id,
            COALESCE(SUM(p2.amount), 0) AS total_gastado
        FROM customer AS c2
        LEFT JOIN payment AS p2
            ON c2.customer_id = p2.customer_id
        GROUP BY c2.customer_id
    ) AS gastos_por_cliente
)
ORDER BY total_amount_spent DESC;