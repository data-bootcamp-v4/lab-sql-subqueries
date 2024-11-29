use sakila;
-- 1-Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select f.title, count(i.film_id) as total
from film as f
join inventory as i
on f.film_id = i.film_id
where f.title = 'Hunchback Impossible'
group by f.title;

-- 2-List all films whose length is longer than the average length of all the films in the Sakila database.
select title
from film
where length > (select round(avg(length),2)
from film);

-- 3-Use a subquery to display all actors who appear in the film "Alone Trip".
select concat(first_name,' ',last_name) as 'actors'
from actor as a
join film_actor as fa
on a.actor_id = fa.actor_id
join film as f
on fa.film_id = f.film_id
where title = 'Alone Trip';

-- 4-Sales have been lagging among young families, and you want to target family movies for a promotion. 
-- Identify all movies categorized as family films.
select f.title
from film as f
join film_category as fc
on f.film_id = fc.film_id
join category as c
on fc.category_id = c.category_id
where name= 'family';









