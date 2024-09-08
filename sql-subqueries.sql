USE sakila;
-- 1 --
SELECT COUNT(*)
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');
-- 2 --
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);
-- 3 --
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id FROM film_actor
    WHERE film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip')
);
-- Bonus --
-- 4 --
SELECT title
FROM film
WHERE film_id IN (SELECT film_id FROM film_category
    WHERE category_id = (SELECT category_id FROM category WHERE name = 'Family')
);
-- 5 --
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (SELECT address_id FROM address WHERE city_id IN (
        SELECT city_id FROM city
        WHERE country_id = (SELECT country_id FROM country WHERE country = 'Canada')
    )
);
-- 5.2--
SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

-- 6 --
SELECT actor_id, COUNT(film_id) AS film_count
FROM film_actor
GROUP BY actor_id
ORDER BY film_count DESC
LIMIT 1;

-- 6.2--
SELECT title
FROM film
WHERE film_id IN (SELECT film_id FROM film_actor WHERE actor_id = (SELECT actor_id FROM film_actor GROUP BY actor_id
                      ORDER BY COUNT(film_id) DESC
                      LIMIT 1)
);
-- 7 --
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 1;
 -- 7.2 --
 SELECT f.title
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.customer_id = (SELECT customer_id FROM payment GROUP BY customer_id
                       ORDER BY SUM(amount) DESC
                       LIMIT 1);
-- 8 --
SELECT customer_id, SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING total_amount_spent > (SELECT AVG(total_spent) FROM (SELECT SUM(amount) AS total_spent
                                   FROM payment
                                   GROUP BY customer_id) AS customer_totals);








