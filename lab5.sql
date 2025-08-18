# 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

select count(i.film_id) as total_inv,
	   f.title
from film f
left join inventory i
on f.film_id = i.film_id
where f.title = "Hunchback Impossible";


# 2. List all films whose length is longer than the average length of all the films in the Sakila database.

select avg(f.length) as avg_duration,
	   f.title
from film f
group by f.title
having avg_duration > ( select avg(length) from film);


# 3. Use a subquery to display all actors who appear in the film "Alone Trip".

select a.first_name,
	   a.last_name
from (select fa.actor_id as actors,
	   f.title
from film_actor fa
left join film f
on fa.film_id = f.film_id
where f.title = "Alone Trip") x
left join actor a
on x.actors = a.actor_id;
