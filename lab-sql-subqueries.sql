#lab-sql-subqueries
USE sakila;

#1.Determine the number of copies of the film "Hunchback Impossible"
# that exist in the inventory system.

SELECT COUNT(inventory_id) as hunchback_copies
FROM inventory
WHERE film_id IN (SELECT film_id
				  FROM film 
                  WHERE title = "Hunchback Impossible");
                  
#2.List all films whose length is longer than the average length 
#of all the films in the Sakila database.
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

#3.Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT CONCAT(first_name, " ", last_name) as actor_name
FROM actor
WHERE actor_id IN (SELECT actor_id
				   FROM film_actor
                   WHERE film_id IN (SELECT film_id
									 FROM film
                                     WHERE title = "Alone Trip"));
                                     
#4.Sales have been lagging among young families, and you want to target family movies for a promotion. 
#Identify all movies categorized as family films.
SELECT title
FROM film
WHERE film_id IN (SELECT film_id
				  FROM film_category
                  WHERE category_id IN (SELECT category_id
										FROM category
                                        WHERE name like "%family%"));

#5.Retrieve the name and email of customers from Canada using both subqueries and joins. 
SELECT email
FROM customer 
INNER JOIN address
WHERE city_id IN(SELECT city_id
				FROM city
				WHERE country_id IN (SELECT country_id
										 FROM country
                                         WHERE country = "Canada"));
                                         
#6.Determine which films were starred by the most prolific actor in the Sakila database.
SELECT COUNT(film_id), actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC;
#actor_id = 107 starred the most films

SELECT title
FROM film
WHERE film_id IN (SELECT film_id
				  FROM film_actor
                  WHERE actor_id = 107);