SELECT film.film_id, film.title, COUNT(*) AS copies_available
FROM  inventory 
JOIN film ON inventory.film_id = film.film_id
    WHERE film.title = "Hunchback Impossible"
GROUP BY film.film_id, film.title; -- 1

SELECT film_id, title,length
FROM film
WHERE length > (
	SELECT AVG(length)
    FROM film
); -- 2

SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id IN (
	SELECT film_actor.actor_id
    FROM film_actor
	JOIN film ON film_actor.film_id = film.film_id
	WHERE film.title = "Alone Trip"
); -- 3

SELECT film.film_id, film.title
FROM film
JOIN film_category ON film.film_id = film_category.film_id -- joining film and film_category tables
JOIN category ON film_category.category_id = category.category_id -- joining film_category and film tables
WHERE category.name = "Family"; -- 4

SELECT cu.customer_id, cu.first_name, cu.last_name, cu.email
FROM customer cu
WHERE cu.address_id IN (
	SELECT ad.address_id
    FROM address ad
	JOIN city c ON ad.city_id = c.city_id -- joining address and city tables
	JOIN country co ON c.country_id = co.country_id -- joining city and country tables
    WHERE co.country = ("Canada")
); -- 5

SELECT actor.actor_id, actor.first_name, actor.last_name,
COUNT(actor.actor_id) AS number_of_movies
FROM actor
JOIN film_actor on actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name
ORDER BY number_of_movies DESC
LIMIT 1; -- identifying the most prolific actor

SELECT DISTINCT film.film_id, film.title
FROM film
JOIN film_actor ON film_actor.film_id = film.film_id
WHERE film_actor.actor_id = (
	SELECT film_actor.actor_id
	FROM film_actor
    GROUP BY film_actor.actor_id
	ORDER BY COUNT(*) DESC
	LIMIT 1
); -- 6

SELECT DISTINCT film.film_id, film.title
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN customer ON rental.customer_id = customer.customer_id
WHERE customer.customer_id = (
	SELECT customer.customer_id
    FROM customer
    JOIN payment ON customer.customer_id = payment.customer_id
    GROUP BY customer.customer_id
    ORDER BY SUM(amount) DESC
	LIMIT 1
); -- 7

SELECT payment.customer_id, SUM(payment.amount) AS total_spend -- calc total spend per customer
FROM payment
GROUP BY payment.customer_id
HAVING SUM(payment.amount) > ( -- comparing total spend per customer and avg on ttoal customer spend
	SELECT AVG(customer_total) -- avg of total customer spending
    FROM (
		SELECT SUM(amount) as customer_total -- sum of total spend per customer
        FROM payment
        GROUP BY payment.customer_id
	) AS total
); -- 8
	


	

