-- Write SQL queries to perform the following tasks using the Sakila database:

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
-- List all films whose length is longer than the average length of all the films in the Sakila database.
-- Use a subquery to display all actors who appear in the film "Alone Trip".

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
Select * from sakila.film where title like "Hunch%";
-- Comment Maurits: can't figure out how to derive at an inventory amount,

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT 
    *
FROM
    sakila.film
WHERE
    length > (SELECT 
            ROUND(AVG(length), 2) AS average
        FROM
            sakila.film);
	
-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT 
    *
FROM
    sakila.actor
WHERE
    actor_id IN (SELECT 
            actor_id
        FROM
            sakila.film_actor
        WHERE
            film_id = (SELECT 
                    film_id
                FROM
                    sakila.film
                WHERE
                    title = 'Alone Trip'));