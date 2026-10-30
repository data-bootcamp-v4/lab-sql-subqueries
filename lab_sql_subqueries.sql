-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select count(inventory_id) as number_of_movies
from inventory
where film_id in (select film_id
from film
where title = "Hunchback Impossible");

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
select title, length as length_average
from film
where length > (select round(avg(length)) as "length_average"
from film);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
select first_name, last_name
from actor
where actor_id in (select actor_id
from film_actor
where film_id = (select film_id
					from film
                    where title = "Alone Trip"));

-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
select title
from film
where film_id in (select film_id
from film_category
where category_id in (select category_id
from category
where name = "family"));


-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.\



