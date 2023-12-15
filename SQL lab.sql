/*Write SQL queries to perform the following tasks using the Sakila database:

Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.*/

SELECT COUNT(i.film_id), f.title
FROM sakila.inventory AS i
INNER JOIN  sakila.film AS f
ON i.film_id = f.film_id
WHERE f.title = "Hunchback Impossible";

/*List all films whose length is longer than the average length of all the films in the Sakila database.*/

SELECT title, length 
FROM sakila.film
WHERE length >= (SELECT AVG(length) FROM sakila.film);


SELECT AVG(length) FROM sakila.film;


/* Use a subquery to display all actors who appear in the film "Alone Trip". */

SELECT b.film_id, b.actor_id,CONCAT(a.first_name," ",a.last_name) AS full_name
FROM film_actor AS b
INNER JOIN sakila.actor AS a
ON b.actor_id = a.actor_id
WHERE film_id = 17 /*film_id from Alone Trip is 17*/
             

