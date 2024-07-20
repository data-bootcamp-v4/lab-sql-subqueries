USE sakila;
---- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT
    f.title,
    COUNT(i.inventory_id) AS number_of_copies
FROM
    film f
INNER JOIN
    inventory i ON f.film_id = i.film_id
WHERE
    f.title = 'Hunchback Impossible'
GROUP BY
    f.title;
---- List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT
    film.title,
    film.length
FROM
    film
WHERE
    film.length > (SELECT AVG(length) FROM film);
--- Use a subquery to display all actors who appear in the film "Alone Trip"
SELECT 
    a.actor_id,
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
        INNER JOIN 
            film f ON fa.film_id = f.film_id
        WHERE 
            f.title = 'Alone Trip'
    );