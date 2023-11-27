/* Write SQL queries to perform the following tasks using the Sakila database:*/
USE sakila;

/* 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.*/

SELECT title, COUNT(*)
FROM sakila.inventory
INNER JOIN (
	SELECT film_id, title
	FROM sakila.film
	WHERE sakila.film.title = "Hunchback Impossible") AS find_mov
ON sakila.inventory.film_id = find_mov.film_id;

/* 2. List all films whose length is longer than the average length of all the films in the Sakila database.*/

SELECT *
FROM sakila.film
WHERE film.length >= (SELECT AVG(length) FROM sakila.film);


/* 3. Use a subquery to display all actors who appear in the film "Alone Trip".*/

SELECT title, CONCAT(first_name, " ", last_name) AS actor_name
FROM sakila.actor
INNER JOIN
	(SELECT actor_id, title
	FROM sakila.film_actor
	INNER JOIN
		(SELECT *
		FROM sakila.film
		WHERE title = "Alone Trip") the_film
	ON sakila.film_actor.film_id = the_film.film_id) the_actors
ON sakila.actor.actor_id = the_actors.actor_id;

/* 4. Sales have been lagging among young families, and you want to target family movies for a promotion. 
Identify all movies categorized as family films.*/

SELECT *
FROM sakila.film
INNER JOIN
	(SELECT film_id
	FROM sakila.film_category
	INNER JOIN
		(SELECT *
		FROM sakila.category
		WHERE category.name = "Family") the_categ
	ON sakila.film_category.category_id = the_categ.category_id) the_films
ON sakila.film.film_id = the_films.film_id;

/* 5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will 
need to identify the relevant tables and their primary and foreign keys.*/

SELECT CONCAT(first_name, " ", last_name) AS full_name, email, country
            FROM sakila.customer
            INNER JOIN
                 (SELECT country, address_id
                 FROM sakila.address
                 INNER JOIN
                    (SELECT country, city_id	
					FROM sakila.city
                    INNER JOIN
                        (SELECT *
                        FROM sakila.country
                        WHERE country LIKE "%canada%") the_country
					ON sakila.city.country_id = the_country.country_id) the_city
				ON sakila.address.city_id = the_city.city_id) the_address
			ON sakila.customer.address_id = the_address.address_id;
            
            
/* 6. Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is 
defined as the actor who has acted in the most number of films. First, you will need to find the most prolific 
actor and then use that actor_id to find the different films that he or she starred in.*/

#prolific actor
SELECT actor_id, COUNT(film_id) AS movies
FROM sakila.film_actor
GROUP BY sakila.film_actor.actor_id
ORDER BY movies DESC
LIMIT 1;

#PROLIFIC ACTOR NAME
SELECT sakila.actor.actor_id, CONCAT(first_name, " ", last_name) AS full_name, movies
FROM sakila.actor
INNER JOIN(
		SELECT actor_id, COUNT(film_id) AS movies
		FROM sakila.film_actor
		GROUP BY sakila.film_actor.actor_id
		ORDER BY movies DESC
		LIMIT 1) AS the_actor
ON sakila.actor.actor_id = the_actor.actor_id;


#MOVIES OF PROLIFIC ACTOR
SELECT the_movies.actor_id, sakila.film_actor.film_id, the_movies.full_name
FROM sakila.film_actor
JOIN (SELECT sakila.actor.actor_id, CONCAT(first_name, " ", last_name) AS full_name, movies
FROM sakila.actor
INNER JOIN(
		SELECT actor_id, COUNT(film_id) AS movies
		FROM sakila.film_actor
		GROUP BY sakila.film_actor.actor_id
		ORDER BY movies DESC
		LIMIT 1) AS the_actor
		ON sakila.actor.actor_id = the_actor.actor_id) the_movies
ON sakila.film_actor.actor_id = the_movies.actor_id;


#MOVIES NAME OF PROLIFIC ACTOR

SELECT film.film_id, film.title, movies_name.actor_id, movies_name.full_name
FROM sakila.film
INNER JOIN (SELECT the_movies.actor_id, sakila.film_actor.film_id, the_movies.full_name
			FROM sakila.film_actor
			JOIN (SELECT sakila.actor.actor_id, CONCAT(first_name, " ", last_name) AS full_name, movies
			FROM sakila.actor
			INNER JOIN(
					SELECT actor_id, COUNT(film_id) AS movies
					FROM sakila.film_actor
					GROUP BY sakila.film_actor.actor_id
					ORDER BY movies DESC
					LIMIT 1) AS the_actor
					ON sakila.actor.actor_id = the_actor.actor_id) the_movies
			ON sakila.film_actor.actor_id = the_movies.actor_id) AS movies_name
ON sakila.film.film_id = movies_name.film_id;



/* 7. Find the films rented by the most profitable customer in the Sakila database. You can use the customer and 
payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.*/

SELECT customer_id, total, title
FROM sakila.film
INNER JOIN    
    (SELECT customer_id, total, sakila.inventory.inventory_id, film_id
    FROM sakila.inventory
	INNER JOIN
        (SELECT inventory_id, rental.customer_id, total
		FROM sakila.rental
		INNER JOIN 
			(SELECT customer_id, SUM(amount) as total
			FROM sakila.payment
			GROUP BY customer_id
			ORDER BY total DESC
			LIMIT 1) AS total
		ON rental.customer_id = total.customer_id) the_films
	ON sakila.inventory.inventory_id = the_films.inventory_id) the_title
ON sakila.film.film_id = the_title.film_id;


/* 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the 
total_amount spent by each client. You can use subqueries to accomplish this.*/

#AVERAGE
SELECT AVG(amount) FROM sakila.payment;

#CLIENTS > AVERAGE
SELECT customer_id, amount
FROM sakila.payment
HAVING sakila.payment.amount > (SELECT AVG(amount) FROM sakila.payment);


#CLIENTS SUM > AVERAGE 
SELECT customer_id, SUM(amount)
FROM (
	SELECT customer_id, amount
	FROM sakila.payment
	HAVING sakila.payment.amount > (SELECT AVG(amount) FROM sakila.payment)) AS cli_avg
GROUP BY customer_id;

