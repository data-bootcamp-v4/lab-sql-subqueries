-- Write SQL queries to perform the following tasks using the Sakila database:
use sakila;
-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(*) 
FROM sakila.film as sf -- tabla 1 a unir
JOIN sakila.inventory as si -- tabla 2 a unir (inner)
on sf.film_id=si.film_id -- columna común
WHERE sf.title = "Hunchback Impossible";

-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT sf.title, sf.length 
FROM sakila.film as sf
WHERE sf.length>(SELECT AVG(sf.length) as average
FROM sakila.film as sf);

-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT sf.title, CONCAT(sa.first_name," ",sa.last_name) as actor
FROM sakila.film as sf
join sakila.film_actor as sfa
on sf.film_id=sfa.film_id
join sakila.actor as sa
on sfa.actor_id=sa.actor_id
WHERE sf.title="Alone Trip";

-- Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.


-- Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
-- Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
-- Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.





SELECT sr.rental_id 
FROM sakila.rental as sr
SELECT sc.customer_id,  -- selecciono las columnas que quiero de las dos uniones realizadas (8)
		SUM(sp.amount) as payments_sum             
FROM sakila.film as sf  -- mi primera tabla a unir (1)
join sakila.inventory as si -- mi segunda tabla a unir (2)
on sf.film_id = si.film_id -- columna comun de la primera unión (3)
join sakila.rental as sr -- mi tercera tabla unir con el resultado de la unión previa (4)
on  si.inventory_id = sr.inventory_id -- columna comun de la segunda unión (5)
join sakila.payment as sp -- mi cuarta tabla unir con el resultado de la unión previa (6)
on  sr.rental_id = sp.rental_id -- columna comun de la segunda unión (7)
join sakila.customer as sc -- mi quinta tabla unir con el resultado de la unión previa (8)
on  sp.customer_id = sc.customer_id -- columna comun de la segunda unión (9)
GROUP BY sc.customer_id
ORDER BY payments_sum DESC
LIMIT 1;
-- Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.