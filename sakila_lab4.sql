USE sakila;

SELECT COUNT(inventory.inventory_id) AS number_of_copies
FROM film
JOIN inventory ON film.film_id = inventory.film_id
WHERE film.title = 'Hunchback Impossible';

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

SELECT actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
WHERE film_actor.film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip');

SELECT film.title
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Family';

SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
    SELECT address.address_id 
    FROM address
    JOIN city ON address.city_id = city.city_id
    JOIN country ON city.country_id = country.country_id
    WHERE country.country = 'Canada'
);

SELECT customer.first_name, customer.last_name, customer.email
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE country.country = 'Canada';


SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(film_actor.film_id) AS film_count
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name
ORDER BY film_count DESC
LIMIT 1;

SELECT film.title
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
WHERE film_actor.actor_id = (
    SELECT actor.actor_id
    FROM actor
    JOIN film_actor ON actor.actor_id = film_actor.actor_id
    GROUP BY actor.actor_id
    ORDER BY COUNT(film_actor.film_id) DESC
    LIMIT 1
);

SELECT customer.customer_id, SUM(payment.amount) AS total_payment
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY total_payment DESC
LIMIT 1;

SELECT film.title
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE rental.customer_id = (
    SELECT customer.customer_id
    FROM customer
    JOIN payment ON customer.customer_id = payment.customer_id
    GROUP BY customer.customer_id
    ORDER BY SUM(payment.amount) DESC
    LIMIT 1
);

SELECT customer.customer_id, SUM(payment.amount) AS total_amount_spent
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
HAVING total_amount_spent > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(payment.amount) AS total_spent
        FROM payment
        GROUP BY payment.customer_id
    ) AS customer_totals
);



