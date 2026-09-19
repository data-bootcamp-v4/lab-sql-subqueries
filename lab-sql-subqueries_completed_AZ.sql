USE sakila;

-- 1. Number of copies of Hunchback Impossible in inventory.
SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
);


-- 2. Films that are longer than the average film length.
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


-- 3. Actors who appear in Alone Trip.
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


-- 4. Movies categorized as family films.
SELECT
    film_id,
    title
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


-- 5a. Canadian customers using subqueries.
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


-- 5b. Canadian customers using joins.
SELECT
    cu.first_name,
    cu.last_name,
    cu.email
FROM customer AS cu
JOIN address AS a
    ON cu.address_id = a.address_id
JOIN city AS ci
    ON a.city_id = ci.city_id
JOIN country AS co
    ON ci.country_id = co.country_id
WHERE co.country = 'Canada'
ORDER BY cu.last_name, cu.first_name;


-- 6. Films starring the actor who appeared in the most films.
SELECT
    film_id,
    title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_actor
    WHERE actor_id = (
        SELECT actor_id
        FROM film_actor
        GROUP BY actor_id
        ORDER BY COUNT(*) DESC
        LIMIT 1
    )
)
ORDER BY title;


-- 7. Films rented by the customer who spent the most money.
SELECT DISTINCT
    f.film_id,
    f.title
FROM film AS f
JOIN inventory AS i
    ON f.film_id = i.film_id
JOIN rental AS r
    ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
)
ORDER BY f.title;


-- 8. Clients whose total spending is above the average client total.
SELECT
    customer_totals.customer_id AS client_id,
    ROUND(customer_totals.total_amount_spent, 2) AS total_amount_spent
FROM (
    SELECT
        customer_id,
        SUM(amount) AS total_amount_spent
    FROM payment
    GROUP BY customer_id
) AS customer_totals
WHERE customer_totals.total_amount_spent > (
    SELECT AVG(all_totals.total_amount_spent)
    FROM (
        SELECT
            customer_id,
            SUM(amount) AS total_amount_spent
        FROM payment
        GROUP BY customer_id
    ) AS all_totals
)
ORDER BY total_amount_spent DESC;
