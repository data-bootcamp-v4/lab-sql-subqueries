-- Write SQL queries to perform the following tasks using the Sakila database:

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select count(*) as num_copies
FROM inventory
WHERE film_id = (SELECT film_id from film where title = "Hunchback Impossible");

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
select title, length
FROM film
WHERE length > (
SELECT AVG(length) FROM film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
Select actor
from
(SELECT fa.film_id, fi.title, fa.actor_id, concat(a.first_name, ' ' , a.last_name) AS Actor
from film_actor AS fa
JOIN actor AS a ON fa.actor_id = a.actor_id
JOIN film AS fi
ON fa.film_id = fi.film_id) AS s
where title = 'Alone Trip';

 