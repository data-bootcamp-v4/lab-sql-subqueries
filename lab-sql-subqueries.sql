## Write SQL queries to perform the following tasks using the Sakila database:

USE sakila;

## 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT f.title,
	   COUNT(*) AS 'No. of copies'
FROM film AS f
INNER JOIN inventory AS i
	ON f.film_id = i.film_id
WHERE f.title LIKE 'Hunchback Impossible'
GROUP BY f.title;

## 2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT f.title,
	   f.length,
       (SELECT AVG(f1.length) from film AS f1) AS 'Average length'
FROM film AS f
WHERE f.length > (SELECT AVG(f2.length) from film AS f2);

## 3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT CONCAT(first_name, ' ', last_name) AS Actor_name
FROM actor
WHERE actor_id IN (SELECT actor_id 
				  FROM film_actor
                  WHERE film_id = (SELECT film_id
								   FROM film
                                   WHERE title LIKE 'Alone Trip')
);

## Bonus:
## 
## 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

SELECT title
FROM film
WHERE film_id IN (SELECT film_id 
				  FROM film_category
                  WHERE category_id = (SELECT category_id
								   FROM category
                                   WHERE name LIKE 'Family')
);

## 5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.

SELECT CONCAT(first_name, ' ', last_name) AS Customer_name,
	   email
FROM customer
WHERE address_id IN (SELECT address_id
					 FROM address a
                     JOIN city c
						ON a.city_id = c.city_id
					 JOIN country co
						ON c.country_id = co.country_id
					 WHERE co.country LIKE 'Canada');

## 6. Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific 
## actor and then use that actor_id to find the different films that he or she starred in.

SELECT title
FROM film f
JOIN film_actor fa
	ON f.film_id = fa.film_id
WHERE actor_id = (SELECT actor_id
					FROM(SELECT a.actor_id,
						   COUNT(a.actor_id) AS Number_films
						 FROM actor a
						 JOIN film_actor fa
							ON a.actor_id = fa.actor_id
						 GROUP BY a.actor_id
                         ) AS actor_counts
						 WHERE number_films = (SELECT MAX(Number_films)
												  FROM(SELECT a.actor_id,
															  COUNT(a.actor_id) AS Number_films
													   FROM actor a
													   JOIN film_actor fa
															ON a.actor_id = fa.actor_id
													   GROUP BY a.actor_id
                                                       ) AS actor_counts
											 )
				);
                    
## 7. Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
                 
SELECT f.title
FROM rental r
JOIN inventory i
	ON r.inventory_id = i.inventory_id
JOIN film f
	ON i.film_id = f.film_id
WHERE r.customer_id = (SELECT customer_id
						FROM (SELECT customer_id,
									 SUM(amount) AS total_amount
							  FROM payment
							  GROUP BY customer_id
						) AS customer_revenue
						WHERE total_amount = (SELECT MAX(total_amount)
											  FROM (SELECT SUM(amount) AS total_amount
													FROM payment
													GROUP BY customer_id
													) AS customer_revenue
											)
						);
## 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.

SELECT customer_id, SUM(amount) AS total_amount
FROM payment
GROUP BY customer_id
HAVING total_amount > (SELECT AVG(total_amount)
					  FROM (SELECT SUM(amount) AS total_amount
							FROM payment
							GROUP BY customer_id
							) AS customer_revenue
					  );