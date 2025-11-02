-- 1
SELECT  f.title, COUNT(i.inventory_id) AS number_of_copie FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.title;
-- 2
SELECT  title, lengt FROM film
WHERE length > (SELECT AVG(length) FROM film )
ORDER BY length DESC;
-- 3
SELECT  a.first_name, a.last_name FROM actor AS a
WHERE a.actor_id IN ( SELECT fa.actor_id FROM film_actor AS 
fa JOIN film AS f ON fa.film_id = f.film_id WHERE f.title = 'Alone Trip')
ORDER BY a.last_name, a.first_name;
-- 4
SELECT f.title AS family_film_title FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
WHERE c.name = 'Family' ORDER BY f.title;
-- 5
SELECT first_name, last_name, email FROM customer
WHERE address_id IN ( SELECT address_id FROM address WHERE city_id IN ( SELECT city_id 
FROM city WHERE country_id = (SELECT country_id  FROM country  WHERE country = 'Canada')));

-- 6
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
FROM actor AS a JOIN film_actor AS fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id ORDER BY film_count DESC
LIMIT 1;

SELECT  f.title
FROM film AS f JOIN film_actor AS fa ON f.film_id = fa.film_id
WHERE fa.actor_id = X ORDER BY f.title;

-- 7 
SELECT  c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM payment AS p JOIN customer AS c ON p.customer_id = c.customer_id
GROUP BY c.customer_id ORDER BY total_spent DESC
LIMIT 1;
SELECT DISTINCT  f.title
FROM rental AS r JOIN inventory AS i ON r.inventory_id = i.inventory_id JOIN film AS f ON i.film_id = f.film_id
WHERE r.customer_id = Y ORDER BY f.title;
-- 8
SELECT  customer_id, SUM(amount) AS total_amount_spent
FROM payment GROUP BY customer_id
HAVING SUM(amount) > (SELECT AVG(total_spent)FROM (SELECT SUM(amount) AS total_spent
FROM payment GROUP BY customer_id) AS subquery)
ORDER BY total_amount_spent DESC;

