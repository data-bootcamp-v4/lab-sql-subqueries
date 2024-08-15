use sakila;

SELECT 
    film.title AS film_title,
    COUNT(inventory.inventory_id) AS copies_in_inventory
FROM 
    film
JOIN 
    inventory ON film.film_id = inventory.film_id
WHERE
    film.title = 'Hunchback Impossible';
    
    SELECT 
    film.title AS film_title,
    film.length AS film_length
FROM 
    film
WHERE 
    film.length > (SELECT AVG(length) FROM film);
    
    
    SELECT 
    actor_id, first_name, last_name
FROM 
    actor
WHERE 
    actor_id IN (
        SELECT 
            actor_id
        FROM 
            film_actor
        WHERE 
            film_id = (
                SELECT 
                    film_id
                FROM 
                    film
                WHERE 
                    title = 'Alone Trip'
            )
    );

SELECT AVG(length) AS avg_length
FROM film;
