
-- sakila_joins.sql

use sakila;
-- Challenge 1: Subqueries (Nested Q.s) -- Use nested instead of Join statements   

SELECT 
    COUNT(*) AS copies_available
FROM
    inventory
WHERE
    film_id = (SELECT 
            film_id
        FROM
            film
        WHERE
            title = 'HUNCHBACK IMPOSSIBLE');

SELECT 
    title, length
FROM
    film
WHERE
    length > (SELECT 
            AVG(length)
        FROM
            film);

-- Challenge 3: Nested Subqueries
SELECT 
    first_name, last_name
FROM
    actor
WHERE
    actor_id IN (SELECT 
            actor_id
        FROM
            film_actor
        WHERE
            film_id = (SELECT 
                    film_id
                FROM
                    film
                WHERE
                    title = 'ALONE TRIP'));

-- Bonus 1: Family Movies
SELECT title FROM film 
WHERE film_id IN (
    SELECT film_id 
    FROM film_category 
    WHERE category_id = (
        SELECT category_id 
        FROM category 
        WHERE name = 'Family'
    )
);

-- Bonus 2: Find Canadian Customers
-- map customer -> address -> city -> country
SELECT 
    cu.first_name, cu.email
FROM
    customer AS cu
        JOIN
    address AS a ON cu.address_id = a.address_id
        JOIN
    city AS ci ON a.city_id = ci.city_id
        JOIN
    country AS co ON ci.country_id = co.country_id
WHERE
    co.country = 'Canada';

-- Bonus 3: Films with the most prolific actor
-- Find actor with the most film, then JOIN film w film_actor to get titles
SELECT 
    f.title
FROM
    film AS f
        JOIN
    film_actor AS fa ON f.film_id = fa.film_id
WHERE
    fa.actor_id = (SELECT 
            actor_id
        FROM
            film_actor
        GROUP BY actor_id
        ORDER BY COUNT(film_id) DESC
        LIMIT 1);

-- Bonus 4: Films rented by best customer

SELECT DISTINCT
    f.title
FROM
    film AS f
        JOIN
    inventory AS i ON f.film_id = i.film_id
        JOIN
    rental AS r ON i.inventory_id = r.inventory_id
WHERE
    r.customer_id = (SELECT 
            customer_id
        FROM
            payment
        GROUP BY customer_id
        ORDER BY SUM(amount) DESC
        LIMIT 1);

-- Bonus 5: Customers who spent over average NN