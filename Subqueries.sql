USE sakila;

-- 1. Determina cuántas copias de la película "Hunchback Impossible" existen en el sistema de inventario.

SELECT 
    f.title,
    COUNT(i.inventory_id) AS number_of_copies
FROM film f
JOIN inventory i 
    ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.title;

-- 2. Lista todas las películas cuya duración (length) 
--    sea mayor que la duración promedio de todas las películas 

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

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


-- 3. Usa una subconsulta para mostrar todos los actores 
--    que aparecen en la película "Alone Trip".

SELECT film_id
FROM film_category
WHERE category_id = (SELECT category_id
				FROM category
				WHERE name = 'Family');
                
SELECT title
FROM film
WHERE film_id IN (
	SELECT film_id
	FROM film_category
	WHERE category_id = (
		SELECT category_id
		FROM category
		WHERE name = 'Family')
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
FROM customer c
JOIN address a 
    ON c.address_id = a.address_id
WHERE city_id IN (
        SELECT city_id
        FROM city
        WHERE country_id = (
            SELECT country_id
            FROM country
            WHERE country = 'Canada'));
            
SELECT 
    a.actor_id,
    a.first_name,
    a.last_name,
    f.film_id,
    f.title
FROM actor a
JOIN film_actor fa 
    ON a.actor_id = fa.actor_id
JOIN film f 
    ON fa.film_id = f.film_id
WHERE a.actor_id = (
    SELECT fa2.actor_id
    FROM film_actor fa2
    GROUP BY fa2.actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- Clientes que gastaron más que el promedio total
SELECT customer_id, SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total_per_customer)
    FROM (
        SELECT SUM(amount) AS total_per_customer
        FROM payment
        GROUP BY customer_id
    ) AS sub
);

