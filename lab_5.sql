USE sakila;

-- 1
SELECT 
    film.title,
    COUNT(inventory.inventory_id) AS nr_copies -- number of inventory records for the film
FROM 
    film
JOIN 
    inventory 
ON 
film.film_id = inventory.film_id
WHERE 
    film.title = 'Hunchback Impossible'
GROUP BY 
    film.title;
    
-- 2
SELECT 
	film.title,
    film.length,
    (SELECT ROUND(AVG(film.length), 0)FROM film) AS av_length
FROM film
WHERE
	film.length > (
    SELECT 
		AVG(film.length)
	FROM film
);

-- 3
SELECT 
    actor.first_name,
    actor.last_name
FROM 
    film
JOIN 
    film_actor 
ON 
	film.film_id = film_actor.film_id
JOIN
	actor
ON
	film_actor.actor_id = actor.actor_id
WHERE 
    film.title = 'Alone Trip';
    
-- 4

SELECT 
	film.title,
    category.name
FROM 
	film
JOIN
	film_category
ON 
	film.film_id = film_category.film_Id
JOIN 
	category
ON
	film_category.category_id = category.category_id
WHERE 
    category.name = 'Family';
    
