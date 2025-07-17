SELECT 
    title AS film_name,
    (
        SELECT COUNT(*)
        FROM inventory
        WHERE film_id = f.film_id
    ) AS inventory_count
FROM film AS f
WHERE f.title = 'Hunchback Impossible';

SELECT
    f.title AS title,
    f.length AS film_length
FROM
    film AS f
WHERE
	f.length > (
		SELECT AVG(length) FROM film
        )
ORDER BY film_length DESC;

SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS full_name
FROM actor AS a
JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
WHERE fa.film_id = (
	SELECT f.film_id
    FROM film AS f
    WHERE f.title = 'Alone Trip'
    );

SELECT 
    f.title AS film_name
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
WHERE c.name = 'Family';

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

SELECT actor_id, first_name, last_name, COUNT(film_id) AS film_count
FROM film_actor
JOIN actor USING (actor_id)
GROUP BY actor_id, first_name, last_name
ORDER BY film_count DESC
LIMIT 1;

SELECT f.title
FROM film_actor fa
JOIN film f ON fa.film_id = f.film_id
WHERE fa.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1
);

SELECT customer_id
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 1;

SELECT f.title
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
);

SELECT
    customer_id AS client_id,
    SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(client_total)
    FROM (
        SELECT SUM(amount) AS client_total
        FROM payment
        GROUP BY customer_id
    ) AS client_totals
);
