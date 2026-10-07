use sakila;
-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select count(inventory_id) as number_of_copies from inventory where film_id=(select film_id from film where title = "Hunchback Impossible");

-- List all films whose length is longer than the average length of all the films in the Sakila database.
select * from film where length > (select avg(length)from film);



-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT 
    first_name, Last_name
FROM
    actor AS a
        JOIN
    film_actor AS fc ON a.actor_id = fc.actor_id
WHERE
    film_id = (SELECT 
            film_id 
        FROM
            film
        WHERE
            title = 'Alone Trip');
-- Bonus 
-- 4.Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

-- 5.Retrieve the name and email of customers from Canada using both subqueries and joins.
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.
select first_name , last_name , email from customer as c join address as a on c.address_id = a.address_id join city as ci on ci.city_id = a.city_id 
where country_id = (select country_id from country where country = "Canada");
-- only with joins :
select first_name , last_name , email from customer as c join address as a on c.address_id = a.address_id join city as ci on ci.city_id = a.city_id 
join country as co on ci.country_id=co.country_id where country = "Canada";
-- only with subquery :
select first_name ,last_name, email from customer where address_id in
(select address_id from address where city_id in (select city_id from city where country_id  =(select country_id from country where country = "Canada")));
-- 6.Determine which films were starred by the most prolific actor in the Sakila database. 
-- A prolific actor is defined as the actor who has acted in the most number of films. First,
-- you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
select actor_id ,count(film_id) as number_of_films from film_actor group by actor_id order by number_of_films desc limit 1;
 select title from film join film_actor on film.film_id = film_actor.film_id where actor_id =
 (select actor_id from film_actor group by actor_id order by count(film_id) desc limit 1);
-- 7.Find the films rented by the most profitable customer in the Sakila database. 
-- You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.

-- 8.Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
--  You can use subqueries to accomplish this.