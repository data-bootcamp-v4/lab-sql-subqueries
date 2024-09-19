-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT
	f.title as film,
	count(i.film_id) as copies
FROM sakila.film f
JOIN sakila.inventory i
	ON f.film_id = i.film_id
WHERE f.title = "Hunchback Impossible";

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT
	f.title as film,
    f.length
FROM sakila.film f
WHERE f.length > (SELECT avg(length) FROM sakila.film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT
	f.title,
	a.first_name,
    a.last_name
FROM sakila.film f
JOIN sakila.film_actor fa
	ON f.film_id = fa.film_id
JOIN sakila.actor a
	ON fa.actor_id = a.actor_id
WHERE f.title = 'Alone Trip';

SELECT 
	a.first_name,
    a.last_name
FROM sakila.actor a
WHERE a.actor_id IN (
	SELECT fa.actor_id
    FROM sakila.film_actor fa
    WHERE fa.film_id = (SELECT f.film_id
		FROM sakila.film f
		WHERE title = 'Alone Trip'
    )
);

-- 4. 
SELECT title
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Family';

-- 5. 
SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

-- 6. 
-- actor
SELECT actor_id 
FROM (
  SELECT actor_id, count(film_id) AS films 
  FROM film_actor
  GROUP BY actor_id
  ORDER BY films DESC
  LIMIT 1) AS s;
-- films
SELECT fi.title 
FROM film_actor AS fa 
JOIN film AS fi ON fa.film_id = fi.film_id
WHERE actor_id = (
    SELECT actor_id 
    FROM (
      SELECT actor_id, count(film_id) AS films 
      FROM film_actor
      GROUP BY actor_id
      ORDER BY films DESC
      LIMIT 1) AS s1);

-- 7.
SELECT film.title
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
WHERE payment.customer_id = (
    SELECT customer_id 
    FROM payment 
    GROUP BY customer_id 
    ORDER BY SUM(amount) DESC 
    LIMIT 1
);

-- 8. 
SELECT customer_id, SUM(amount) as total_amount_spent
FROM payment
GROUP BY customer_id
HAVING total_amount_spent > (SELECT AVG(total_amount_spent)
                         FROM (SELECT SUM(amount) as total_amount_spent
                                FROM sakila.payment
                                GROUP BY customer_id) as subquery);