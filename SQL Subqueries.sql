-- 1
select count(*)
from film a
join inventory b
on b.film_id = a.film_id
where title like 'Hunchback Impossible';
--  2
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);
-- 3 
SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (
        SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'));
-- 4
select title, rating
from film
where rating = 'G';
-- 5 
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
            WHERE country = 'Canada')));

-- 6
        SELECT count(*), actor_id
        FROM film_actor
        group by actor_id
        order by count(*) desc;
select title
from film a
join film_actor b
on b.film_id = a.film_id
where b.actor_id = '107';
-- 7
select customer_id, sum(amount) as amount_spent
from payment
group by customer_id
order by amount_spent DESC;

SELECT f.title, p.customer_id, SUM(p.amount) AS amount_spent
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
WHERE p.customer_id = '526'
GROUP BY p.customer_id, f.title
ORDER BY amount_spent DESC;
-- 8 
SELECT customer_id, total_amount_spent
FROM (SELECT customer_id, SUM(amount) AS total_amount_spent
    FROM payment
    GROUP BY customer_id) customer_totals
WHERE total_amount_spent > (
    SELECT AVG(total_amount)
    FROM (       SELECT SUM(amount) AS total_amount
        FROM payment
        GROUP BY customer_id) client_totals);






