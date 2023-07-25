#Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT Title, total_films
FROM (
	SELECT title as Title, COUNT(inventory.film_id) AS total_films
	FROM sakila.inventory
    INNER JOIN sakila.film ON film.film_id = inventory.film_id
    GROUP BY film.title
) inventory_table
WHERE Title = 'Academy Dinosaur';

#2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title
FROM sakila.film
WHERE film.length >  (
		SELECT AVG(length) FROM sakila.film);

#3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT film.title, full_name
FROM (
	SELECT CONCAT(first_name," ",last_name) AS full_name, film_id
	FROM sakila.film_actor
	INNER JOIN sakila.actor
	ON film_actor.actor_id = actor.actor_id) actor_table
INNER JOIN sakila.film 
ON film.film_id = actor_table.film_id
WHERE title = 'Alone Trip';

#4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films. 

SELECT `name`, title
FROM (
    SELECT film_id, film_category.category_id, `name`
	FROM sakila.film_category
	INNER JOIN sakila.category
	ON category.category_id = film_category.category_id) cat_table
INNER JOIN sakila.film
ON film.film_id = cat_table.film_id
WHERE `name` = 'Family';

#5. Retrieve the name and email of customers from Canada using both subqueries and joins. 
#To use joins, you will need to identify the relevant tables and their primary and foreign keys.

SELECT city_id, country
	FROM sakila.city
	JOIN sakila.country ON country.country_id = city.country_id
	WHERE country = 'Canada';
    
SELECT country, address_id
	FROM (
		SELECT city_id, country
		FROM sakila.city
		JOIN sakila.country ON country.country_id = city.country_id
		WHERE country = 'Canada') cnd_table
		INNER JOIN sakila.address ON address.city_id = cnd_table.city_id;

SELECT CONCAT(first_name, " ", Last_name), email, country
FROM (	
    SELECT country, address_id
	FROM (
		SELECT city_id, country
		FROM sakila.city
		JOIN sakila.country ON country.country_id = city.country_id
		WHERE country = 'Canada') cnd_table
		INNER JOIN sakila.address ON address.city_id = cnd_table.city_id
		) cnd_cust
 LEFT JOIN sakila.customer ON customer.address_id = cnd_cust.address_id;
 
 #6. Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. 
 #First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
 
 
SELECT *
 FROM (
	 SELECT actor_id, COUNT(film_id) AS total_films
	 FROM sakila.film_actor
	 GROUP BY actor_id) film_actor_count
ORDER BY total_films DESC 
LIMIT 1;

SELECT film_actor.actor_id, film_id
	FROM (
			SELECT *
			 FROM (
				 SELECT actor_id, COUNT(film_id) AS total_films
				 FROM sakila.film_actor
				 GROUP BY actor_id) film_actor_count
			ORDER BY total_films DESC 
			LIMIT 1 ) best_actor
	INNER JOIN sakila.film_actor ON film_actor.actor_id = best_actor.actor_id;


SELECT actor_id, title
FROM (
	SELECT film_actor.actor_id, film_id
	FROM (
			SELECT *
			 FROM (
				 SELECT actor_id, COUNT(film_id) AS total_films
				 FROM sakila.film_actor
				 GROUP BY actor_id) film_actor_count
			ORDER BY total_films DESC 
			LIMIT 1 ) best_actor
	INNER JOIN sakila.film_actor ON film_actor.actor_id = best_actor.actor_id
    ) best_actor_films
INNER JOIN sakila.film ON sakila.film.film_id = best_actor_films.film_id;

#7. Find the films rented by the most profitable customer in the Sakila database. 
#You can use the customer and payment tables to find the most profitable customer, i.e., 
# the customer who has made the largest sum of payments.

	SELECT rental.customer_id, inventory_id
	FROM (	
		SELECT customer_id, SUM(amount) AS total_amount
		FROM sakila.payment
		GROUP BY customer_id
		ORDER BY total_amount DESC
		LIMIT 1
		) best_customer
	INNER JOIN sakila.rental ON sakila.rental.customer_id = sakila.best_customer.customer_id;


SELECT customer_id, title
FROM (
	SELECT customer_id, film_id
	FROM (
		SELECT rental.customer_id, inventory_id
			FROM (	
				SELECT customer_id, SUM(amount) AS total_amount
				FROM sakila.payment
				GROUP BY customer_id
				ORDER BY total_amount DESC
				LIMIT 1
				) best_customer
			INNER JOIN sakila.rental ON sakila.rental.customer_id = sakila.best_customer.customer_id
			)best_customer_films
	INNER JOIN sakila.inventory ON inventory.inventory_id = best_customer_films.inventory_id
    ) best_customer_films
    INNER JOIN sakila.film ON film.film_id = best_customer_films.film_id;
    
#8. Retrieve the client_id and the total_amount_spent of those 
#clients who spent more than the average of the total_amount spent by each client. 
#You can use subqueries to accomplish this.

SELECT customer_id, SUM(amount) AS total_amount
	FROM sakila.payment
	GROUP BY customer_id;

SELECT *
FROM (
	SELECT customer_id, SUM(amount) AS total_amount
	FROM sakila.payment
	GROUP BY customer_id
) customer_total
HAVING total_amount > (
						SELECT AVG(total_amount) 
						FROM (
							SELECT customer_id, SUM(amount) AS total_amount
							FROM sakila.payment
							GROUP BY customer_id
							) avg_total
					  );