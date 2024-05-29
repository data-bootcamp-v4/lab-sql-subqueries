#2. List all films whose length is longer than the average length of all the films in the Sakila database.

USE sakila;

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);
