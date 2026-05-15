-- LAB SQL SUBQUERIES
USE sakila;

SELECT 
    title,
    rental_rate
FROM film
WHERE rental_rate > (
    SELECT AVG(rental_rate)
    FROM film
);




SELECT 
    customer_id,
    COUNT(rental_id) AS total_rentals
FROM rental
GROUP BY customer_id
HAVING COUNT(rental_id) > (
    SELECT AVG(rental_count)
    FROM (
        SELECT COUNT(rental_id) AS rental_count
        FROM rental
        GROUP BY customer_id
    ) AS sub
);

SELECT 
    f.title,
    COUNT(r.rental_id) AS times_rented
FROM film f
JOIN inventory i 
    ON f.film_id = i.film_id
JOIN rental r 
    ON i.inventory_id = r.inventory_id
GROUP BY f.title
HAVING COUNT(r.rental_id) > (
    SELECT AVG(rental_count)
    FROM (
        SELECT COUNT(*) AS rental_count
        FROM rental r
        JOIN inventory i 
            ON r.inventory_id = i.inventory_id
        GROUP BY i.film_id
    ) AS sub
)
ORDER BY times_rented DESC;



SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p 
    ON c.customer_id = p.customer_id
GROUP BY c.customer_id
HAVING SUM(p.amount) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(amount) AS customer_total
        FROM payment
        GROUP BY customer_id
    ) AS sub
)
ORDER BY total_spent DESC;


