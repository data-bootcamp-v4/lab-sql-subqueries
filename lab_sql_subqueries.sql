#Write SQL queries to perform the following tasks using the Sakila database:

#Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT count(film_id)
FROM inventory
WHERE film_id = (SELECT film_id 
				FROM film
				WHERE title like "Hunchback Impossible");
                
	
#List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length
FROM film 
WHERE length >(
				SELECT AVG(length)
				FROM film)
ORDER BY length DESC;


#Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT first_name , last_name 
FROM actor a
JOIN film_actor fa
ON fa.actor_id = a.actor_id
WHERE fa.film_id like (SELECT film_id 
						FROM film
						WHERE title like "Alone Trip");


