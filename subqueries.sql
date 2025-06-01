SELECT *
FROM film;

SELECT *
FROM inventory;

SELECT f.title, COUNT(i.inventory_id) AS number_of_copies
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.title;

SELECT title, length
FROM film
WHERE 
    length > (SELECT AVG(length)
	FROM film)
ORDER BY length DESC;

SELECT *
FROM film;

SELECT *
FROM actor;

SELECT a.first_name, a.last_name
FROM actor a
WHERE 
    a.actor_id IN (
        SELECT fa.actor_id
        FROM film f
        JOIN film_actor fa 
        ON f.film_id = fa.film_id
        WHERE f.title = 'Alone Trip'
    );

SELECT *
FROM film;

SELECT *
FROM category;

SELECT *
FROM film_category;

SELECT f.title
FROM film f
JOIN film_category fc 
ON f.film_id = fc.film_id
JOIN category c 
ON fc.category_id = c.category_id
WHERE c.name = 'Family'
ORDER BY f.title;

SELECT *
FROM customer;

SELECT *
FROM address;

SELECT *
FROM city;

SELECT *
FROM country;

SELECT first_name, last_name, email
FROM customer
WHERE 
    address_id IN (
        SELECT address_id
        FROM address
        WHERE city_id 
			IN (
				SELECT city_id
                FROM city
                WHERE country_id = (
                        SELECT country_id
                        FROM country
                        WHERE country = 'Canada'
                    )
            )
    )
ORDER BY 
    last_name, first_name;
    

SELECT *
FROM actor;

SELECT *
FROM film;

SELECT f.title
FROM film f
JOIN film_actor fa 
ON f.film_id = fa.film_id
WHERE fa.actor_id = (
        SELECT fa2.actor_id
        FROM film_actor fa2
        GROUP BY fa2.actor_id
        ORDER BY COUNT(fa2.film_id) DESC
        LIMIT 1
    )
ORDER BY f.title;


SELECT *
FROM rental;

SELECT *
FROM inventory;

SELECT *
FROM film;

SELECT f.title
FROM rental r
JOIN inventory i 
ON r.inventory_id = i.inventory_id
JOIN film f 
ON i.film_id = f.film_id
WHERE r.customer_id = (
        SELECT 
            p.customer_id
        FROM 
            payment p
        GROUP BY 
            p.customer_id
        ORDER BY 
            SUM(p.amount) DESC
        LIMIT 1
    )
ORDER BY 
    f.title;

SELECT*
FROM payment;


SELECT customer_id, total_amount_spent
FROM ( SELECT customer_id, SUM(amount) AS total_amount_spent
    FROM payment
    GROUP BY customer_id) AS customer_totals
WHERE total_amount_spent > (
        SELECT AVG(total_spent)
        FROM (SELECT SUM(amount) AS total_spent
            FROM payment
            GROUP BY customer_id) AS totals
    )
ORDER BY total_amount_spent DESC;

