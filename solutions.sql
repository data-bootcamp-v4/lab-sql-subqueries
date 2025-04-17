#1
SELECT 
    COUNT(*) AS number_of_copies
FROM 
    inventory
WHERE 
    film_id = (
        SELECT film_id
        FROM film
        WHERE title = 'Hunchback Impossible'
    );
    
#2
SELECT 
    title, 
    length
FROM 
    film
WHERE 
    length > (
        SELECT AVG(length)
        FROM film
    );
    
#3
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (
        SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
    )
);

#4
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family';