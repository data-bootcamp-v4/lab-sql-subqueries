USE sakila;

#1
SELECT * FROM sakila.inventory;
SELECT * FROM sakila.film;

-- Mine
SELECT title, COUNT(*) AS nr_of_copies
FROM sakila.film AS f
INNER JOIN sakila.inventory AS i
ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible';

-- Using subqueries
SELECT COUNT(*) AS nr_of_copies
FROM sakila.inventory
WHERE film_id =
( 
	SELECT film_id
    FROM sakila.film AS f
    WHERE f.title = 'Hunchback Impossible'
);


#2
SELECT title, length
FROM sakila.film
WHERE film.length >
(
	SELECT AVG(length) AS avg_length
	FROM sakila.film
)
ORDER BY length;

#3
SELECT * FROM sakila.film;
SELECT * FROM sakila.actor;
SELECT * FROM sakila.film_actor;

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM sakila.actor AS a
INNER JOIN sakila.film_actor AS fa
ON a.actor_id = fa.actor_id
WHERE film_id =
(
 SELECT film_id
 FROM sakila.film
 WHERE title = 'Alone Trip'
);

#4
SELECT * FROM sakila.category;
SELECT * FROM sakila.film_category;
SELECT * FROM sakila.film;

SELECT title
FROM sakila.film AS f	
INNER JOIN sakila.film_category AS fc
ON f.film_id = fc.film_id
WHERE category_id =
(
 SELECT category_id
 FROM sakila.category
 WHERE name = 'Family'
);