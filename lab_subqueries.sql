-- Write SQL queries to perform the following tasks using the Sakila database:

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT film.title,
COUNT(inventory.film_id) AS number_copies
FROM sakila.film
JOIN sakila.inventory ON film.film_id = inventory.film_id
WHERE film.title = "Hunchback Impossible";



-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT AVG(length) FROM sakila.film;  # average duration is 115min

SELECT film.title, film.length
FROM sakila.film
WHERE film.length > (SELECT AVG(length) AS 'Average' FROM sakila.film);



-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT film.title, actor.first_name, actor.last_name
FROM sakila.film
JOIN sakila.film_actor ON film.film_id = film_actor.film_id
JOIN sakila.actor ON film_actor.actor_id = actor.actor_id
WHERE film.title = "Alone Trip";
#acima: versão sem subquery para mim easy, mas enunciado pede com subquery

#agora com subquery:
SELECT film_id FROM sakila.film WHERE title = "Alone Trip";  #17 -> esse nmr vai basicamente dar à query principal

SELECT actor.first_name, actor.last_name
FROM sakila.film_actor
JOIN sakila.actor ON film_actor.actor_id = actor.actor_id
WHERE film_actor.film_id = (SELECT film_id FROM sakila.film WHERE title = "Alone Trip");



-- Bonus:


-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
SELECT DISTINCT name FROM sakila.category;   #to know the name of the categories; 'family films' correspond to the category named 'family'

SELECT film.title, category.category_id, category.name #category.category_id, category.name could not be here, but it is useful to verificar se está correto
FROM sakila.film
JOIN sakila.film_category ON film.film_id = film_category.film_id
JOIN sakila.category ON film_category.category_id = category.category_id
WHERE category.name = 'family';



-- 5. Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT DISTINCT country FROM sakila.country;  #just to check if canada's in the list

SELECT customer.first_name, customer.last_name, customer.email
FROM sakila.customer 
JOIN sakila.address ON customer.address_id = address.address_id 
JOIN sakila.city ON address.city_id = city.city_id
JOIN sakila.country ON city.country_id = country.country_id
WHERE country.country = 'canada';
# above is the version i'm more confortable with e que tenho mais "domínio" até agora 

#abaixo, with one join less:
SELECT customer.first_name, customer.last_name, customer.email
FROM sakila.customer 
JOIN sakila.address ON customer.address_id = address.address_id 
JOIN sakila.city ON address.city_id = city.city_id
WHERE city.country_id = (SELECT country_id FROM sakila.country WHERE country = 'Canada');



-- 6. Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

# i first try to find the actor_id of the actor who's acted in the most number of films
SELECT actor.actor_id,
COUNT(film_actor.film_id) AS number_films
FROM sakila.actor
JOIN sakila.film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
ORDER BY number_films DESC; 
# the output gave actor_id = 107, with a total number of films of 42. 

# just to know the name of actor, i can use the actor_id = 107 to retrieve the info about his/her first and last name:
SELECT actor.first_name, actor.last_name
FROM sakila.actor
WHERE actor.actor_id = 107; # output = Gina Degeneres

# now back to the final part of the exercice: find the films where Gina participated in
SELECT film.title, film_actor.actor_id
FROM sakila.film
JOIN sakila.film_actor ON film.film_id = film_actor.film_id
JOIN sakila.actor ON film_actor.actor_id = actor.actor_id
WHERE actor.actor_id = 107;



-- 7. Find the films rented by the most profitable customer in the Sakila database. 
-- You can use the customer and payment tables to find the most profitable customer, 
-- i.e., the customer who has made the largest sum of payments.
SELECT customer.customer_id,
SUM(payment.amount) AS sum_payments
FROM sakila.customer
JOIN sakila.payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY sum_payments DESC;   # customer_id of the most profitable customer -> 526

SELECT film.title
FROM sakila.customer
JOIN sakila.rental ON customer.customer_id = rental.customer_id
JOIN sakila.inventory ON rental.inventory_id = inventory.inventory_id
JOIN sakila.film ON inventory.film_id = film.film_id
WHERE customer.customer_id = 526;



-- 8. Retrieve the client_id and the total_amount_spent of those clients 
-- who spent more than the average of the total_amount spent by each client. 
-- You can use subqueries to accomplish this.

#first i want to know how much each client spent
SELECT customer.customer_id,
SUM(payment.amount) AS sum_payments
FROM sakila.customer
JOIN sakila.payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id;

# total average spent by client
SELECT AVG(sum_payments) as total_avg
FROM (
	SELECT customer.customer_id,
    SUM(payment.amount) AS sum_payments
	FROM sakila.customer
	JOIN sakila.payment ON customer.customer_id = payment.customer_id
	GROUP BY customer.customer_id
) AS total_per_customer;

# final query: retrieve clients who spent more than the average calculated above
SELECT customer.customer_id,
    SUM(payment.amount) AS sum_payments
FROM sakila.customer
JOIN sakila.payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
HAVING SUM(payment.amount) > (
    SELECT AVG(sum_payments) AS total_avg
    FROM (
        SELECT customer.customer_id,
        SUM(payment.amount) AS sum_payments
        FROM sakila.customer
        JOIN sakila.payment ON customer.customer_id = payment.customer_id
        GROUP BY customer.customer_id
    ) AS total_per_customer
);


