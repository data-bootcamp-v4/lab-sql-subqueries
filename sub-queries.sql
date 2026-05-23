-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT f.title, 
	(SELECT COUNT(i.inventory_id) FROM inventory i WHERE i.film_id = f.film_id ) AS "number_of_copies"
FROM film f
WHERE f.title = 'Hunchback Impossible';
	
    
-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
select title, length
from film
where length > (select avg(length) from film);


-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (SELECT fa.actor_id FROM film_actor fa WHERE fa.film_id = ( SELECT f.film_id FROM film f WHERE f.title = 'Alone Trip'));


-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
select f.title 
from film f
where f.film_id in (select fc.film_id from film_category fc where fc.category_id = (select c.category_id from category c where c.name = "family"));


-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. 
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.

select * from customer;
select * from country;
select * from address;
select * from city;





















