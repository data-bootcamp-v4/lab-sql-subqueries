USE sakila;
SHOW tables FROM sakila;

-- 1
SELECT title, COUNT(*) AS number_of_copies FROM (SELECT f.title, i.inventory_id FROM sakila.film as f
JOIN sakila.inventory as i ON f.film_id = i.film_id
WHERE title = 'Hunchback Impossible') AS STOCK; 

-- 2
SELECT AVG(length) FROM sakila.film; -- check what the total average is
SELECT title, length, (SELECT AVG(length) FROM sakila.film) AS AVG_LENGTH FROM sakila.film 
WHERE length > (SELECT AVG(length) FROM sakila.film)
ORDER BY length DESC; 

-- 3
SELECT first_name, last_name FROM sakila.actor as a
JOIN sakila.film_actor as fa ON a.actor_id = fa.actor_id
WHERE film_id = (SELECT film_id FROM sakila.film
WHERE title = 'Alone Trip');
