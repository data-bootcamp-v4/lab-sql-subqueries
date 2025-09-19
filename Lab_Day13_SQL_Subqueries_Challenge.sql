-- 1. Number of copies of "Hunchback Impossible"
SELECT 
    COUNT(*) AS total_copies
FROM inventory
JOIN film ON inventory.film_id = film.film_id
WHERE film.title = 'Hunchback Impossible';

-- 2. Films longer than average length
SELECT 
    title,
    length
FROM film
WHERE length > (
    SELECT AVG(length) FROM film
);

-- 3. Actors in "Alone Trip"
SELECT 
    actor.first_name,
    actor.last_name
FROM actor
WHERE actor.actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (
        SELECT film_id FROM film WHERE title = 'Alone Trip'
    )
);

-- 4. Family movies for promotion
SELECT 
    film.title
FROM film
WHERE film.film_id IN (
    SELECT film_id
    FROM film_category
    WHERE category_id = (
        SELECT category_id FROM category WHERE name = 'Family'
    )
);

-- 5. Canadian customers (subquery and join)
-- Subquery
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
            SELECT country_id FROM country WHERE country = 'Canada'
        )
    )
);

-- Join
SELECT 
    customer.first_name,
    customer.last_name,
    customer.email
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE country.country = 'Canada';

-- 6. Films by most prolific actor
SELECT 
    film.title
FROM film
WHERE film.film_id IN (
    SELECT film_id
    FROM film_actor
    WHERE actor_id = (
        SELECT actor_id
        FROM (
            SELECT actor_id, COUNT(film_id) AS film_count
            FROM film_actor
            GROUP BY actor_id
            ORDER BY film_count DESC
            LIMIT 1
        ) AS prolific_actor
    )
);

-- 7. Films rented by most profitable customer
SELECT 
    film.title
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.customer_id = (
    SELECT customer_id
    FROM (
        SELECT customer_id, SUM(amount) AS total_spent
        FROM payment
        GROUP BY customer_id
        ORDER BY total_spent DESC
        LIMIT 1
    ) AS top_customer
);

-- 8. Clients who spent more than average
SELECT 
    customer_id,
    SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total_by_customer)
    FROM (
        SELECT SUM(amount) AS total_by_customer
        FROM payment
        GROUP BY customer_id
    ) AS customer_totals
);
