SELECT 
    COUNT(*) AS numero_de_copias
FROM inventory
WHERE film_id = (
    SELECT film_id 
    FROM film 
    WHERE title = 'Hunchback Impossible'
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
    title AS titulo
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
);

SELECT 
    c.first_name,
    c.last_name,
    c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

SELECT 
    actor_id,
    COUNT(film_id) AS total_peliculas
FROM film_actor
GROUP BY actor_id
ORDER BY total_peliculas DESC
LIMIT 1;

SELECT 
    f.title AS titulo
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
    f.title AS pelicula
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

SELECT 
    customer_id,
    SUM(amount) AS total_gastado
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total_cliente)
    FROM (
        SELECT SUM(amount) AS total_cliente
        FROM payment
        GROUP BY customer_id
    ) AS subconsulta
)
ORDER BY total_gastado DESC;

