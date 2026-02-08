SELECT 
    COUNT(i.inventory_id) AS number_of_copies
FROM 
    sakila.film f
JOIN 
    sakila.inventory i ON f.film_id = i.film_id
WHERE 
    f.title = 'Hunchback Impossible';
    
    SELECT 
    title, 
    length
FROM 
    sakila.film
WHERE 
    length > (SELECT AVG(length) FROM sakila.film);
    
    SELECT 
    a.first_name, 
    a.last_name
FROM 
    sakila.actor a
JOIN 
    sakila.film_actor fa ON a.actor_id = fa.actor_id
WHERE 
    fa.film_id = (SELECT film_id FROM sakila.film WHERE title = 'Alone Trip');