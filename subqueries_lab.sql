USE sakila;

#1
SELECT 
    f.title,
    COUNT(i.inventory_id) AS number_of_copies
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.title;

#2
SELECT 
    title,
    length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC;

#3
SELECT 
    first_name,
    last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id 
    FROM film_actor
    WHERE film_id = (
        SELECT film_id 
        FROM film
        WHERE title = 'Alone Trip'));

#4
SELECT 
    f.title,
    c.name AS category
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family';

#5 JOINS
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    c.email
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'Canada';

# SUBQUERIES
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
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

#6
SELECT 
    actor_id,
    CONCAT(first_name, ' ', last_name) AS actor_name,
    COUNT(film_id) AS number_of_films
FROM film_actor
JOIN actor USING (actor_id)
GROUP BY actor_id, first_name, last_name
ORDER BY number_of_films DESC
LIMIT 1;

SELECT 
    f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(film_id) DESC
    LIMIT 1
);


#7
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 1;

SELECT 
    f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id
WHERE c.first_name = 'Karl' AND c.last_name = 'Seal';

#8
SELECT 
    customer_id,
    SUM(amount) AS total_amount_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > (SELECT AVG(total_spent)
    FROM (
        SELECT SUM(amount) AS total_spent
        FROM payment
        GROUP BY customer_id) AS customer_totals)
ORDER BY total_amount_spent DESC;