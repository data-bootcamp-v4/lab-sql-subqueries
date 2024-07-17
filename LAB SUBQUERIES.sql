#Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT title, count(*)
FROM film
WHERE film_id IN (
    SELECT inventory.film_id
    FROM inventory
)
AND title = 'Hunchback Impossible'
GROUP BY title;
#2n method withou subquery
select title, count(*)
from film
join inventory
on film.film_id = inventory.film_id
where film.title = "Hunchback Impossible";

#List all films whose length is longer than the average length of all the films in the Sakila database.

select title, length
from film
where length > (select avg(length) from film);

#Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT film_actor.actor_id
    FROM film_actor
    JOIN film ON film.film_id = film_actor.film_id
    WHERE film.title = 'Alone Trip'
);
# 2nd method without subquery
select first_name, last_name
from actor
join film_actor
on film_actor.actor_id = actor.actor_id
join film
on film.film_id = film_actor.film_id
where film.title = "Alone Trip"

