use sakila;
Select *
from rental;
-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select count(*) as 'copies'
from inventory
where film_id = (select film_id from film where title = 'Hunchback Impossible');

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
select title, length
from film
where length > (select avg(length) as 'avg length' from film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
select a.first_name, a.last_name
from actor as a
where actor_id in
(select actor_id from film_actor as fa
	where fa.film_id = (select film_id from film where title = 'Alone Trip')
)
