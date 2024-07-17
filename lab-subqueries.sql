-- Write SQL queries to perform the following tasks using the Sakila database:

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

-- 1.

SELECT 
    COUNT(i.inventory_id) AS inventory
FROM
    inventory i
WHERE
    i.film_id IN (SELECT 
            f.film_id
        FROM
            film f
        WHERE
            f.title = 'Hunchback Impossible');

-- 2.

SELECT 
    AVG(length)
FROM
    film AS avg_length;

SELECT 
    f.title
FROM
    film f
WHERE
    length > (SELECT 
            AVG(f.length)
        FROM
            film f);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT 
    a.first_name, a.last_name
FROM
    actor a
        JOIN
    film_actor fa ON a.actor_id = fa.actor_id
        JOIN
    film f ON fa.film_id = f.film_id
		WHERE
        f.title = "Alone Trip";

-- 3 using a subquerie

SELECT 
    a.first_name, a.last_name
FROM
    actor a
WHERE
    a.actor_id IN (SELECT 
            fa.actor_id
        FROM
            film_actor fa
                JOIN
            film f ON fa.film_id = f.film_id
        WHERE
            f.title = 'Alone Trip');