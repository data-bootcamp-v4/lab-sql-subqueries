use sakila;
#1
SELECT COUNT(i.inventory_id) AS Number_of_Copies
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible';
#2
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC;
#3
SELECT a.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS Actor_Name
FROM actor AS a
JOIN film_actor AS fa ON a.actor_id = fa.actor_id
WHERE fa.film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip');


