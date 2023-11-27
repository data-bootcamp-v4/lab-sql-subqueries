/* 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system. */
SELECT film_id
FROM sakila.film
WHERE title = "Hunchback Impossible";
SELECT COUNT(*)
FROM sakila.inventory
WHERE film_id = 439;

/* 2. List all films whose length is longer than the average length of all the films in the Sakila database. */
SELECT AVG(length)
FROM sakila.film;
SELECT length, title 
FROM sakila.film
WHERE film.length > 115.2720;

/* 3. Use a subquery to display all actors who appear in the film "Alone Trip". */
SELECT film_id
FROM sakila.film
WHERE title = "Alone Trip";
SELECT actor_id
FROM sakila.film_actor
WHERE film_id = 17;
SELECT actor_id, first_name, last_name
FROM sakila.actor
WHERE actor_id IN (3, 12, 13, 82, 100, 160, 167, 187);

/* 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films. */
SELECT category_id
FROM sakila.category
WHERE name = "Family";
SELECT film_category.film_id, film.title
FROM sakila.film_category
INNER JOIN sakila.film
ON sakila.film_category.film_id = sakila.film.film_id
WHERE category_id = 8;

/* 5. Retrieve the name and email of customers from Canada using both subqueries and joins. 
To use joins, you will need to identify the relevant tables and their primary and foreign keys. */
#Canada = country_id: 20
SELECT city_id
FROM sakila.city
WHERE country_id = 20;

SELECT address_id, city.city_id, country_id
FROM sakila.city
INNER JOIN sakila.address
ON sakila.city.city_id = sakila.address.address_id
WHERE country_id = 20;

SELECT first_name, last_name, email
FROM sakila.customer
WHERE address_id IN (179, 196, 300, 313, 383, 430, 565);

/* 6. Determine which films were starred by the most prolific actor in the Sakila database. 
A prolific actor is defined as the actor who has acted in the most number of films. 
First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in. */
SELECT film_actor.actor_id, film.title
FROM sakila.film_actor
JOIN sakila.film ON film_actor.film_id = film.film_id
WHERE film_actor.actor_id = (
    SELECT actor_id
    FROM (
        SELECT actor_id, COUNT(*) AS film_count
        FROM sakila.film_actor
        GROUP BY actor_id
        ORDER BY film_count DESC
        LIMIT 1
    ) AS most_prolific
);

/* 7. Find the films rented by the most profitable customer in the Sakila database. 
You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments. */
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

/* 8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 
You can use subqueries to accomplish this. */
SELECT customer_id, SUM(amount) AS total_amount_spent
FROM sakila.payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total_amount)
    FROM (
        SELECT SUM(amount) AS total_amount
        FROM sakila.payment
        GROUP BY customer_id
    ) AS clients_spent_more_that_avg
);