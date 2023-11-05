# Lab | Subqueries
#1
SELECT count(*) as Copies
from sakila.film
inner join sakila.inventory as i
on film.film_id = i.film_id
where film.title like "Hunchback Impossible";

# 2
select title
from sakila.film
where length > (select AVG(length) from sakila.film);

#3 
SELECT * FROM sakila.film_actor;

SELECT  CONCAT(first_name, " ", last_name) as name
from sakila.actor
inner join sakila.film_actor
on actor.actor_id = film_actor.actor_id
inner join sakila.film as f
on film_actor.film_id = f.film_id
where f.title = "Alone Trip";

## with subqueries

SELECT CONCAT(first_name, " ", last_name) as name
from sakila.actor
inner join sakila.film_actor
on actor.actor_id = film_actor.actor_id
Where film_actor.film_id IN (SELECT film.film_id
						from sakila.film
                        where film.title like "Trip Alone");