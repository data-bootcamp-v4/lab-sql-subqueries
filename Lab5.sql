USE sakila;
--  Number of copies of "Hunchback Impossible" in the inventory
SELECT COUNT(inventory_id) AS number_of_copies
FROM inventory
WHERE film_id = (
    SELECT film_id 
    FROM film 
    WHERE title = 'Hunchback Impossible'
);

-- List all films longer than the average film length

SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length) 
    FROM film
)
ORDER BY length DESC;

--  Display all actors who appear in the film "Alone Trip"

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id 
    FROM film_actor 
    WHERE film_id = (
        SELECT film_id 
        FROM film 
        WHERE title = 'Alone Trip'
    )
);


-- Identify all movies categorized as family films

SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id 
    FROM film_category 
    WHERE category_id = (
        SELECT category_id 
        FROM category 
        WHERE name = 'Family'
    )
);

-- Retrieve name and email of customers from Canada (Using Subqueries)

SELECT first_name, last_name, email
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

--  Films starred by the most prolific actor

SELECT title
FROM film
WHERE film_id IN (
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

-- Films rented by the most profitable customer

SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id 
    FROM inventory 
    WHERE inventory_id IN (
        SELECT inventory_id 
        FROM rental 
        WHERE customer_id = (
            SELECT customer_id 
            FROM payment 
            GROUP BY customer_id 
            ORDER BY SUM(amount) DESC 
            LIMIT 1
        )
    )
);


-- Client ID and amount spent for clients beating the average customer spend

SELECT customer_id, total_spent
FROM (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM payment
    GROUP BY customer_id
) AS client_spend
WHERE total_spent > (
    SELECT AVG(sub_spent) 
    FROM (
        SELECT SUM(amount) AS sub_spent 
        FROM payment 
        GROUP BY customer_id
    ) AS avg_profile
)
ORDER BY total_spent DESC;


