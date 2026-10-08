# 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(*)
FROM inventory
WHERE film_id IN (
   SELECT film_id
FROM film
WHERE title = 'Hunchback Impossible'
);


# 2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title,  length
FROM film
WHERE length > (
	SELECT AVG(length)
	FROM film
);


# 3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id IN (
        SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
    )
);

# BONUS 
# 4. Identify all movies categorized as family films
SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_category
    WHERE category_id IN (
        SELECT category_id
        FROM category
        WHERE name = 'Family'
    )
);

# 5 Retrieve the name and email of customers from Canada using both subqueries and joins.

SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
    SELECT address_id
    FROM address
    WHERE city_id IN (
        SELECT city_id
        FROM city
        WHERE country_id IN (
            SELECT country_id
            FROM country
            WHERE country = 'Canada'
        )
    )
);

SELECT c.first_name, c.last_name, c.email
FROM customer AS c
JOIN address AS a 
  ON c.address_id = a.address_id
JOIN city AS ci 
  ON a.city_id = ci.city_id
JOIN country AS co 
  ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

# 6 Determine which films were starred by the most prolific actor in the Sakila database.

# Outer query: Find the movie titles
SELECT title
FROM film
WHERE film_id IN (
    # Middle query: Find the film IDs linked to that actor
    SELECT film_id
    FROM film_actor
    WHERE actor_id = (
        SELECT actor_id
        FROM film_actor
        GROUP BY actor_id
        ORDER BY COUNT(film_id) DESC
        LIMIT 1
    )
);

# 7 Find the films rented by the most profitable customer in the Sakila database.
SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM inventory
    WHERE inventory_id IN (
        SELECT inventory_id
        FROM rental
        WHERE customer_id = (
            -- The inner-most query finds the most profitable customer
            SELECT customer_id
            FROM payment
            GROUP BY customer_id
            ORDER BY SUM(amount) DESC
            LIMIT 1
        )
    )
);

# 8 Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 
SELECT customer_id, total_spent
FROM (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM payment
    GROUP BY customer_id
) AS customer_totals
WHERE total_spent > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(amount) AS total_spent
        FROM payment
        GROUP BY customer_id
    ) AS avg_calc
);