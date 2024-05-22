-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system. 
SELECT film.title, num_copies.Number_of_Copies
    FROM (SELECT film_id , COUNT(inventory_id) as "Number_of_Copies" 
     FROM inventory 
     WHERE film_id = (SELECT film_id 
                      FROM film 
                      WHERE title = 'Hunchback Impossible'
                      )
					
	GROUP BY film_id
    ) num_copies
    JOIN film ON num_copies.film_id = film.film_id;
    
-- 2. List all films whose length is longer than the average length of all the films in the Sakila database. 
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) as Average FROM film);
	
-- 3. Use a subquery to display all actors who appear in the film "Alone Trip". 
SELECT actor_id, concat_ws(' ', first_name, last_name) as full_name  
FROM actor 
WHERE actor_id IN
	(SELECT actor_id FROM film_actor 
		WHERE film_id = 
        (SELECT film_id 
         FROM film 
		 WHERE title = "Alone Trip"
         )
	)
GROUP BY actor_id
ORDER BY full_name ASC;
-- 4 Bonus Identify all movies categorized as family films. 
SELECT film.title as movie_name 
FROM film
WHERE film.film_id IN
	(SELECT film_id FROM film_category fc
		WHERE fc.category_id = 
        (SELECT category_id 
         FROM category 
		 WHERE name = "Family"
		)
	)
ORDER BY movie_name ASC;