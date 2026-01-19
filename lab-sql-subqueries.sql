#Challenge
USE sakila;
# Write SQL queries to perform the following tasks using the Sakila database:

    # 1- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
			SELECT COUNT(*) AS number_of_copies
			FROM inventory
			WHERE film_id = (
				SELECT film_id
				FROM film
				WHERE title = 'Hunchback Impossible'
			);

    # 2- List all films whose length is longer than the average length of all the films in the Sakila database.
			SELECT title, length
			FROM film
			WHERE length > (
				SELECT AVG(length)
				FROM film
			);

    # 3- Use a subquery to display all actors who appear in the film "Alone Trip".
			SELECT first_name, last_name
			FROM actor
			WHERE actor_id IN (
				SELECT actor_id
				FROM film_actor
				WHERE film_id = (
					SELECT film_id
					FROM film
					WHERE title = 'Alone Trip'
				)
			);
            
# 6. Determine which films were starred by the most prolific actor in the Sakila database. 
-- A prolific actor is defined as the actor who has acted in the most number of films. 
-- film - actor - film_actor // select films + which actor played in most movies 
SELECT film_id, title 
FROM film
WHERE film_id IN (
				SELECT film_id 
                FROM film_actor
                WHERE actor_id =  (
					SELECT actor_id 
                    FROM film_actor
                    GROUP BY actor_id
                    ORDER BY COUNT(film_id) DESC
                    LIMIT 1
					)
);
            
            

