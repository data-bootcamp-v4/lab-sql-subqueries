USE sakila;

SELECT COUNT(*) AS copies
FROM inventory i
JOIN film f ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible';
-- (Optional breakdown)
-- SELECT i.store_id, COUNT(*) AS copies
-- FROM inventory i JOIN film f ON f.film_id=i.film_id
-- WHERE f.title='Hunchback Impossible'
-- GROUP BY i.store_id;

SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (
  SELECT fa.actor_id
  FROM film_actor fa
  WHERE fa.film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip')
)
ORDER BY a.last_name, a.first_name;

SELECT f.film_id, f.title
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c       ON c.category_id = fc.category_id
WHERE c.name = 'Family'
ORDER BY f.title;

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
)
ORDER BY last_name, first_name;

SELECT cu.first_name, cu.last_name, cu.email
FROM customer cu
JOIN address a ON cu.address_id = a.address_id
JOIN city ci   ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada'
ORDER BY cu.last_name, cu.first_name;

SELECT a.actor_id, a.first_name, a.last_name, f.title
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film f        ON f.film_id  = fa.film_id
WHERE a.actor_id = (
  SELECT actor_id
  FROM film_actor
  GROUP BY actor_id
  ORDER BY COUNT(*) DESC
  LIMIT 1
)
ORDER BY f.title;

SELECT a.actor_id, a.first_name, a.last_name, ac.n_films, f.title
FROM (
  SELECT actor_id, COUNT(*) AS n_films
  FROM film_actor
  GROUP BY actor_id
) ac
JOIN (
  SELECT MAX(cnt) AS max_cnt
  FROM (SELECT actor_id, COUNT(*) AS cnt FROM film_actor GROUP BY actor_id) t
) m ON ac.n_films = m.max_cnt
JOIN actor a      ON a.actor_id  = ac.actor_id
JOIN film_actor fa ON fa.actor_id = ac.actor_id
JOIN film f        ON f.film_id   = fa.film_id
ORDER BY a.last_name, a.first_name, f.title;

-- most profitable customer_id
-- SELECT customer_id FROM payment GROUP BY customer_id ORDER BY SUM(amount) DESC LIMIT 1;

SELECT DISTINCT f.title
FROM payment p
JOIN rental r    ON p.rental_id   = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f      ON i.film_id      = f.film_id
WHERE p.customer_id = (
  SELECT customer_id
  FROM payment
  GROUP BY customer_id
  ORDER BY SUM(amount) DESC
  LIMIT 1
)
ORDER BY f.title;

-- totals per customer
SELECT t.customer_id, t.total_amount
FROM (
  SELECT customer_id, SUM(amount) AS total_amount
  FROM payment
  GROUP BY customer_id
) t
WHERE t.total_amount > (
  SELECT AVG(total_amount)
  FROM (
    SELECT customer_id, SUM(amount) AS total_amount
    FROM payment
    GROUP BY customer_id
  ) x
)
ORDER BY t.total_amount DESC;
-- (Optional) include names:
-- SELECT cu.customer_id, cu.first_name, cu.last_name, t.total_amount
-- FROM ( ...same t subquery... ) t
-- JOIN customer cu ON cu.customer_id = t.customer_id
-- WHERE t.total_amount > ( ...same AVG subquery... )
-- ORDER BY t.total_amount DESC;

