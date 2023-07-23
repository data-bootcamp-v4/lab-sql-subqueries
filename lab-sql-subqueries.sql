/*1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.*/
SELECT film.title AS Film_title, COUNT(inventory.inventory_id) AS Number_copies
FROM sakila.film
JOIN sakila.inventory ON film.film_id = inventory.film_id
WHERE film.title = 'Hunchback Impossible'
GROUP BY inventory.film_id;

/*2. List all films whose length is longer than the average length of all the films in the Sakila database.*/
SELECT film.title AS Film_title, film.length
FROM sakila.film
WHERE film.length > (
	SELECT AVG(length)
    FROM sakila.film);

/*3. Use a subquery to display all actors who appear in the film "Alone Trip".*/
SELECT actor.actor_id,  CONCAT(actor.first_name, " ", actor.last_name) AS Actors_Name
FROM sakila.actor
WHERE actor.actor_id IN (
    SELECT film_actor.actor_id
    FROM sakila.film
    JOIN sakila.film_actor ON film.film_id = film_actor.film_id
    WHERE film.title = 'Alone Trip'
);
/*4. Identify all movies categorized as family films. */
SELECT film_id, title
FROM sakila.film
WHERE film_id IN (
    SELECT film_id
    FROM sakila.film_category
    WHERE category_id IN (
        SELECT category_id
        FROM sakila.category
        WHERE name = 'Family')
);
/*5. Retrieve the name and email of customers from Canada using both subqueries and joins. */
SELECT
    customer.customer_id,
    CONCAT(customer.first_name, " ", customer.last_name) AS Customer_Name,
    customer.email
FROM sakila.customer
INNER JOIN
    (SELECT address_id
        FROM sakila.address
        WHERE city_id IN (
            SELECT city_id
            FROM sakila.city
            WHERE country_id IN (
                SELECT country_id
                FROM sakila.country
                WHERE country = 'Canada'
            )
        )
    ) AS canadian_addresses ON customer.address_id = canadian_addresses.address_id;

/*6. Determine which films were starred by the most prolific actor in the Sakila database.*/
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
    ) AS Most_prolific
);

/*7. Find the films rented by the most profitable customer in the Sakila database. 
You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.*/
SELECT 
    film.film_id,
    film.title AS film_title,
    customer.customer_id,
    CONCAT(customer.first_name, ' ', customer.last_name) AS customer_name,
    total_payments
FROM 
    sakila.film
INNER JOIN 
    sakila.inventory ON film.film_id = inventory.film_id
INNER JOIN 
    sakila.rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN 
    sakila.customer ON rental.customer_id = customer.customer_id
INNER JOIN 
    (
        SELECT 
            customer_id,
            SUM(amount) AS total_payments
        FROM 
            sakila.payment
        GROUP BY 
            customer_id
        ORDER BY 
            total_payments DESC
        LIMIT 1
    ) AS most_profitable_customer ON customer.customer_id = most_profitable_customer.customer_id;

/*8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 
You can use subqueries to accomplish this.*/
SELECT customer_id AS client_id, total_amount_spent
FROM 
    (SELECT customer_id, SUM(amount) AS total_amount_spent
        FROM sakila.payment
        GROUP BY customer_id) AS customer_spending
WHERE total_amount_spent > 
	(SELECT AVG(total_amount_spent) 
        FROM 
            (SELECT 
                    customer_id,
                    SUM(amount) AS total_amount_spent
                FROM sakila.payment
                GROUP BY customer_id) AS avg_spending
    );
