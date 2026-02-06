use sakila;

-- Q1
select f.title, 
		count(*) as n_movies
from inventory i
left join film f on f.film_id = i.film_id
where f.title = "Hunchback Impossible"
;


-- Q2
-- avg legth 
select avg(length) 
from film
;

-- movies above avg length 
select film_id, title, length 
from film
where length > (
			select avg(length) from film
            )
;


-- Q3

select fa.film_id, 
		fa.actor_id,
        f.title,
        concat(a.first_name, " ", a.last_name) as actor_name
from film_actor fa
left join film f on f.film_id = fa.film_id
left join actor a on a.actor_id = fa.actor_id
where fa.film_id in (
		select film_id
        from film
        where title = "Alone Trip"
        )
;



-- Q4
select rating, title, film_id
from film
where rating in ("PG", "G")
;


-- Q6


select actor_id
from film_actor
group by actor_id
order by count(film_id) DESC
limit 1
;


select * 
from film f
join film_actor fa on fa.film_id = f.film_id
;


-- Final Query
select * 
from film f
join film_actor fa on fa.film_id = f.film_id
where fa.actor_id = (
		select actor_id
		from film_actor
		group by actor_id
		order by count(film_id) DESC
		limit 1
        )
;



