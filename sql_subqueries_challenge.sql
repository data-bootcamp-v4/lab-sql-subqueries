-- SQL Subqueries Challenge

-- 1. Number of copies of Hunchback Impossible
select count(*) from inventory join film on inventory.film_id = film.film_id where title = 'Hunchback Impossible';

-- as a subquery
select count(*) from inventory where film_id in (select film_id from film where title = 'Hunchback Impossible');

-- 2. films whose length is longer than the average length of all the films

select * from film where length > (select avg(length) from film);

-- 3. actors who appear in the film "Alone Trip"

-- Two versions
-- a) with one subquery and a join
select * from actor join film_actor on actor.actor_id = film_actor.actor_id where film_id in (select film_id from film where title = 'Alone Trip');
-- b) just with subqueries
select * from actor where actor_id in (select actor_id from film_actor where film_id in (select film_id from film where title = 'Alone Trip'));

-- 4. Family films

select title
from film join film_category on film.film_id = film_category.film_id
where category_id in (select category_id from category where name = 'Family');


-- The rest bonus stuff looks great but I need to sleep
