USE SAKILA;

SELECT
    COUNT(i.inventory_id) AS number_of_copies
FROM
    film AS f
JOIN
    inventory AS i ON f.film_id = i.film_id
WHERE
    f.title = 'Hunchback Impossible';
    
    SELECT
    title,
    length
FROM
    film
WHERE
    length > (SELECT AVG(length) FROM film)
ORDER BY
    length DESC;
    
SELECT
    a.first_name,
    a.last_name
FROM
    actor AS a
WHERE
    a.actor_id IN (
        SELECT
            fa.actor_id
        FROM
            film_actor AS fa
        WHERE
            fa.film_id = (
                SELECT
                    f.film_id
                FROM
                    film AS f
                WHERE
                    f.title = 'Alone Trip'
            )
    );
    
SELECT
    f.title
FROM
    film AS f
JOIN
    film_category AS fc ON f.film_id = fc.film_id
JOIN
    category AS c ON fc.category_id = c.category_id
WHERE
    c.name = 'Family'
ORDER BY
    f.title;
    
SELECT
    first_name,
    last_name,
    email
FROM
    customer
WHERE
    address_id IN (
        SELECT
            address_id
        FROM
            address
        WHERE
            city_id IN (
                SELECT
                    city_id
                FROM
                    city
                WHERE
                    country_id = (
                        SELECT
                            country_id
                        FROM
                            country
                        WHERE
                            country = 'Canada'
                    )
            )
    );
    
SELECT
    c.first_name,
    c.last_name,
    c.email
FROM
    customer AS c
JOIN
    address AS a ON c.address_id = a.address_id
JOIN
    city AS ci ON a.city_id = ci.city_id
JOIN
    country AS co ON ci.country_id = co.country_id
WHERE
    co.country = 'Canada'
ORDER BY
    c.last_name;
    
SELECT
    f.title
FROM
    film AS f
JOIN
    film_actor AS fa ON f.film_id = fa.film_id
WHERE
    fa.actor_id = (
        -- Step 1: Find the actor_id of the most prolific actor
        SELECT
            actor_id
        FROM
            film_actor
        GROUP BY
            actor_id
        ORDER BY
            COUNT(film_id) DESC
        LIMIT 1
    )
ORDER BY
    f.title;
    
SELECT
    f.title
FROM
    film AS f
JOIN
    inventory AS i ON f.film_id = i.film_id
JOIN
    rental AS r ON i.inventory_id = r.inventory_id
WHERE
    r.customer_id = (
        -- Step 1: Find the customer_id with the highest total payments
        SELECT
            customer_id
        FROM
            payment
        GROUP BY
            customer_id
        ORDER BY
            SUM(amount) DESC
        LIMIT 1
    )
ORDER BY
    f.title;
    
SELECT
    customer_id,
    total_amount_spent
FROM
    (
        -- Inner Subquery (Step 1): Calculate the total amount spent by each client
        SELECT
            customer_id,
            SUM(amount) AS total_amount_spent
        FROM
            payment
        GROUP BY
            customer_id
    ) AS CustomerTotal
WHERE
    total_amount_spent > (
        -- Middle Subquery (Step 2): Calculate the average of the total amounts spent by all clients
        SELECT
            AVG(total_amount_spent)
        FROM
            (
                SELECT
                    SUM(amount) AS total_amount_spent
                FROM
                    payment
                GROUP BY
                    customer_id
            ) AS AvgTotal
    )
ORDER BY
    total_amount_spent DESC;
    
