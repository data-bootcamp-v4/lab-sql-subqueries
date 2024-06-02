Use sakila;

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

select * from sakila.film
where title = "Hunchback Impossible";

select title, count(*) as number_of_copies from sakila.film as f
join sakila.inventory as i
on f.film_id = i.film_id
where title = "Hunchback Impossible";

-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT actor.first_name, actor.last_name
FROM actor
WHERE actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    WHERE f.title = 'Alone Trip'
);