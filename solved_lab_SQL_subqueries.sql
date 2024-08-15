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
            title = 'Hunchback Impossible'
    );
    
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
    
SELECT
    a.first_name,
    a.last_name
FROM
    actor a
WHERE
    a.actor_id IN (
        SELECT
            fa.actor_id
        FROM
            film_actor fa
        WHERE
            fa.film_id = (
                SELECT
                    f.film_id
                FROM
                    film f
                WHERE
                    f.title = 'Alone Trip'
            )
    )
ORDER BY
    a.last_name, a.first_name;