-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.


SELECT 	count(*) from inventory
where film_id in
 (SELECT film_id FROM film
where title = 'Hunchback Impossible');

-- List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT * FROM film
where length > (Select avg(length) from film );

-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT Concat(first_name,' ',last_name) as Name FROM actor
where actor_id in (SELECT actor_id FROM film 
	where title = 'Alone Trip');
