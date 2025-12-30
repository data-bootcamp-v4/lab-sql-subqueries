USE sakila;

# 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(*) AS copies
FROM inventory i
JOIN film f ON f.film_id = i.film_id
WHERE f.title = 'HUNCHBACK IMPOSSIBLE';

# 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT film_id, title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC, title;

# 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (
  SELECT fa.actor_id
  FROM film f
  JOIN film_actor fa ON fa.film_id = f.film_id
  WHERE f.title = 'ALONE TRIP'
)
ORDER BY a.last_name, a.first_name;
