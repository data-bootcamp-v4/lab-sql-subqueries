-- 1.Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

#COUNT(film_id) igual al film id de hunchback impossible return a table with the name of the film and the count(film_id)
# as number of copies.

SELECT 
	f.title,
    (SELECT COUNT(i.film_id) 
     FROM inventory i
     WHERE i.film_id=f.film_id) AS number_copies
FROM film f
WHERE title='Hunchback Impossible';

-- 2.List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT
title,
length
FROM film 
WHERE length>(SELECT AVG(length) FROM film);

-- 3.Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT 
	first_name,
    last_name
FROM actor
WHERE actor_id IN (
	SELECT actor_id
    FROM film_actor
    WHERE film_id= (SELECT film_id
					FROM film
                    WHERE title='Alone Trip')
				  );
                  
-- 4.Sales have been lagging among young families, and you want to target family movies for a promotion. 
--   Identify all movies categorized as family films.

SELECT * FROM category;


SELECT title 
FROM film
WHERE film_id IN (SELECT film_id
			      FROM film_category
				  WHERE category_id=(SELECT category_id
								     FROM category
                                     WHERE name LIKE '%Children%')
			     );


















