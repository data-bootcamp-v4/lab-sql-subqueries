use sakila;
#Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.



select count(*) as number_of_copies
from inventory
where film_id = 
	(select film_id
	from film 
	where title = "Hunchback Impossible");
    
# List all films whose length is longer than the average length of all the films in the Sakila database.


SELECT title, length
FROM film
WHERE length > 
	(SELECT AVG(length)
    FROM film);
    
# Use a subquery to display all actors who appear in the film "Alone Trip".