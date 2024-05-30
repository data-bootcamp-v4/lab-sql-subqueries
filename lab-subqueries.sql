-- EX1
SELECT title, COUNT(inventory_id) as 'Inventory total' from inventory as i,
(SELECT title, film_id from film WHERE title = "Hunchback Impossible") AS subquery
WHERE i.film_id = subquery.film_id
GROUP BY title;

-- EX2 
SELECT title, length from film,
(SELECT AVG(length)as avglength from film) AS subquery
WHERE length > subquery.avglength;

-- EX3
SELECT CONCAT(first_name," ",last_name)AS "Actors in the movie" from actor,
(SELECT actor_id from film_actor
WHERE film_id IN (SELECT film_id FROM film WHERE title ='Alone Trip')) AS subquery
WHERE actor.actor_id = subquery.actor_id