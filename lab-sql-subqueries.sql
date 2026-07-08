use sakila;

SELECT COUNT(*) AS copies
FROM inventory
WHERE film_id = (
    SELECT film_id FROM film WHERE title = 'Hunchback Impossible'
);

select title, length
from film
where length > (select avg(length) from film);

SELECT actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
WHERE film_actor.film_id = (
    SELECT film_id FROM film WHERE title = 'Alone Trip'
);
