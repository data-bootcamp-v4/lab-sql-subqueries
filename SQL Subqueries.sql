USE sakila;

-- =========================================================
-- SQL SUBQUERIES LAB
-- =========================================================


-- =========================================================
-- CHALLENGE 1
-- Determine the number of copies of the film
-- "Hunchback Impossible" in the inventory.
-- =========================================================

SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
);


-- =========================================================
-- CHALLENGE 2
-- List all films whose length is longer than the
-- average length of all films.
-- =========================================================

SELECT
    film_id,
    title,
    length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
)
ORDER BY length DESC, title;


-- =========================================================
-- CHALLENGE 3
-- Display all actors who appear in the film "Alone Trip".
-- =========================================================

SELECT
    actor_id,
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
)
ORDER BY last_name, first_name;


-- =========================================================
-- BONUS 1
-- Identify all movies categorized as family films.
-- =========================================================

SELECT
    film_id,
    title,
    description,
    release_year,
    rating
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_category
    WHERE category_id = (
        SELECT category_id
        FROM category
        WHERE name = 'Family'
    )
)
ORDER BY title;


-- =========================================================
-- BONUS 2A
-- Retrieve the name and email of customers from Canada
-- using subqueries.
-- =========================================================

SELECT
    customer_id,
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


-- =========================================================
-- BONUS 2B
-- Retrieve the name and email of customers from Canada
-- using joins.
--
-- Relationships:
-- customer.address_id = address.address_id
-- address.city_id = city.city_id
-- city.country_id = country.country_id
-- =========================================================

SELECT
    cu.customer_id,
    cu.first_name,
    cu.last_name,
    cu.email
FROM customer AS cu
INNER JOIN address AS ad
    ON cu.address_id = ad.address_id
INNER JOIN city AS ci
    ON ad.city_id = ci.city_id
INNER JOIN country AS co
    ON ci.country_id = co.country_id
WHERE co.country = 'Canada'
ORDER BY cu.last_name, cu.first_name;


-- =========================================================
-- BONUS 3A
-- Find the most prolific actor.
-- A prolific actor has appeared in the highest number
-- of films.
-- =========================================================

SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(fa.film_id) AS number_of_films
FROM actor AS a
INNER JOIN film_actor AS fa
    ON a.actor_id = fa.actor_id
GROUP BY
    a.actor_id,
    a.first_name,
    a.last_name
ORDER BY number_of_films DESC
LIMIT 1;


-- =========================================================
-- BONUS 3B
-- Find the films starred in by the most prolific actor.
-- =========================================================

SELECT
    film_id,
    title,
    release_year,
    length,
    rating
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_actor
    WHERE actor_id = (
        SELECT actor_id
        FROM film_actor
        GROUP BY actor_id
        ORDER BY COUNT(film_id) DESC
        LIMIT 1
    )
)
ORDER BY title;


-- =========================================================
-- BONUS 3C
-- Optional combined result showing the actor and films.
-- =========================================================

SELECT
    a.actor_id,
    CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
    f.film_id,
    f.title
FROM actor AS a
INNER JOIN film_actor AS fa
    ON a.actor_id = fa.actor_id
INNER JOIN film AS f
    ON fa.film_id = f.film_id
WHERE a.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1
)
ORDER BY f.title;


-- =========================================================
-- BONUS 4A
-- Find the most profitable customer.
-- This is the customer with the highest total payment.
-- =========================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_amount_spent
FROM customer AS c
INNER JOIN payment AS p
    ON c.customer_id = p.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_amount_spent DESC
LIMIT 1;


-- =========================================================
-- BONUS 4B
-- Find the films rented by the most profitable customer.
--
-- Tables used:
-- payment identifies the most profitable customer
-- rental connects the customer to inventory
-- inventory connects each rental to a film
-- film provides the film title
-- =========================================================

SELECT DISTINCT
    f.film_id,
    f.title
FROM film AS f
WHERE f.film_id IN (
    SELECT i.film_id
    FROM inventory AS i
    WHERE i.inventory_id IN (
        SELECT r.inventory_id
        FROM rental AS r
        WHERE r.customer_id = (
            SELECT customer_id
            FROM payment
            GROUP BY customer_id
            ORDER BY SUM(amount) DESC
            LIMIT 1
        )
    )
)
ORDER BY f.title;


-- =========================================================
-- BONUS 4C
-- Optional version using subquery and joins.
-- Also displays the customer's name and rental date.
-- =========================================================

SELECT DISTINCT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    f.film_id,
    f.title,
    r.rental_date
FROM customer AS c
INNER JOIN rental AS r
    ON c.customer_id = r.customer_id
INNER JOIN inventory AS i
    ON r.inventory_id = i.inventory_id
INNER JOIN film AS f
    ON i.film_id = f.film_id
WHERE c.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
)
ORDER BY r.rental_date, f.title;


-- =========================================================
-- BONUS 5
-- Retrieve the client_id and total_amount_spent for clients
-- who spent more than the average total amount spent
-- by each client.
--
-- In Sakila, the equivalent of client_id is customer_id.
-- =========================================================

SELECT
    customer_totals.customer_id AS client_id,
    customer_totals.total_amount_spent
FROM (
    SELECT
        customer_id,
        SUM(amount) AS total_amount_spent
    FROM payment
    GROUP BY customer_id
) AS customer_totals
WHERE customer_totals.total_amount_spent > (
    SELECT AVG(all_customer_totals.total_amount_spent)
    FROM (
        SELECT
            customer_id,
            SUM(amount) AS total_amount_spent
        FROM payment
        GROUP BY customer_id
    ) AS all_customer_totals
)
ORDER BY customer_totals.total_amount_spent DESC;