use sakila;


-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

select *
from inventory;

select count(*) as "Total Num of Copies"
from film
where title = 'Hunchback Impossible';

SELECT inventory_id, 
       (SELECT COUNT(*)
        FROM film
        WHERE title = 'Hunchback Impossible') AS "Total Num of Copies"
FROM inventory;

-- List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
);

-- Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT actor_id, 
       (SELECT COUNT(*) FROM film_actor
        WHERE film_id = (
        SELECT film_id FROM film 
        WHERE title = 'Alone Trip')) AS "Total Num of Actors"
FROM actor;

