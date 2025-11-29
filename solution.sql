
# 1.
SELECT COUNT(*) AS num_copias
FROM inventory
WHERE film_id = (
  SELECT film_id
  FROM film
  WHERE title = 'Hunchback Impossible'
);

#2.
SELECT title, length
FROM film
WHERE length > (
  SELECT AVG(length)
  FROM film
);

#3.
SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (
  SELECT fa.actor_id
  FROM film_actor fa
  WHERE fa.film_id = (
    SELECT f.film_id
    FROM film f
    WHERE f.title = 'Alone Trip'
  )
);

#4.
SELECT f.film_id, f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family';

#5.
SELECT c.first_name, c.last_name, c.email
FROM customer c
WHERE c.address_id IN (
  SELECT a.address_id
  FROM address a
  WHERE a.city_id IN (
    SELECT ci.city_id
    FROM city ci
    WHERE ci.country_id = (
      SELECT co.country_id
      FROM country co
      WHERE co.country = 'Canada'
    )
  )
);

SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

#6.
SELECT fa.actor_id
FROM film_actor fa
GROUP BY fa.actor_id
ORDER BY COUNT(*) DESC
LIMIT 1;

SELECT DISTINCT f.film_id, f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
  SELECT fa2.actor_id
  FROM film_actor fa2
  GROUP BY fa2.actor_id
  ORDER BY COUNT(*) DESC
  LIMIT 1
);

SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS num_films
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY num_films DESC
LIMIT 1;

#7.
SELECT p.customer_id
FROM payment p
GROUP BY p.customer_id
ORDER BY SUM(p.amount) DESC
LIMIT 1;

SELECT DISTINCT f.film_id, f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
  SELECT p.customer_id
  FROM payment p
  GROUP BY p.customer_id
  ORDER BY SUM(p.amount) DESC
  LIMIT 1
);

#8.
SELECT
  p.customer_id AS client_id,
  SUM(p.amount) AS total_amount_spent
FROM payment p
GROUP BY p.customer_id
HAVING SUM(p.amount) > (
  SELECT AVG(total)
  FROM (
    SELECT SUM(p2.amount) AS total
    FROM payment p2
    GROUP BY p2.customer_id
  ) AS per_customer_totals
);

