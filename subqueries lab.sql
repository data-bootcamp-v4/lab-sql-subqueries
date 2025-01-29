use sakila;

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.


select film_id, count(inventory_id) as count_hunchback
from inventory
where film_id in (select film_id
				from film
				where title = "Hunchback Impossible")
group by film_id;
-- id = 439, 6

-- List all films whose length is longer than the average length of all the films in the Sakila database.


SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- Use a subquery to display all actors who appear in the film "Alone Trip"

select first_name, last_name
from actor
where actor_id in (select actor_id
					from film_actor
                    where film_id= (select film_id
									from film
                                    where title = "Alone Trip"));

                                    
                                    
                                    
                                    
                                    
                                    