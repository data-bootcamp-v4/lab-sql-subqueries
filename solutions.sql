USE sakila;

SHOW tables;

# 1.
SELECT COUNT(*) AS copies
FROM inventory
WHERE film_id IN (SELECT film_id FROM film WHERE title = 'Hunchback IMpossible');

# 2.
SELECT title, length
FROM film WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC, title;

# 3.
SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (
  SELECT fa.actor_id
  FROM film_actor fa
  WHERE fa.film_id IN (SELECT film_id FROM film WHERE title = 'Alone Trip')
)
ORDER BY a.last_name, a.first_name;

# 4.
SELECT f.film_id, f.title
FROM film f
WHERE f.film_id IN (
	SELECT fc.film_id
    FROM film_category fc
    JOIN category c ON c.category_id = fc.category_id
    WHERE c.name = 'Family'
)
ORDER BY f.title;

# 5.
SELECT cu.first_name, cu.last_name, cu.email
FROM customer cu
JOIN address a ON a.address_id = cu.address_id
JOIN city ci   ON ci.city_id   = a.city_id
JOIN country co ON co.country_id = ci.country_id
WHERE co.country = 'Canada'
ORDER BY cu.last_name, cu.first_name;

# 6.
SELECT f.title
FROM film f
JOIN film_actor fa ON fa.film_id = f.film_id
WHERE fa.actor_id = (
	SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
ORDER BY f.title;

# 7.
SELECT DISTINct f.title
FROM payment p
JOIN rental r ON r.rental_id = p.rental_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
WHERE p.customer_id = (
	SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
)
ORDER BY f.title;

# 8. 
SELECT t.customer_id, t.total_amount
FROM (
	SELECT customer_id, SUM(amount) AS total_amount
    FROM payment
    GROUP BY customer_id
) AS t
WHERE t.total_amount > (
	SELECT AVG(total_amount)
    FROM (
		SELECT customer_id, SUM(amount) AS total_amount
        FROM payment
        GROUP BY customer_id
	) AS per_cust
)
ORDER BY t.total_amount DESC, t.customer_id;