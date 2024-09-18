USE sakila;

-- Number of copies

SELECT COUNT(*) AS num_copies
FROM film
JOIN inventory ON film.film_id = inventory.film_id
WHERE film.title = 'Hunchback Impossible';

-- List of all films length longer than average

SELECT film.title, film.length
FROM film
WHERE film.length > (SELECT AVG(length) FROM film);

-- Subquery actors "Alone Trrip"

SELECT actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
WHERE film_actor.film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip');

-- Bonus 4

SELECT film.title
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Family';

-- Bonus 5

SELECT customer.first_name, customer.last_name, customer.email
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE country.country = 'Canada';

-- Bonus 6

SELECT film.title
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
WHERE film_actor.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- Bonus 7

SELECT film.title
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
WHERE payment.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
);

-- Bonus 8

SELECT customer.customer_id, SUM(payment.amount) AS total_amount_spent
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
HAVING SUM(payment.amount) > (SELECT AVG(total_amount) FROM (SELECT customer_id, SUM(amount) AS total_amount FROM payment GROUP BY customer_id) AS avg_amounts);
