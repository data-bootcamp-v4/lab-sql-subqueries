/* 1 */
SELECT COUNT(*) AS num_copies
FROM inventory inv
JOIN film fil ON inv.film_id = fil.film_id
WHERE fil.title = 'Hunchback Impossible';
/* 2 */
SELECT film_id, title, length
FROM film
WHERE length > (
    SELECT AVG(length) 
    FROM film);
/* 3 */
SELECT actor.actor_id, actor.first_name, actor.last_name
FROM actor
WHERE actor.actor_id IN (
    SELECT film_actor.actor_id
    FROM film
    JOIN film_actor ON film.film_id = film_actor.film_id
    WHERE film.title = 'Alone Trip');
/* 4 */
SELECT film.film_id, film.title, category.name AS category
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Family';
/* 5 */
SELECT customer.first_name, customer.last_name, customer.email
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE country.country = 'Canada';
/* 6 */
SELECT film.film_id, film.title
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
WHERE film_actor.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1);
    SELECT film.film_id, film.title
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
WHERE film_actor.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1);
    SELECT actor_id, COUNT(*) AS film_count
FROM film_actor
GROUP BY actor_id
ORDER BY film_count DESC
LIMIT 1;
/* 7 */
SELECT film.film_id, film.title
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.customer_id = (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1);
/* 8 */
SELECT customer_id, total_amount_spent
FROM (
    SELECT customer_id, SUM(amount) AS total_amount_spent
    FROM payment
    GROUP BY customer_id
) AS customer_totals
WHERE total_amount_spent > (
    SELECT AVG(total_amount_spent) AS average_amount_spent
    FROM (
        SELECT customer_id, SUM(amount) AS total_amount_spent
        FROM payment
        GROUP BY customer_id
    ) AS customer_totals_avg);