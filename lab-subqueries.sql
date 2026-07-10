USE sakila;

## 1 ##
SELECT COUNT(film_id)
FROM inventory
WHERE film_id IN (select film_id from film where title = "Hunchback Impossible")
;

## 2 ##
SELECT title
FROM film
WHERE length > (SELECT AVG(length) FROM film)
;

## 3 ##
SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id 
					from film_actor 
					where film_id IN (select film_id 
										from film 
                                        where title = "Alone Trip")
					)
;
SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id 
    FROM film_actor 
    WHERE film_id IN (
        SELECT film_id 
        FROM film 
        WHERE title = 'Alone Trip'
    )
);