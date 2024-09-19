-- Write SQL queries to perform the following tasks using the Sakila database:

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
-- List all films whose length is longer than the average length of all the films in the Sakila database.
-- Use a subquery to display all actors who appear in the film "Alone Trip".

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
    
SELECT 
	f.title,
    COUNT(i.inventory_id) AS num_copies
FROM 
    inventory i
JOIN 
    film f ON i.film_id = f.film_id
WHERE 
    f.title = 'Hunchback Impossible';
    
    
SELECT 
    COUNT(*) AS COPIES_OF_HUNCH
FROM 
    inventory
WHERE 
    film_id = (
    SELECT film_id 
    FROM film 
    WHERE title = 'Hunchback Impossible');
-- List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT 
    film_id, 
    title
FROM 
    film
WHERE 
    film.length > (SELECT AVG(length) FROM film);
    
-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT 
    act.first_name, 
    act.last_name
FROM 
    actor act
WHERE 
    act.actor_id IN (
        SELECT 
            fa.actor_id 
        FROM 
            film_actor fa
        JOIN 
            film f ON fa.film_id = f.film_id
        WHERE 
            f.title = 'Alone Trip'
    );

--

SELECT 
    act.first_name, 
    act.last_name
FROM 
    actor act
JOIN 
    film_actor fa ON act.actor_id = fa.actor_id
JOIN 
    film f ON fa.film_id = f.film_id
WHERE 
    f.title = 'Alone Trip';
    
    
--  

SELECT 
    act.first_name, 
    act.last_name
FROM 
    film f
JOIN 
    film_actor fa ON f.film_id = fa.film_id
JOIN 
    actor act ON fa.actor_id = act.actor_id
WHERE 
    f.title = 'Alone Trip';
    


