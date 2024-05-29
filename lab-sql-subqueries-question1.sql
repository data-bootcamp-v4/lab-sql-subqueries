#1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system

USE sakila;
SELECT COUNT(*) AS Number_of_Copies
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');