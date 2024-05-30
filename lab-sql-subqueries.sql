-- Write SQL queries to perform the following tasks using the Sakila database:

-- 1.Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select count(*) as no_of_copies 
    from inventory
    where film_id = 
		(select film_id 
        from film 
        where title = "Hunchback Impossible");

-- 2.List all films whose length is longer than the average length of all the films in the Sakila database.
select film_id, title, length
from film
where length > (
    select avg(length)
    from film
);


-- 3.Use a subquery to display all actors who appear in the film "Alone Trip".
select first_name, last_name
from actor
where actor_id in
	(select actor_id
	from film_actor
	where film_id =
		(select film_id 
		from film 
		where title = "Alone Trip"
		)
        );
        
-- Bonus:
-- 4.Sales have been lagging among young families, and you want to target family movies for a promotion. 
-- Identify all movies categorized as family films.
select 
    f.title
from film f
where 
    f.film_id in (
        select fc.film_id
        from film_category fc
        join category c on fc.category_id = c.category_id
        where c.name = 'Family'
    );

-- 5.Retrieve the name and email of customers from Canada using both subqueries and joins.
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.

select 
x.first_name,
x.last_name
from 
	(select co.country, cu.first_name, cu.last_name
	from country co
	left join city ci
		on co.country_id = ci.country_id
	left join address ad
		on ci.city_id = ad.city_id 
	left join customer cu 
		on ad.address_id = cu.address_id
	) x 
where x.country = "Canada";

-- 6. Determine which films were starred by the most prolific actor in the Sakila database. 
-- A prolific actor is defined as the actor who has acted in the most number of films. 
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

-- 7.Find the films rented by the most profitable customer in the Sakila database. 
-- You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.

-- 8.Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 
-- You can use subqueries to accomplish this.