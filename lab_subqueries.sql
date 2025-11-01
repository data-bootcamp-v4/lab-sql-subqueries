use sakila;


-- 1

SELECT 
COUNT(*) AS copies
FROM inventory
WHERE film_id = (
  SELECT film_id
  FROM film
  WHERE title = 'Hunchback Impossible'
);



-- 2

SELECT title, length
FROM film
WHERE length > (
  SELECT AVG(length) FROM film
)
ORDER BY length DESC, title ASC;


-- 3

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
)
ORDER BY last_name ASC, first_name ASC;
