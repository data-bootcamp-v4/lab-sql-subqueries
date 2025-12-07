--Number of copies of the film "Hunchback Impossible" in inventory.
SELECT
    COUNT(inventory_id) AS number_of_copies
FROM
    inventory
WHERE
    film_id = (
        SELECT
            film_id
        FROM
            film
        WHERE
            title = 'HUNCHBACK IMPOSSIBLE'
    );
--Films longer than the average length of all films.
SELECT
    title,
    length
FROM
    film
WHERE
    length > (
        SELECT
            AVG(length)
        FROM
            film
    )
ORDER BY
    length DESC;
--Actors who appear in the film "Alone Trip"
SELECT
    first_name,
    last_name
FROM
    actor
WHERE
    actor_id IN (
        SELECT
            actor_id
        FROM
            film_actor
        WHERE
            film_id = (
                SELECT
                    film_id
                FROM
                    film
                WHERE
                    title = 'ALONE TRIP'
            )
    );
    --Identify all movies categorized as family films.
SELECT
    title
FROM
    film
WHERE
    film_id IN (
        SELECT
            film_id
        FROM
            film_category
        WHERE
            category_id = (
                SELECT
                    category_id
                FROM
                    category
                WHERE
                    name = 'Family'
            )
    );
--Name and email of customers from Canada.
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
    --Using Joins (More Efficient)
SELECT
    c.first_name,
    c.last_name,
    c.email
FROM
    customer c
JOIN
    address a ON c.address_id = a.address_id
JOIN
    city ci ON a.city_id = ci.city_id
JOIN
    country co ON ci.country_id = co.country_id
WHERE
    co.country = 'Canada';
--Films starred by the most prolific actor.
SELECT
    f.title
FROM
    film f
JOIN
    film_actor fa ON f.film_id = fa.film_id
WHERE
    fa.actor_id = (
        SELECT
            actor_id
        FROM
            film_actor
        GROUP BY
            actor_id
        ORDER BY
            COUNT(film_id) DESC
        LIMIT 1
    );
--Films rented by the most profitable customer.
SELECT
    f.title
FROM
    film f
JOIN
    inventory i ON f.film_id = i.film_id
JOIN
    rental r ON i.inventory_id = r.inventory_id
WHERE
    r.customer_id = (
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
GROUP BY
    f.title;
--Clients who spent more than the average of the total amount spent by each client.
SELECT
    customer_id,
    SUM(amount) AS total_amount_spent
FROM
    payment
GROUP BY
    customer_id
HAVING
    total_amount_spent > (
        SELECT
            AVG(total_spent)
        FROM
            (
                SELECT
                    SUM(amount) AS total_spent
                FROM
                    payment
                GROUP BY
                    customer_id
            ) AS client_totals
    )
ORDER BY
    total_amount_spent DESC;
