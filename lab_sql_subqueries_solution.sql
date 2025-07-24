USE sakila;
#Write SQL queries to perform the following tasks using the Sakila database:
#Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(inventory_id)
FROM inventory
WHERE inventory_id IN (SELECT film_id FROM film WHERE title = "Hunchback Impossible");
#List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);
#Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT first_name, last_name
FROM actor
WHERE actor_id IN(SELECT actor_id FROM film_actor 
	WHERE film_id IN(SELECT film_id 
					FROM film 
					WHERE title = "Alone Trip")); 
                    
#Identify all movies categorized as family films.
SELECT title
FROM film
WHERE film_id IN (SELECT film_id FROM film_category WHERE category_id 
IN (SELECT category_id FROM category WHERE name ="family"));
#Retrieve the name and email of customers from Canada using both subqueries and joins. 
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (SELECT address_id FROM address 
WHERE city_id IN(SELECT city_id FROM city WHERE country_id = (SELECT country_id FROM country WHERE country="Canada" )));
#Determine which films were starred by the most prolific actor in the Sakila database. 
SELECT COUNT(film_id) AS number_of_films, actor_id
FROM film_actor
GROUP BY(actor_id)
ORDER BY number_of_films DESC;
#A prolific actor is defined as the actor who has acted in the most number of films. 
#First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she
# starred in.
SELECT title 
FROM film 
WHERE film_id IN (SELECT film_id FROM film_actor
WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE actor_id=107));

#Find the films rented by the most profitable customer in the Sakila database. 

#You can use the customer and payment tables to find the most profitable customer, i.e., 
#the customer who has made the largest sum of payments.
#Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of 
#the total_amount spent by each client. You can use subqueries to accomplish this.
