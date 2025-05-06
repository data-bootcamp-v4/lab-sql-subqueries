USE sakila;
#Write SQL queries to perform the following tasks using the Sakila database:

#1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(inventory_id) AS number_of_copies
FROM inventory
WHERE film_id = (select film_id
					from film
                    where title = 'Hunchback Impossible');

			
#2 List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length 
FROM film
WHERE length > (select avg(length)
					FROM film);


#3 Use a subquery to display all actors who appear in the film "Alone Trip".




#6 Determine which films were starred by the most prolific actor in the Sakila database. 
#A prolific actor is defined as the actor who has acted in the most number of films. 
#First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
select title
from film
where film_id in (select film_id 
					from film_actor
					where actor_id = (select actor_id
										from film_actor
										group by actor_id
										ORDER BY COUNT(film_id) DESC
										limit 1 ));
			
#Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 
#You can use subqueries to accomplish this.
#average amount first 
#than sum amount of evey customer with customer_id 
select customer_id, sum(amount) as tspc
from payment
group by customer_id
having tspc  > (select avg(ts)
				from (select sum(amount) ts
						from payment
						group by customer_id) as total_amount_spent);



