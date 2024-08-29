USE sakila;
-- number 1
SELECT COUNT(*) AS NumberOfCopies FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');
-- number 2
SELECT title, length FROM sakila.film
WHERE length > (SELECT AVG(length) FROM sakila.film);
-- number 3
SELECT first_name, last_name FROM sakila.actor AS a
JOIN sakila.film_actor AS fa
ON a.actor_id = fa.actor_id
JOIN sakila.film AS f
ON fa.film_id = f.film_id
WHERE title = 'Alone Trip';