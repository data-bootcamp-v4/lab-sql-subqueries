-- Write SQL queries to perform the following tasks using the Sakila database:

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
		SELECT sub.title, sub.count
		FROM 
			(SELECT f.title AS title, COUNT(*) AS count
			 FROM sakila.film AS f
			 JOIN sakila.inventory AS i
			 ON f.film_id = i.film_id
			 GROUP BY title
			 HAVING title = 'Hunchback Impossible') 
		AS sub; 
         
-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
		SELECT title, length
		FROM sakila.film
		WHERE length > (SELECT AVG(length) 
						 FROM sakila.film)
		ORDER BY length DESC;
    
-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
		SELECT concat(first_name,' ', last_name) AS 'actor' 
		FROM sakila.actor 
		WHERE actor_id IN 
			(SELECT a.actor_id 
			 FROM sakila.actor AS a
			 JOIN sakila.film_actor AS fa
			 ON a.actor_id = fa.actor_id
			 JOIN sakila.film AS f
			 ON f.film_id = fa.film_id
			 WHERE f.title = 'Alone Trip');
-- Bonus:

-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
		SELECT sub.title AS 'movie_title'
        FROM 
			(SELECT f.title AS 'title'
             FROM sakila.film AS f
             JOIN sakila.film_category AS fc
             ON f.film_id = fc.film_id
             JOIN sakila.category AS c
             ON c.category_id = fc.category_id
             WHERE c.name = 'Family')
		AS sub; 
        
-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant 
--    tables and their primary and foreign keys.
		SELECT concat(first_name, ' ', last_name) AS 'name', email
        FROM sakila.customer
        WHERE customer_id IN
			(SELECT cus.customer_id
			FROM sakila.customer AS cus
			JOIN sakila.address AS a
			ON cus.address_id = a.address_id
			JOIN sakila.city AS c
			ON c.city_id = a.city_id
			JOIN sakila.country AS cty
			ON c.country_id = cty.country_id
			WHERE cty.country = 'Canada');

-- 6. Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted 
--    in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
		SELECT a.actor_id, COUNT(f.film_id)
        FROM sakila.actor AS a
        JOIN sakila.film_actor AS fa
        ON a.actor_id = fa.actor_id
        JOIN sakila.film AS f
        ON f.film_id = fa.film_id
        GROUP BY a.actor_id
        ORDER BY COUNT(f.film_id) DESC
        LIMIT 1;
        
        SELECT title AS movie_name
        FROM sakila.film
        WHERE film_id IN
			(SELECT fa.film_id 
            FROM sakila.film_actor AS fa
            JOIN sakila.actor AS a
            ON fa.actor_id = a.actor_id
            WHERE fa.actor_id = 107);

-- 7. Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most 
--    profitable customer, i.e., the customer who has made the largest sum of payments.
		SELECT c.customer_id AS Customer, SUM(p.payment_id) AS Rent_Payments
        FROM sakila.customer AS c
        JOIN sakila.payment AS p
        ON c.customer_id = p.customer_id
        GROUP BY Customer
        ORDER BY Rent_Payments DESC
        LIMIT 1;
        
        SELECT f.title AS Rented_Movies
        FROM sakila.film AS f
        WHERE film_id IN
			(SELECT i.film_id 
            FROM sakila.inventory AS i
            WHERE i.inventory_id IN
				(SELECT r.inventory_id 
                FROM sakila.rental AS r
                WHERE r.customer_id = 526));
                
-- 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 
--    You can use subqueries to accomplish this.
