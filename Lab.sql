USE sakila;

#1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT  COUNT(*) AS total_number
FROM inventory
WHERE film_id =
(SELECT film_id
FROM film
WHERE title = "Hunchback Impossible");

#2 List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title
FROM film
WHERE length > (
  SELECT AVG(length)
  FROM film
)
ORDER BY title ASC;

#3 Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa USING (actor_id)
JOIN film f USING (film_id)
WHERE f.film_id = (
  SELECT film_id
  FROM film
  WHERE title = 'Alone Trip'
);



