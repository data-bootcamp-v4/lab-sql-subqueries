-- Display all available tables in the Sakila database.
USE sakila;

SHOW TABLES;

-- 1.
SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id =(
   SELECT film_id
   FROM film
   WHERE title = 'Hunchback impossible'
);

-- 2. 
SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
);
   
-- 3. 
SELECT first_name, last_name
FROM actor
WHERE actor_id IN(
   SELECT actor_id
   FROM film_actor
   WHERE film_id = (
      SELECT film_id
      FROM film
      WHERE title = 'Alone Trip'
      )
);

-- 4. Bonus
SELECT title
FROM film
WHERE film_id IN (
   SELECT film_id

FROM film_category
WHERE category_id = (
   SELECT category_id
   FROM category
   WHERE name = 'Family'
   )
);
   