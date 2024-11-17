SELECT COUNT(*) AS "Number of copies of Hunchback Impossible"
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = "HUNCHBACK IMPOSSIBLE");

SELECT title AS "Longer than the average length"
FROM film
WHERE length > (SELECT AVG(length) FROM film);

SELECT CONCAT(first_name, " ", last_name) AS "Actors who appear in Alone Trip"
FROM actor A
JOIN film_actor FA ON A.actor_id = FA.actor_id
WHERE film_id = (SELECT film_id FROM film WHERE title = "ALONE TRIP");