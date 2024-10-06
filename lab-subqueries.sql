USE sakila;

SELECT COUNT(*), f.film_id, f.title
FROM inventory AS i 
JOIN film as f ON i.film_id = f.film_id
GROUP BY i.film_id
HAVING title = 'Hunchback Impossible';


SELECT COUNT(*) AS inventory_count, f.film_id, f.title
FROM inventory AS i
JOIN film AS f ON i.film_id = f.film_id
WHERE f.film_id = (
				   SELECT f2.film_id
                   FROM film AS f2
                   WHERE f2.title = 'Hunchback Impossible'
)
GROUP BY f.film_id;

SELECT title, length FROM film
WHERE length > (SELECT AVG(length) FROM film);


SELECT CONCAT(a.first_name, ' ', a.last_name) AS actor_name
FROM actor AS a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor AS fa
    JOIN film AS f ON fa.film_id = f.film_id
    WHERE f.title = 'Alone Trip'
);

SELECT * FROM film_category;

SELECT * FROM category;

SELECT COUNT(*), category_id
FROM film_category
GROUP BY category_id;

SELECT title AS family_films
FROM film AS f
WHERE f.film_id IN (
	SELECT fc.film_id
    FROM film_category AS fc
    JOIN category AS c on fc.category_id = c.category_id
    WHERE c.name = 'Family'
);

SELECT CONCAT(cm.first_name,' ',cm.last_name), cm.email
FROM customer AS cm
WHERE cm.address_id IN (
	SELECT a.address_id
    FROM address AS a
	JOIN city AS ct ON a.city_id = ct.city_id
	JOIN country AS cn ON ct.country_id = cn.country_id
    WHERE cn.country = 'Canada'
);

SELECT f.title 
FROM film as f
JOIN film_actor AS fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
	SELECT actor_id
	FROM film_actor
	GROUP BY actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
	);

SELECT f.title
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN customer AS c ON r.customer_id = c.customer_id
WHERE c.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
);

SELECT customer_id, total_spent
FROM (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM payment
    GROUP BY customer_id
) AS customer_totals
WHERE total_spent > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(amount) AS total_spent
        FROM payment
        GROUP BY customer_id
    ) AS avg_totals
);

