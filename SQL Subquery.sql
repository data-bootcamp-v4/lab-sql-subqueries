-- Challenge
-- Write SQL queries to perform the following tasks using the Sakila database:
use sakila;
-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(*) as number_of_copies
	FROM inventory 
    where film_id = (SELECT film_id from film where title = "Hunchback Impossible");
-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
	from film
    where length > (select AVG(length) from film);
-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT a.actor_id, a.first_name, a.last_name
	from actor a 
    where a.actor_id in (
		select fa.actor_id
        from film_actor fa 
        join film f on fa.film_id = f.film_id 
        where f.title = "Alone Trip" 
        );