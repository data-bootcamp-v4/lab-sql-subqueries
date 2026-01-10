-- solutions.sql
-- SQL Subqueries Lab (Sakila)

USE sakila;

-- 1) Number of copies of "Hunchback Impossible" in inventory
SELECT
  f.title,
  COUNT(i.inventory_id) AS number_of_copies
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'HUNCHBACK IMPOSSIBLE'
GROUP BY f.film_id, f.title;

-- 2) Films longer than the average film length
SELECT
  film_id,
  title,
  length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC, title ASC;

-- 3) Subquery: actors who appear in the film "Alone Trip"
-- Tables: film -> film_actor -> actor
SELECT
  a.actor_id,
  a.first_name,
  a.last_name
FROM actor a
WHERE a.actor_id IN (
  SELECT fa.actor_id
  FROM film_actor fa
  WHERE fa.film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'ALONE TRIP'
    LIMIT 1
  )
)
ORDER BY a.last_name, a.first_name;

-- BONUS 1) Identify all movies categorized as family films
-- Tables: film -> film_category -> category
SELECT
  f.film_id,
  f.title
FROM film f
WHERE f.film_id IN (
  SELECT fc.film_id
  FROM film_category fc
  WHERE fc.category_id = (
    SELECT c.category_id
    FROM category c
    WHERE c.name = 'Family'
    LIMIT 1
  )
)
ORDER BY f.title;

-- BONUS 2) Customers from Canada: name + email using subqueries
-- Relevant tables: customer -> address -> city -> country
SELECT
  c.customer_id,
  CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
  c.email
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
      LIMIT 1
    )
  )
)
ORDER BY c.last_name, c.first_name;

-- BONUS 2) Customers from Canada: name + email using joins

SELECT
  c.customer_id,
  CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
  c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada'
ORDER BY c.last_name, c.first_name;

-- BONUS 3) Films starred by the most prolific actor
-- Prolific actor = actor with max number of films in film_actor

-- Step A: identify the most prolific actor (returns 1 row)
SELECT
  fa.actor_id,
  CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
  COUNT(*) AS films_count
FROM film_actor fa
JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY fa.actor_id, actor_name
ORDER BY films_count DESC
LIMIT 1;

-- Step B: list films for that most prolific actor (subquery)
SELECT
  f.film_id,
  f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
  SELECT fa2.actor_id
  FROM film_actor fa2
  GROUP BY fa2.actor_id
  ORDER BY COUNT(*) DESC
  LIMIT 1
)
ORDER BY f.title;

-- BONUS 4) Films rented by the most profitable customer
-- Most profitable customer = max total payments
-- Tables: payment -> customer ; rentals via rental/inventory/film

-- Step A: find the most profitable customer
SELECT
  p.customer_id,
  CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
  SUM(p.amount) AS total_spent
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
GROUP BY p.customer_id, customer_name
ORDER BY total_spent DESC
LIMIT 1;

-- Step B: films rented by that customer (distinct titles)
SELECT DISTINCT
  f.film_id,
  f.title
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.customer_id = (
  SELECT p.customer_id
  FROM payment p
  GROUP BY p.customer_id
  ORDER BY SUM(p.amount) DESC
  LIMIT 1
)
ORDER BY f.title;

-- BONUS 5) client_id and total_amount_spent for clients spending
-- more than the average of total spent per client.
-- Here "client_id" corresponds to customer_id in Sakila.
SELECT
  t.customer_id AS client_id,
  t.total_amount_spent
FROM (
  SELECT
    customer_id,
    SUM(amount) AS total_amount_spent
  FROM payment
  GROUP BY customer_id
) AS t
WHERE t.total_amount_spent > (
  SELECT AVG(t2.total_amount_spent)
  FROM (
    SELECT
      customer_id,
      SUM(amount) AS total_amount_spent
    FROM payment
    GROUP BY customer_id
  ) AS t2
)
ORDER BY t.total_amount_spent DESC;
