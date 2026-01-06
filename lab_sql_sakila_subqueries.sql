-- LAB | SQL Subqueries (Sakila Database)
-- ----------------------------------------
-- Note: Context
-- - film: movie catalog
-- - inventory: physical copies of each film per store
-- - actor: actors
-- - film_actor: bridge table (many-to-many) film <-> actor
-- - category: film categories (Family, Action, etc.)
-- - film_category:  bridge table film <-> category
-- - customer: customers
-- - address/city/country: customer location hierarchy
-- - rental: rentals (which copy was rented and by whom)
-- - payment: payments made by customers
-- ----------------------------------------------------------

-- 1. Count how many copies of the film "Hunchback Impossible" exist in the inventory.
-- Logic:
-- - inventory contains one row per physical copy
-- - join inventory with film to identify the movie by title
-- - count the number of inventory records for that film
-- -----------------------------------------------------------------------
SELECT
  COUNT(*) AS copies_in_inventory
FROM inventory i
JOIN film f
  ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible';

-- --------------------------------------------------------
-- 2. List all films whose length is greater than the average length of all films.
-- Logic:
-- - calculate the average length using a subquery
-- - filter films whose length is greater than that average
-- -----------------------------------------------------------------
SELECT
  title,
  length
FROM film
WHERE length > (
  SELECT AVG(length)
  FROM film
)
ORDER BY length DESC;


-- -------------------------------------------------------------------
-- 3. Display all actors who appear in the film "Alone Trip" using subqueries.
-- Logic:
-- 1) retrieve the film_id for "Alone Trip"
-- 2) retrieve all actor_id values linked to that film
-- 3) retrieve actor names using the list of actor_id values
-- -------------------------------------------------------------------
SELECT
  a.first_name,
  a.last_name
FROM actor a
WHERE a.actor_id IN (
  SELECT fa.actor_id
  FROM film_actor fa
  WHERE fa.film_id = (
    SELECT f.film_id
    FROM film f
    WHERE f.title = 'Alone Trip'
  )
)
ORDER BY a.last_name, a.first_name;


-- --------------------------------------------------------------
-- BONUS 4. Identify all movies categorized as Family films.
-- Logic:
-- - get the category_id for the 'Family' category
-- - retrieve all film_id values associated with that category
-- - retrieve film titles from the film table
-- ------------------------------------------------------------------------
SELECT
  f.title
FROM film f
WHERE f.film_id IN (
  SELECT fc.film_id
  FROM film_category fc
  WHERE fc.category_id = (
    SELECT c.category_id
    FROM category c
    WHERE c.name = 'Family'
  )
)
ORDER BY f.title;


-- ---------------------------------------------------------
-- BONUS 5. Retrieve the first name, last name, and email of customers from Canada (using subqueries).
-- Logic:
-- - customer -> address -> city -> country
-- - filter customers whose country is Canada using nested subqueries
-- ---------------------------------------------------------------------------------------------------------
SELECT
  c.first_name,
  c.last_name,
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
    )
  )
)
ORDER BY c.last_name, c.first_name;


-- --------------------------------------------------------------
-- BONUS 5. Retrieve the first name, last name, and email of customers from Canada (using JOINs).
-- Logic:
-- - perform the full join path:
-- customer -> address -> city -> country
-- - filter by country name = 'Canada'
-- ----------------------------------------------------------------------------------------------
SELECT
  c.first_name,
  c.last_name,
  c.email
FROM customer c
JOIN address a
  ON a.address_id = c.address_id
JOIN city ci
  ON ci.city_id = a.city_id
JOIN country co
  ON co.country_id = ci.country_id
WHERE co.country = 'Canada'
ORDER BY c.last_name, c.first_name;


-- ----------------------------------------------------------------------
-- BONUS 6. Find the films starred by the most prolific actor.
-- Definition:
-- - A prolific actor is the actor who has appeared in the highest number of films.
-- Logic:
-- 1) find the actor_id with the highest count in film_actor
-- 2) retrieve all film titles associated with that actor_id
-- Note:
-- - LIMIT 1 is used; ties are ignored for simplicity
-- -----------------------------------------------------------------------------------------------
SELECT
  f.title
FROM film f
JOIN film_actor fa
  ON fa.film_id = f.film_id
WHERE fa.actor_id = (
  SELECT fa2.actor_id
  FROM film_actor fa2
  GROUP BY fa2.actor_id
  ORDER BY COUNT(*) DESC
  LIMIT 1
)
ORDER BY f.title;


-- ---------------------------------------------------------------------
-- BONUS 6 (debug) Identify the most prolific actor.
-- This query is optional and useful for verification.
-- --------------------------------------------------------------------------
SELECT
  a.actor_id,
  a.first_name,
  a.last_name
FROM actor a
WHERE a.actor_id = (
  SELECT fa.actor_id
  FROM film_actor fa
  GROUP BY fa.actor_id
  ORDER BY COUNT(*) DESC
  LIMIT 1
);


-- ----------------------------------------------------------------------
-- BONUS 7. Find the films rented by the most profitable customer.
-- Definition:
-- - The most profitable customer is the one who has paid the highest total amount.
-- Logic:
-- 1) find the customer_id with the highest SUM(amount) in payment
-- 2) find all rentals made by that customer
-- 3) map rentals -> inventory -> film
-- 4) use DISTINCT to avoid duplicate film titles
-- ----------------------------------------------------------------------
SELECT DISTINCT
  f.title
FROM film f
JOIN inventory i
  ON i.film_id = f.film_id
JOIN rental r
  ON r.inventory_id = i.inventory_id
WHERE r.customer_id = (
  SELECT p.customer_id
  FROM payment p
  GROUP BY p.customer_id
  ORDER BY SUM(p.amount) DESC
  LIMIT 1
)
ORDER BY f.title;


-- ---------------------------------------------------------------------
-- BONUS 7. (Debug) Identify the most profitable customer.
-- This query is optional and useful for verification.
-- --------------------------------------------------------------------------
SELECT
  c.customer_id,
  c.first_name,
  c.last_name,
  SUM(p.amount) AS total_paid
FROM customer c
JOIN payment p
  ON p.customer_id = c.customer_id
GROUP BY
  c.customer_id, c.first_name, c.last_name
ORDER BY total_paid DESC
LIMIT 1;


-- -------------------------------------------------------------
-- BONUS 8. Retrieve customer_id and total_amount_spent for customers who spent more than the average total amount spent per customer.
-- Logic:
-- - calculate total spending per customer
-- - calculate the average of those totals
-- - filter customers whose total is above the average
-- Note:
-- - Sakila uses customer_id (not client_id)
-- ---------------------------------------------------------------------------------------------------------------------------------------------
SELECT
  t.customer_id,
  t.total_amount_spent
FROM (
  SELECT
    customer_id,
    SUM(amount) AS total_amount_spent
  FROM payment
  GROUP BY customer_id
) t
WHERE t.total_amount_spent > (
  SELECT AVG(x.total_amount_spent)
  FROM (
    SELECT
      customer_id,
      SUM(amount) AS total_amount_spent
    FROM payment
    GROUP BY customer_id
  ) x
)
ORDER BY t.total_amount_spent DESC;




