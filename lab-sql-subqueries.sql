USE sakila;

/* Exercise 1º */


SELECT
    COUNT(*) AS number_of_copies
FROM inventory
WHERE film_id in (
    SELECT film_id 
    FROM film
    WHERE title = 'Hunchback Impossible'
)
;


/* Exercise 2º */


SELECT AVG(Length)
FROM film;

SELECT title
FROM film
WHERE length > (SELECT AVG(Length)
FROM film);

   
/* Exercise 3º */


SELECT first_name, last_name
FROM actor
WHERE actor_id in (
    SELECT actor_id
    FROM film_actor
    WHERE film_id in (
        SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
    )
);


/* Exercise 4º */


SELECT title
FROM film
WHERE film_id in (
    SELECT film_id
    FROM film_category
    WHERE category_id in (
        SELECT category_id
        FROM category
        WHERE name = 'Family'
    )
);


/* Exercise 5º */


SELECT first_name, last_name, email
FROM customer
JOIN address
    ON customer.address_id = address.address_id
JOIN city
    ON address.city_id = city.city_id
JOIN country
    ON city.country_id = country.country_id
WHERE country.country = 'Canada';


SELECT first_name, last_name, email
FROM customer
WHERE customer.address_id in (
    SELECT address_id
    FROM address
    WHERE address.city_id in (
        SELECT city_id
        FROM city
        WHERE city.country_id in (
            SELECT country_id
            FROM country
            WHERE country = 'Canada' 
        )
    )
);


/* Exercise 6º */


SELECT title
FROM film
WHERE film_id in (
    SELECT film_id
    FROM film_actor
    WHERE actor_id = (
        SELECT actor_id
        FROM film_actor
        GROUP BY actor_id
        ORDER BY COUNT(*) DESC
        LIMIT 1
    )     
);


/* Exercise 7º */


SELECT title
FROM film
WHERE film_id in (
    SELECT film_id 
    FROM inventory
    WHERE inventory_id in (
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


/* Exercise 8º */


SELECT
    customer_id AS client_id,
    SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total_amount_spent)
    FROM (
        SELECT
            customer_id,
            SUM(amount) AS total_amount_spent
        FROM payment
        GROUP BY customer_id
    ) AS totals_by_client
);


