-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT f.title as 'title', 
		count(i.inventory_id) as 'N_copies'

FROM film f
INNER JOIN inventory i
ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY title; 

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length

FROM film
WHERE length > (SELECT avg(length) from film)
ORDER BY length DESC; 

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip"


SELECT first_name 
FROM actor
WHERE actor_id IN 
		(SELECT fa.actor_id

		FROM film_actor fa
		INNER JOIN film f
		ON fa.film_id = f.film_id
		WHERE f.title = 'Alone Trip'); 
        
        
-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

SELECT f.title

FROM film f
INNER JOIN film_category fc
ON fc.film_id = f.film_id
INNER JOIN category c
ON c.category_id = fc.category_id
WHERE c.name = 'Family'; 

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. 

SELECT first_name, last_name, email

FROM customer 
WHERE address_id IN (SELECT a.address_id
						FROM address a
						INNER JOIN city c
						ON c.city_id = a.city_id
						INNER JOIN country co
						ON co.country_id = c.country_id AND co.country = 'Canada');
                        
-- 6. Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

SELECT  a.first_name, a.last_name, COUNT(fa.film_id) as 'number_films'

FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
GROUP BY a.first_name, a.last_name
ORDER BY number_films DESC
LIMIT 1; 

-- 7. Find the films rented by the most profitable customer in the Sakila database. 

SELECT c.customer_id , c.first_name, SUM(p.amount) as 'total_amount'

FROM customer c

INNER JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name
ORDER BY total_amount DESC
LIMIT 1; 

SELECT f.title

FROM rental r
INNER JOIN inventory i
ON r.inventory_id = i.inventory_id
INNER JOIN film f
ON f.film_id = i.film_id

WHERE r.customer_id = 526; 

-- 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.
SELECT 
    c.customer_id AS ClientID,
    SUM(p.amount) AS TotalAmountSpent
FROM 
    customer c
JOIN 
    payment p ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_id
HAVING 
    SUM(p.amount) > (SELECT AVG(TotalSpent) 
                     FROM (
                         SELECT SUM(p.amount) AS TotalSpent
                         FROM payment p
                         GROUP BY p.customer_id
                     ) AS Subquery);


