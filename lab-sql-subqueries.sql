-- Write SQL queries to perform the following tasks using the Sakila database:
USE sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT 
    COUNT(title)
FROM
    inventory AS i
        JOIN
    film AS f ON f.film_id = i.film_id
WHERE
    title = 'Hunchback Impossible';

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT * FROM film 
WHERE length > (SELECT AVG(length) FROM film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT * FROM actor;
SELECT * FROM film_actor;

SELECT 
    a.first_name, a.last_name, f.title
FROM
    actor AS a
        JOIN
    film_actor AS fa ON a.actor_id = fa.actor_id
        JOIN
    film AS f ON fa.film_id = f.film_id
WHERE
    f.film_id IN (SELECT 
            film_id
        FROM
            film
        WHERE
            title = 'Alone Trip');
            
-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

SELECT 
    f.title, c.name
FROM
    film AS f
        JOIN
    film_category AS fc ON f.film_id = fc.film_id
        JOIN
    category AS c ON c.category_id = fc.category_id
WHERE
    name = 'Family';

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.

SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS full_name, c.email
FROM
    customer AS c
        JOIN
    address AS a ON c.address_id = a.address_id
        JOIN
    city AS ci ON a.city_id = ci.city_id
WHERE
    ci.country_id IN (SELECT 
            co.country_id
        FROM
            country AS co
        WHERE
            co.country = 'Canada');
            
-- 6. Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
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
        ORDER BY COUNT(*) DESC
        LIMIT 1);


