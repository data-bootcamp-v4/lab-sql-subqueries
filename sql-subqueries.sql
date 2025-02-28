
## Challenge

#Write SQL queries to perform the following tasks using the Sakila database:

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select 
count(distinct i.inventory_id) 
from inventory i where
i.film_id in 
(select 
f.film_id
from film f
where f.title='Hunchback Impossible'
);
-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
select f.film_id, f.title 
from film f
where
f.length >(select avg(f.length) 
from film f);

-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
select a.first_name , a.last_name
from actor a
where a.actor_id in 
(select distinct(fa.actor_id)
from
film_actor fa
where 
fa.film_id in 
(select f.film_id 
from film f
where f.title='Alone Trip'));

-- **Bonus**:

-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films. 
select f.title
from film f
where f.film_id in
(select fc.film_id 
from film_category fc
where  fc.category_id 
in 
(select category_id 
from category where 
name='Family'));

-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, 
-- you will need to identify the relevant tables and their primary and foreign keys.
select c.first_name , c.email 
from customer c
join address a
on c.address_id= a.address_id
where  a.city_id in
(
select c.city_id from
city c
join country cn
on c.country_id=cn.country_id
where cn.country='Canada'
);

-- 6. Determine which films were starred by the most prolific actor in the Sakila database.
-- A prolific actor is defined as the actor who has acted in the most number of films.
-- First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

select  first_name ,lastname 
from actor
where actor_id in
(select count(distinct film_id) as total_films, actor_id
from film_actor
group by actor_id 
having max(total_films)) ;



-- 7. Find the films rented by the most profitable customer in the Sakila database. 
-- You can use the customer and payment tables to find the most profitable customer, 
-- i.e., the customer who has made the largest sum of payments.


SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) = (
        SELECT MAX(total_payment)
        FROM (
            SELECT customer_id, SUM(amount) AS total_payment
            FROM payment
            GROUP BY customer_id
        ) AS subquery
    )
);

-- 8. Retrieve the client_id and the total_amount_spent of those clients who spent more
-- than the average of the total_amount spent by each client. You can use subqueries to accomplish this.

    SELECT customer_id, sum(amount) as total_amount
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > (
        SELECT AVG(total_payment) 
        FROM (
            SELECT customer_id, SUM(amount) AS total_payment
            FROM payment
            GROUP BY customer_id
        ) AS subquery
    
);

