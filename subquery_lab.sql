USE sakila;
##Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(*) 
FROM inventory
WHERE film_id = (SELECT film_id FROM film  WHERE title = 'HUNCHBACK IMPOSSIBLE');

##List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title,length
FROM film
WHERE length>(SELECT AVG(length) FROM film);

##Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT actor_id 
FROM film_actor 
WHERE film_id = ( SELECT film_id FROM film  WHERE title = 'ALONE TRIP');

SELECT first_name last_name
FROM actor
WHERE actor_id IN (SELECT actor_id 
FROM film_actor 
WHERE film_id = ( SELECT film_id FROM film  WHERE title = 'ALONE TRIP'));

## Identify all movies categorized as family

SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_category
    WHERE category_id = (
        SELECT category_id
        FROM category
        WHERE name = 'Family'
    ));
    
##Subquery as well as joins
SELECT 
    customer.first_name,
    customer.last_name,
    customer.email
FROM customer
JOIN address 
    ON customer.address_id = address.address_id
JOIN city 
    ON address.city_id = city.city_id
JOIN country 
    ON city.country_id = country.country_id
WHERE country.country = 'Canada';

SELECT 
    first_name,
    last_name,
    email
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
            WHERE country = 'Canada')));
            
SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1;

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
        LIMIT 1));
        
##Profitable customer
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