USE sakila;

SELECT COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
);

SELECT title, LENGTH
FROM film
WHERE LENGTH > (
    SELECT AVG(LENGTH)
    FROM film
);

SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN(
    SELECT fa.actor_id
    FROM film_actor fa
    WHERE fa.film_id = (
        SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
    )
);

--Bonus--

SELECT f.film_id, f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family'


SELECT first_name, last_name
FROM customer
WHERE address_id IN (
    SELECT address_id
    FROM address
    WHERE city_id IN (
        SELECT city_id
        FROM city
        WHERE country_id = (
            SELECT country_id
            FROM country
            WHERE country = 'Canada'
        )
    )
);


SELECT cu.first_name, cu.last_name, cu.email
FROM customer cu
JOIN address ad ON cu.address_id = ad.address_id
JOIN city ci ON ad.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada'

 --most Prolific actor_id--

SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1

--Lst of films by this actor--

SELECT f.film_id, f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
  SELECT actor_id
  FROM film_actor
  GROUP BY actor_id
  ORDER BY COUNT(film_id) DESC
  LIMIT 1
);

--Most profitable customer--

SELECT customer_id
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 1;

--Films rented by this customer--

SELECT DISTINCT f.film_id, f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
);

--customer who spend more than average--

SELECT customer_id, total_amount
FROM (
  SELECT customer_id, SUM(amount) AS total_amount
  FROM payment
  GROUP BY customer_id
) AS totals
WHERE total_amount > (
  SELECT AVG(total_client_amount)
  FROM (
    SELECT SUM(amount) AS total_client_amount
    FROM payment
    GROUP BY customer_id
  ) AS avg_table
);
