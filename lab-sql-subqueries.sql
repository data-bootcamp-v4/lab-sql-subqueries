SELECT COUNT(*) FROM inventory WHERE film_id = (SELECT film_id FROM film WHERE title = 'HUNCHBACK IMPOSSIBLE');

SELECT title FROM film WHERE length > (SELECT AVG(length) FROM film);

SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (
  SELECT fa.actor_id
  FROM film_actor fa
  WHERE fa.film_id = (SELECT film_id FROM film WHERE title = 'ALONE TRIP')
);

SELECT title
FROM film
WHERE film_id IN (
  SELECT film_id
  FROM film_category
  WHERE category_id = (SELECT category_id FROM category WHERE name = 'Family')
);

SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
  SELECT address_id
  FROM address
  WHERE city_id IN (
    SELECT city_id
    FROM city
    WHERE country_id = (SELECT country_id FROM country WHERE country = 'Canada')
  )
);

SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
  SELECT actor_id
  FROM film_actor
  GROUP BY actor_id
  ORDER BY COUNT(*) DESC
  LIMIT 1
);

SELECT DISTINCT f.title
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE p.customer_id = (
  SELECT customer_id
  FROM (
    SELECT customer_id, SUM(amount) AS total
    FROM payment
    GROUP BY customer_id
    ORDER BY total DESC
    LIMIT 1
  ) t
);

SELECT customer_id, SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
  SELECT AVG(total_per_customer)
  FROM (
    SELECT SUM(amount) AS total_per_customer
    FROM payment
    GROUP BY customer_id
  ) s
);