
-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT 
    Film.title, 
    COUNT(Inventory.inventory_id) AS number_of_copies
FROM 
    film Film
    JOIN inventory Inventory ON Film.film_id = Inventory.film_id
WHERE 
    Film.title = 'Hunchback Impossible'
GROUP BY 
    Film.title;

-- 2. 2.	List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT 
    title,
    length
FROM 
    film 
WHERE 
    length > (SELECT AVG(length) FROM film);
-- 3.Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT 
    Actor.first_name, 
    Actor.last_name
FROM 
    actor Actor
JOIN 
    film_actor FilmActor ON Actor.actor_id = FilmActor.actor_id
WHERE 
    FilmActor.film_id = (
        SELECT 
            Film.film_id
        FROM 
            film Film
        WHERE 
            Film.title = 'Alone Trip'
    );