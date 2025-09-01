-- Count inventory rows for the film "HUNCHBACK IMPOSSIBLE"
SELECT COUNT(*) AS copies
FROM inventory
WHERE film_id = (
  SELECT film_id FROM film WHERE title = 'HUNCHBACK IMPOSSIBLE'
);

-- Compare each film length to the average length
SELECT film_id, title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC, title;

-- Get actors whose IDs match those in film_actor for "ALONE TRIP"
SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (
  SELECT fa.actor_id
  FROM film_actor fa
  WHERE fa.film_id = (SELECT film_id FROM film WHERE title = 'ALONE TRIP')
)
ORDER BY a.last_name, a.first_name;

-- Films that belong to the "Family" category
SELECT f.film_id, f.title
FROM film f
WHERE f.film_id IN (
  SELECT fc.film_id
  FROM film_category fc
  WHERE fc.category_id = (SELECT category_id FROM category WHERE name = 'Family')
)
ORDER BY f.title;


-- Join customer → address → city, filter by Canada
SELECT c.customer_id,
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       c.email
FROM customer c
JOIN address a  ON c.address_id = a.address_id
JOIN city ci    ON a.city_id = ci.city_id
WHERE ci.country_id = (
  SELECT country_id FROM country WHERE country = 'Canada'
)
ORDER BY customer_name;


-- Count films per actor, find the max
SELECT a.actor_id, a.first_name, a.last_name, t.film_count
FROM actor a
JOIN (
  SELECT actor_id, COUNT(*) AS film_count
  FROM film_actor
  GROUP BY actor_id
) t ON a.actor_id = t.actor_id
WHERE t.film_count = (
  SELECT MAX(film_count) FROM (
    SELECT actor_id, COUNT(*) AS film_count
    FROM film_actor
    GROUP BY actor_id
  ) x
);


-- Get films acted in by the most prolific actor(s)
SELECT DISTINCT f.film_id, f.title
FROM film f
JOIN film_actor fa ON fa.film_id = f.film_id
WHERE fa.actor_id IN (
  SELECT a.actor_id
  FROM actor a
  JOIN (
    SELECT actor_id, COUNT(*) AS film_count
    FROM film_actor
    GROUP BY actor_id
  ) t ON a.actor_id = t.actor_id
  WHERE t.film_count = (
    SELECT MAX(film_count) FROM (
      SELECT actor_id, COUNT(*) AS film_count
      FROM film_actor
      GROUP BY actor_id
    ) x
  )
)
ORDER BY f.title;


-- Find customer with highest total payment, list their rented films
SELECT DISTINCT f.film_id, f.title
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f      ON i.film_id = f.film_id
WHERE r.customer_id = (
  SELECT p.customer_id
  FROM payment p
  GROUP BY p.customer_id
  ORDER BY SUM(p.amount) DESC
  LIMIT 1
)
ORDER BY f.title;


-- Compare each customer's total spending with the average spending
SELECT p.customer_id,
       ROUND(SUM(p.amount), 2) AS total_spent
FROM payment p
GROUP BY p.customer_id
HAVING SUM(p.amount) > (
  SELECT AVG(total_by_customer)
  FROM (
    SELECT SUM(amount) AS total_by_customer
    FROM payment
    GROUP BY customer_id
  ) t
)
ORDER BY total_spent DESC;

