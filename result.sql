use sakila;

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT 
	SUM(inventory_id) AS total_movies,
    film.title
    from inventory
    JOIN film ON inventory.film_id = film.film_id
    WHERE film.title = 'Hunchback Impossible'
    GROUP BY film.title;
    
    
-- List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length from film WHERE length > (SELECT AVG(film.length) from film);


-- Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT * from film_actor WHERE film_id = (SELECT film_id from film where title = "Alone Trip");