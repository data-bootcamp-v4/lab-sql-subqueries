/*1*/
SELECT title, COUNT(inventory.inventory_id)
FROM sakila.film
INNER JOIN sakila.inventory
ON film.film_id = inventory.film_id
WHERE title = "Hunchback Impossible"
GROUP BY title;


/*2*/
SELECT title
FROM sakila.film
WHERE length > (SELECT AVG(length) FROM film );



/*3*/
SELECT film_actor.film_id, title
FROM sakila.film_actor
INNER JOIN (
			SELECT film_id, title 
			FROM sakila.film
			WHERE film.title = "Alone Trip") selected_film
ON film_actor.film_id = selected_film.film_id;

/*4*/
SELECT categories_film.title, category.name
FROM sakila.category
INNER JOIN
	(SELECT title, category_id
	FROM sakila.film
	INNER JOIN film_category
	ON film.film_id = film_category.category_id) categories_film
ON category.category_id = categories_film.category_id
WHERE name = 'Family';

/*5*/
WITH customers_city AS 
	(SELECT  customer_info.Full_Name, customer_info.email, country_id
	FROM sakila.city
	INNER JOIN
		(SELECT CONCAT(customer.first_name," ", customer.last_name) AS Full_Name, customer.email,city_id
		FROM sakila.customer
		INNER JOIN sakila.address
		ON address.address_id = customer.address_id) customer_info
	ON city.city_id = customer_info.city_id)

SELECT customers_city.Full_Name, customers_city.email
FROM sakila.country
INNER JOIN customers_city
ON customers_city.country_id = country.country_id
WHERE country = 'Canada';
/*6*/ 
SELECT film_id,actor.actor_id, CONCAT(actor.first_name," ", actor.last_name) AS Full_Name
FROM sakila.film_actor
INNER JOIN sakila.actor
ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1;
#Gina Degneres actor_107 is the GOAT
SELECT title
FROM sakila.film
INNER JOIN film_actor
ON film.film_id = film_actor.film_id
WHERE film_actor.actor_id = 107;

/*7*/
SELECT title
FROM sakila.film
INNER JOIN
	(SELECT film_id
	FROM inventory
	INNER JOIN
		(SELECT inventory_id FROM sakila.rental
		INNER JOIN
			(SELECT payment.customer_id, CONCAT(customer.first_name," ", customer.last_name) AS Full_Name
			FROM customer
			INNER JOIN payment
			ON customer.customer_id = payment.customer_id
			GROUP BY customer_id
			ORDER BY amount DESC
			LIMIT 1) MPC
		ON rental.customer_id = MPC.customer_id) inven_MPC
	ON inventory.inventory_id = inven_MPC.inventory_id) film_id_MPC
ON film_id_MPC.film_id = film.film_id;

/*8*/
SELECT customer_id AS "Client ID", amount AS "total_amount_spent"
FROM sakila.payment
WHERE  (SELECT AVG(amount) FROM payment) < amount 
GROUP BY customer_id
ORDER BY amount DESC