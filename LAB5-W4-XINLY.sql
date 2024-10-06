#Write SQL queries to perform the following tasks using the Sakila database:

#1Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system
SELECT COUNT(i.inventory_id) AS number_of_copies
FROM sakila.film AS f
JOIN sakila.inventory AS i 
ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible';

#2.List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title,length
FROM sakila.film
WHERE length>(SELECT AVG(length) FROM sakila.film);

#3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT CONCAT(a.first_name, ' ', a.last_name) AS actors
FROM sakila.actor AS a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM sakila.film_actor AS fa
    WHERE fa.film_id = (
        SELECT f.film_id
        FROM sakila.film AS f
        WHERE f.title = 'Alone Trip'
    )
);

#Bonus:

#4.Sales have been lagging among young families, and you want to target family movies for a promotion. 
#Identify all movies categorized as family films.
SELECT f.title
FROM sakila.film AS f
WHERE f.film_id IN (
    SELECT fc.film_id
    FROM sakila.film_category AS fc
    JOIN sakila.category AS c ON fc.category_id = c.category_id
    WHERE c.name = 'Family');
    
    #5.Retrieve the name and email of customers from Canada using both subqueries and joins. 
    #To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT CONCAT(c.first_name,' ',c.last_name) AS name_customer,c.email
FROM sakila.customer AS c
JOIN sakila.address AS a
ON c.address_id=a.address_id
WHERE a.city_id IN (
    SELECT ci.city_id
    FROM sakila.city AS ci
    JOIN sakila.country AS co ON co.country_id = ci.country_id
    WHERE co.country = 'Canada');
    
    #6.Determine which films were starred by the most prolific actor in the Sakila database. 
    #A prolific actor is defined as the actor who has acted in the most number of films. 
    #First, you will need to find the most prolific actor and then use that actor_id to find 
    #the different films that he or she starred in.
   
SELECT f.title
FROM sakila.film AS f
JOIN sakila.film_actor AS fa 
ON f.film_id = fa.film_id
WHERE fa.actor_id = (
    SELECT a.actor_id
    FROM sakila.actor AS a
    JOIN sakila.film_actor AS fa 
    ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id
    ORDER BY COUNT(fa.film_id) DESC
    LIMIT 1);
    
#7.Find the films rented by the most profitable customer in the Sakila database. 
#You can use the customer and payment tables to find the most profitable customer, i.e., 
#the customer who has made the largest sum of payments.

SELECT f.title
FROM sakila.film AS f
JOIN sakila.inventory AS i
ON f.film_id = i.film_id
JOIN sakila.rental AS r
ON r.inventory_id = i.inventory_id
WHERE r.customer_id = (
    SELECT p.customer_id
    FROM sakila.payment AS p
    GROUP BY p.customer_id
    ORDER BY SUM(p.amount) DESC
    LIMIT 1);
    
 #8 Retrieve the client_id and the total_amount_spent of those clients who spent more than 
 #the average of the total_amount spent by each client. You can use subqueries to accomplish this.   
 SELECT p.customer_id, SUM(p.amount) AS total_amount_spent
 FROM sakila.payment AS p
 GROUP BY p.customer_id
 HAVING SUM(p.amount)>(
		SELECT AVG(total_amount_spent)
        FROM(
			SELECT SUM(p.amount) AS total_amount_spent
            FROM sakila.payment AS p
            GROUP BY p.customer_id) AS total_avg);
 



