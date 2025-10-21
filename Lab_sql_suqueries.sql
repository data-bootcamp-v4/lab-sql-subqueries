-- 1.Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT 
    f.title,
    COUNT(i.inventory_id) AS total_copies
FROM sakila.film AS f
JOIN sakila.inventory AS i
    ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible';

SELECT * FROM sakila.film
SELECT * FROM sakila.inventory


-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM sakila.film
WHERE length > (SELECT AVG(length) FROM sakila.film);

-- 3.Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT * FROM sakila.film -- film_id title 
SELECT * FROM sakila.film_actor -- actor_id film_id


SELECT actor_id FROM sakila.film_actor
WHERE film_id = (SELECT film_id
FROM sakila.film
WHERE title = "Alone Trip");

SELECT first_name, last_name
FROM sakila.actor
WHERE actor_id IN (
  SELECT actor_id 
  FROM sakila.film_actor
  WHERE film_id = (
    SELECT film_id
    FROM sakila.film
    WHERE title = 'Alone Trip'
  )
);

-- Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
SELECT * FROM sakila.category -- category_id e name 8 Famiy
SELECT * FROM sakila.film_category  -- film_id category_id

SELECT f.title
FROM sakila.film AS f
JOIN sakila.film_category AS fc
  ON f.film_id = fc.film_id
JOIN sakila.category AS c
  ON fc.category_id = c.category_id
WHERE c.name = 'Family';