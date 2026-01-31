-- ==========================================================
-- Lab · SQL Subqueries (Sakila)
-- Objetivo: rellenar cada apartado con tu query
-- ==========================================================

USE sakila;

-- ==========================================================
-- CHALLENGE · Subqueries (core)
-- ==========================================================

-- ==========================================================
-- 1) Copies of "Hunchback Impossible" in inventory
--    - Determine the number of copies of the film in the inventory system.
-- ==========================================================
-- TODO:

SELECT
	f.title,
    (
		SELECT COUNT(i.film_id)
		FROM inventory i
        WHERE i.film_id = f.film_id
    ) AS num_copies
FROM film f
WHERE
	f.title = 'Hunchback Impossible';
	


-- ==========================================================
-- 2) Films longer than the average film length
--    - List all films whose length is longer than the average length of all films.
-- ==========================================================
-- TODO:
SELECT
	film_id,
    title
FROM film
WHERE
	length > (
		SELECT
			AVG(length)
		FROM film
	);


-- ==========================================================
-- 3) Actors who appear in "Alone Trip"
--    - Use a subquery to display all actors who appear in the film.
-- ==========================================================
-- TODO:
SELECT
  a.first_name,
  a.last_name
FROM actor AS a
WHERE a.actor_id IN (
  SELECT actor_id
  FROM film_actor AS fa
  JOIN film AS f
    ON fa.film_id = f.film_id
  WHERE f.title = 'Alone Trip'
);

    
-- ==========================================================
-- BONUS
-- ==========================================================

-- ==========================================================
-- 4) Family movies (category = family)
--    - Identify all movies categorized as family films.
-- ==========================================================
-- TODO:

SELECT
	f.title
FROM film f
WHERE f.film_id IN (
	SELECT
		film_id
	FROM film_category fc
	JOIN category c
		ON fc.category_id = c.category_id
	WHERE c.name = 'Family'
    );


-- ==========================================================
-- 5) Customers from Canada (subquery AND joins)
--    - Retrieve name and email of customers from Canada.
--    - Resolver 2 versiones: una con subquery y otra con JOINs.
-- ==========================================================
-- TODO (subquery):

SELECT
	customer.first_name,
    customer.last_name,
    customer.email
FROM customer AS customer
WHERE customer.address_id IN (
    SELECT a.address_id
    FROM address AS a
    JOIN city AS city
		ON a.city_id = city.city_id
	JOIN country AS c
		ON city.country_id = c.country_id
	WHERE c.country = 'Canada'
    );

-- TODO (joins):
SELECT
	customer.first_name,
    customer.last_name,
    customer.email
FROM customer AS customer
JOIN address AS address
	ON customer.address_id = address.address_id
JOIN city AS city
	ON address.city_id = city.city_id
JOIN country AS c
	ON city.country_id = c.country_id
WHERE c.country = 'Canada';


-- ==========================================================
-- 6) Films starred by the most prolific actor
--    - Find the actor with the highest number of films.
--    - Then list films for that actor_id.
-- ==========================================================
-- TODO:

SELECT
  f.title
FROM film AS f
JOIN film_actor AS fa
	ON f.film_id = fa.film_id
WHERE fa.actor_id = (
	SELECT most_prolific.actor_id
	FROM (
		SELECT
		actor_id,
		COUNT(DISTINCT film_id) AS num_films
		FROM film_actor
		GROUP BY actor_id
	) AS most_prolific
  ORDER BY most_prolific.num_films DESC
  LIMIT 1
);


-- ==========================================================
-- 7) Films rented by the most profitable customer
--    - Find the customer who has paid the largest total amount.
--    - Then list the films they rented.
-- ==========================================================
-- TODO:


SELECT
	f.title
FROM film AS f
JOIN inventory AS i
	ON f.film_id = i.film_id
JOIN rental AS r
	ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
	SELECT
		p.customer_id
	FROM payment AS p
	GROUP BY
		p.customer_id
	ORDER BY
		SUM(p.amount) DESC
	LIMIT 1
);

-- ==========================================================
-- 8) Clients who spent more than the average total spent
--    - Retrieve client_id and total_amount_spent for clients who spent more than
--      the average of total_amount_spent (per client).
-- ==========================================================
-- TODO:

SELECT
  t.customer_id,
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
);

-- ==========================================================
-- 9) Tiendas con ingresos por encima de la media
-- - Calcula el total ingresado por cada tienda (store_id).
-- - Devuelve store_id y total_revenue solo para las tiendas cuyo total_revenue
-- sea mayor que la media de total_revenue (por tienda).
-- - Pista: necesitas 2 niveles de agregación (SUM por tienda → AVG de esos SUM).
-- ===============================================

SELECT
	t.store_id,
    t.total_revenue
FROM (
	SELECT
		staff.store_id,
        SUM(pay.amount) AS total_revenue
	FROM payment AS pay
	JOIN staff AS staff
		ON pay.staff_id = staff.staff_id
	GROUP BY staff.store_id
    ) AS t
WHERE t.total_revenue > (
		SELECT AVG(t2.total_revenue)
		FROM (
			SELECT
			staff.store_id,
			SUM(pay.amount) AS total_revenue
			FROM payment AS pay
			JOIN staff AS staff
				ON pay.staff_id = staff.staff_id
			GROUP BY staff.store_id
		) AS t2
	);

