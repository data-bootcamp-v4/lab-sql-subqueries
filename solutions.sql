-- 1. Number of copies of the film Hunchback Impossible that exist in the inventory system --
SELECT f.title AS 'Title', f.film_id AS 'Film ID', COUNT(i.inventory_id) AS 'Number of Copies'
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
WHERE f.film_id = 439;


-- 2. List of films whose length is longer than average length all all movies ---
SELECT * 
FROM film AS f
WHERE f.length > (
	SELECT AVG(length)
	FROM film
	);

--- 3. Display all actors who appear in the film Alone Trip ---
SELECT *
FROM film AS f
JOIN film_actor AS fa ON fa.film_id = fa.film_id
JOIN actor AS a ON fa.actor_id = a.actor_id
WHERE f.title = 'ALONE TRIP';

--- Below is a subquery ---

SELECT *
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (
        SELECT film_id
        FROM film
        WHERE title = 'ALONE TRIP'
    )
);

--- 4. Movies categorized as family films --- 
SELECT *
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
WHERE c.name = 'Family'; 

--- 5. Name and email of customers from Canada ---

SELECT *
FROM customer as c
JOIN address AS a ON c.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS coun ON ci.country_id = coun.country_id
WHERE coun.country = 'Canada'


-- as subquery -- 

SELECT *
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

--- 6. Which films were starred by the most prolific actor ---- 
SELECT f.title 
FROM film AS f
JOIN film_actor AS fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
	SELECT actor_id
	FROM film_actor
	GROUP BY actor_id
	ORDER BY COUNT(*) DESC
	LIMIT 1
);

--- 7. Films rented by most profitable customer ---
SELECT f.title AS 'Movie Titles'
FROM film AS f 
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN payment AS p ON r.rental_id = p.rental_id
WHERE p.customer_id = (
	SELECT customer_id
	FROM payment 
	GROUP BY customer_id
	ORDER BY COUNT(amount) DESC
	LIMIT 1
);

--- 8. Retreive client_id and total_amount_spent of those clients who spent more than average of the total amount ---
SELECT c.customer_id AS 'Customer ID', SUM(p.amount) AS 'Total amount spent'
FROM customer AS c
JOIN payment AS p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
HAVING SUM(amount) > (
	SELECT AVG(amount)
	FROM payment
);



	
	
	
	
	
	
	