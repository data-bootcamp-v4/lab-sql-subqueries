USE sakila;

# 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT count(film_id)
FROM inventory
WHERE film_id IN (SELECT film_id
					FROM film
                    where title = "Hunchback Impossible");

# 2. List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, round(avg(length),0)
FROM film
WHERE length > (SELECT avg(length)
				FROM film)
GROUP BY title
ORDER BY round(avg(length),0) asc;

# 3. Use a subquery to display all actors who appear in the film "Alone Trip".
select first_name, last_name
from actor
where actor_id IN (select actor_ID
					from film_actor
                    where film_ID IN (select film_ID
										from film
                                        where title = "Alone Trip" ));
  