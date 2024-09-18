-- Challenge 2

-- 1

SELECT
	f.title AS Movie_name,
	COUNT(i.film_id) AS num_of_copies
FROM inventory AS i
JOIN film AS f
	ON i.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible';

-- 2 

SELECT
	title,
    length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- 3

SELECT * FROM actor;
SELECT * FROM film_actor;

SELECT
	CONCAT(a.first_name, ' ', a.last_name) AS actors_name
FROM actor AS a
JOIN film_actor AS fa
	ON a.actor_id = fa.actor_id
JOIN film as f
	ON fa.film_id = f.film_id 
WHERE f.title = 'Alone Trip';