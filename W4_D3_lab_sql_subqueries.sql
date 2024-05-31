# 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system
SELECT COUNT(inventory_id) 
FROM inventory 
WHERE film_id = (SELECT film_id 
			FROM film
            WHERE title = "HUNCHBACK IMPOSSIBLE");

# 2. List all films whose length is longer than the average length of all the films in the Sakila database
SELECT title, length
FROM film
WHERE LENGTH > (SELECT AVG(LENGTH) AS avg_length
				FROM film);

# 3. Use a subquery to display all actors who appear in the film "Alone Trip"
SELECT *
FROM actor 
WHERE actor_id IN (SELECT actor_id
				FROM film_actor
				WHERE film_id IN (SELECT film_id
								FROM film 
								WHERE title = "ALONE TRIP"));

# BONUS 
# 5. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films
 SELECT *
 FROM film 
 WHERE film_id IN (SELECT film_id
				FROM film_category 
				WHERE category_id IN (SELECT category_id 
									FROM category 
                                    WHERE name = "FAMILY"));
                                    
# 6. Display the top 10 most frequently rented movies in descending order
#movie, inventory, rental 
SELECT *
FROM film 
WHERE film_id IN (SELECT film_id
				FROM inventory 
                WHERE inventory_id = (SELECT inventory_id 
									FROM inventory
                                    WHERE rental_id = (SELECT rental_id, COUNT(*) AS rental_count
													FROM rental
													GROUP BY rental_id
													ORDER BY rental_count DESC)));



# 7. Determine if "Academy Dinosaur" can be rented from Store 1



