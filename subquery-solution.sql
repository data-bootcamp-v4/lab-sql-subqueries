-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
 use sakila;
 
 select * from film;
 select * from inventory;

SELECT COUNT(*) AS num_of_copies
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');

 -- 2.List all films whose length is longer than the average length of all the films in the Sakila database.

 select avg(length) from film;
 
 select title, length from film
 where length > ( select avg(length) from film);
 
 -- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
 
select * from actor;
select * from  film_actor;
select * from film;
 
SELECT a.*
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip');
