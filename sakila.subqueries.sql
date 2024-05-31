USE sakila;

-- 1.Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = "Hunchback Impossible"
);


-- 2.List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length) 
    FROM film
);

-- 3.Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT a.first_name, a.last_name from actor as a
JOIN film_actor as fa
ON a.actor_id = fa.actor_id
WHERE fa.film_id = (
    SELECT film_id
    FROM film
    WHERE title = "Alone Trip"
);




 





