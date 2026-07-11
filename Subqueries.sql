USE Sakila;
SHOW tables;

SELECT
    TABLE_NAME AS which_table_am_i_in,
    COLUMN_NAME AS my_column,
    REFERENCED_TABLE_NAME AS what_im_linked_to,
    REFERENCED_COLUMN_NAME AS its_column
FROM information_schema.KEY_COLUMN_USAGE
WHERE REFERENCED_TABLE_NAME IS NOT NULL
  AND TABLE_SCHEMA = 'Sakila';
  
-- ------------------------
-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(*) FROM inventory WHERE film_id = (SELECT film_id FROM film WHERE title = "Hunchback Impossible");
-- ----
SELECT film_id FROM film WHERE title = "Hunchback Impossible";
SELECT COUNT(*) FROM inventory WHERE film_id = 439;
-- ------------------------
-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length FROM film 
WHERE length > (SELECT AVG(length) FROM film);

-- ------------------------
-- Use a subquery to display all actors who appear in the film "Alone Trip". 
SELECT CONCAT(first_name, ' ', last_name) AS actor_name FROM actor
WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id IN (SELECT film_id FROM film WHERE title = "Alone Trip"));
-- ------------------------
/* Challenge
Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
List all films whose length is longer than the average length of all the films in the Sakila database.
Use a subquery to display all actors who appear in the film "Alone Trip". */
