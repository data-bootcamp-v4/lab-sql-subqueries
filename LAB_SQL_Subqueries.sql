-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select count(inventory_id)
from sakila.inventory
where film_id in (select film_id from sakila.film where title = 'Hunchback impossible');

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.

select title from sakila.film where length > (select avg(film.length)
from sakila.film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

select first_name, last_name 
from actor 
where actor_id in 
	(select actor_id 
    from film_actor 
    where film_id in 
		(select film_id 
        from film 
        where title = 'Alone Trip'));