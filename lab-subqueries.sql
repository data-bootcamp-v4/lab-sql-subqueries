USE sakila;

-- 1) Number of copies of "Hunchback Impossible" in inventory
SELECT
    COUNT(*) AS copies_in_inventory
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
);

-- 2) Films whose length is longer than the average length of all films
SELECT
    title,
    length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
)
ORDER BY length ASC, title ASC;

-- 3) Actors who appear in the film "Alone Trip"
SELECT
    a.actor_id,
    a.first_name,
    a.last_name
FROM actor a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    WHERE fa.film_id = (
        SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
    )
)
ORDER BY a.last_name ASC, a.first_name ASC;

-- BONUS 4) Movies categorized as family films
SELECT
    f.title
FROM film f
WHERE f.film_id IN (
    SELECT fc.film_id
    FROM film_category fc
    WHERE fc.category_id = (
        SELECT c.category_id
        FROM category c
        WHERE c.name = 'Family'
    )
)
ORDER BY f.title ASC;

-- BONUS 5a) Name and email of customers from Canada using subqueries
SELECT
    c.first_name,
    c.last_name,
    c.email
FROM customer c
WHERE c.address_id IN (
    SELECT a.address_id
    FROM address a
    WHERE a.city_id IN (
        SELECT ci.city_id
        FROM city ci
        WHERE ci.country_id = (
            SELECT co.country_id
            FROM country co
            WHERE co.country = 'Canada'
        )
    )
)
ORDER BY c.last_name ASC, c.first_name ASC;

-- BONUS 5b) Name and email of customers from Canada using joins
SELECT
    c.first_name,
    c.last_name,
    c.email
FROM customer c
JOIN address a
    ON c.address_id = a.address_id
JOIN city ci
    ON a.city_id = ci.city_id
JOIN country co
    ON ci.country_id = co.country_id
WHERE co.country = 'Canada'
ORDER BY c.last_name ASC, c.first_name ASC;

-- BONUS 6) Films starred by the most prolific actor
SELECT
    f.title
FROM film f
WHERE f.film_id IN (
    SELECT fa.film_id
    FROM film_actor fa
    WHERE fa.actor_id = (
        SELECT fa2.actor_id
        FROM film_actor fa2
        GROUP BY fa2.actor_id
        ORDER BY COUNT(*) DESC, fa2.actor_id ASC
        LIMIT 1
    )
)
ORDER BY f.title ASC;

-- BONUS 7) Films rented by the most profitable customer
SELECT DISTINCT
    f.title
FROM film f
WHERE f.film_id IN (
    SELECT i.film_id
    FROM inventory i
    WHERE i.inventory_id IN (
        SELECT r.inventory_id
        FROM rental r
        WHERE r.customer_id = (
            SELECT 