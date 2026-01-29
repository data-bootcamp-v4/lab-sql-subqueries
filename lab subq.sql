USE sakila;

-- 1: "Hunchback Impossible"
SELECT 
title,
(SELECT COUNT(film_id) FROM inventory)
FROM film
WHERE title = 'Hunchback Impossible'; 

-- 2: List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT
title,
length
FROM film
WHERE length > (SELECT AVG(length) FROM film);  

-- 3: Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT 
first_name, 
last_name 
FROM actor
WHERE actor_id IN
	(SELECT actor_id
    FROM film_actor
    WHERE film_id =
		(SELECT film_id FROM film WHERE title = 'Alone Trip')
	); 
    
-- 4: Family 
SELECT
title
FROM film
WHERE film_id 
IN (SELECT film_id FROM category WHERE name = 'Family');

-- 5: name and email 
SELECT
c.first_name, 
c.last_name,
c.email,
a.address_id
FROM customer as c
JOIN address as a
ON c.address_id = a.address_id
WHERE city_id IN
(SELECT city_id FROM city WHERE country_id =
(SELECT country_id FROM country WHERE country = 'Canada')); 

-- 6: prolific actor 
SELECT
f.title
FROM film as f 
JOIN film_actor as fa
ON f.film_id = fa.film_id
WHERE fa.actor_id = 
	(SELECT actor_id 
    FROM film_actor 
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1); 

-- 7: profitable customer
SELECT DISTINCT 
f.title
FROM film as f
JOIN inventory as i 
ON f.film_id = i.film_id
JOIN rental as r 
ON i.inventory_id = r.inventory_id
JOIN customer as c 
ON r.customer_id = c.customer_id 
WHERE c.customer_id = 
	(SELECT 
	customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1); 

-- 8:     
SELECT 
customer_id, 
SUM(amount) as total
FROM payment 
GROUP BY customer_id
HAVING SUM(amount) > 
	(SELECT 
    AVG(total_cliente)
    FROM 
		(SELECT 
        SUM(amount) as total_cliente
        FROM payment
        GROUP BY customer_id) as final); 
        






