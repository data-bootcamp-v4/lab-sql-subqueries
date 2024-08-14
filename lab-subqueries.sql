# 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system
#with joins:
SELECT
	f.title AS 'movie',
    COUNT(i.film_id) AS 'copies_in_inventory'
FROM
	film as f
JOIN
	inventory as i ON f.film_id = i.film_id
WHERE
	f.title = 'Hunchback Impossible';
    
#with subquery:
SELECT
	COUNT(film_id) AS 'copies_in_inventory'
FROM
	inventory
WHERE 
	film_id = (
		SELECT 
			film_id 
		FROM 
			film 
		WHERE 
			title = 'Hunchback Impossible'
            );
    
#2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT
	title AS 'movie',
    length
FROM
	film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY
	length DESC;
    
# 3. Use a subquery to display all actors who appear in the film "Alone Trip"
SELECT
	CONCAT(first_name, ' ', last_name) AS 'actor_alone_trip'
FROM
	actor
WHERE actor_id IN (
	SELECT actor_id 
    FROM film_actor 
    WHERE film_id IN (
		SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
        )
	);
    
# Bonus 4. Sales have been lagging among young families, and you want to target family movies for a promotion.
# Identify all movies categorized as family films.
SELECT
	title AS 'family_movies'
FROM
	film
WHERE
	film_id IN (
		SELECT
			film_id
		FROM
			film_category
		WHERE 
			category_id IN (
        SELECT
			category_id
        FROM
			category
        WHERE
			name = 'Family'
            )
		);
        
# Bonus 5. Retrieve the name and email of customers from Canada using both subqueries and joins.
# To use joins, you will need to identify the relevant tables and their primary and foreign keys.

#using queries
SELECT
	CONCAT(first_name,' ',last_name) AS 'name',
    email
FROM
	customer
WHERE address_id IN (
	SELECT
		address_id
    FROM
		address
    WHERE city_id IN (
		SELECT
			city_id
        FROM
			city
        WHERE country_id IN (
			SELECT
				country_id
            FROM
				country
            WHERE
				country = 'Canada'
                )
			)
		);
        
#using joins
SELECT
	CONCAT(c.first_name,' ',c.last_name) AS 'name',
    c.email
FROM
	customer AS c
JOIN
	address AS a ON c.address_id = a.address_id
JOIN
	city AS ci ON a.city_id = ci.city_id
JOIN
	country AS co ON ci.country_id = co.country_id
WHERE
	co.country = 'Canada'
    ;

# Bonus 6. Determine which films were starred by the most prolific actor. A prolific actor the actor who has acted in the most number of films.
#First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
SELECT
	title as 'movie'
FROM
	film
WHERE
	film_id IN (
		SELECT
			film_id
		FROM
			film_actor
		WHERE
			actor_id IN (
				SELECT
					actor_id
				FROM (
					SELECT
						actor_id,
						COUNT(actor_id) as 'n_films'
					FROM
						film_actor
					GROUP BY
						actor_id
					ORDER BY
						n_films DESC
					LIMIT
						1
						) as temp_table
					)
				);
                
# Bonus 7. Find the films rented by the most profitable customer.
#You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
SELECT
	f.title AS 'movies'
FROM
	film AS f
JOIN
	inventory AS i ON f.film_id = i.film_id
JOIN
	rental AS r ON i.inventory_id = r.inventory_id
JOIN
	payment as p ON r.rental_id = p.rental_id
WHERE 
	p.customer_id = (
		SELECT
			customer_id
		FROM
			payment
		WHERE 
			customer_id IN (
				SELECT
					customer_id,
                    SUM(amount) AS 'profit'
				FROM
					payment
				GROUP BY
					customer_id
				LIMIT 1
                )
			);
            
# Bonus 8. Find the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
#You can use subqueries to accomplish this.
SELECT
	customer_id,
    SUM(amount) AS total_amount_spent
FROM 
	payment 

GROUP BY
	customer_id
HAVING
	total_amount_spent > (
		SELECT 
			(AVG(total_amount_spent))
		FROM (
			SELECT
				SUM(amount) AS total_amount_spent
            FROM
				payment
            GROUP BY
				customer_id
                ) AS temp_table
			);