USE sakila;

#1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(inventory.film_id)
FROM INVENTORY
WHERE inventory.film_id = 
(SELECT film.film_id
FROM film
WHERE title = "HUNCHBACK IMPOSSIBLE");

#2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length
FROM film
WHERE length >
	(SELECT AVG(length)
    FROM film);
    
#3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT CONCAT(actor.first_name," ", actor.last_name) AS full_name
from film_actor
INNER JOIN actor ON film_actor.actor_id = actor.actor_id
where film_actor.film_id =
(SELECT film_id
FROM film
WHERE title = "ALONE TRIP");

#4. Identify all movies categorized as family films.

SELECT title, rating
FROM film
WHERE rating = "G" OR rating = "PG";

#5. Retrieve the name and email of customers from Canada. 

SELECT CONCAT(customer.first_name," ", customer.last_name) AS full_name, email, country.country
FROM customer
INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
WHERE country.country = "CANADA";

#6. Determine which films were starred by the most prolific actor in the Sakila database.

SELECT title
FROM film 
INNER JOIN film_actor ON film.film_id = film_actor.film_id
WHERE actor_id =
(SELECT actor_id
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(actor_id) DESC
LIMIT 1);
