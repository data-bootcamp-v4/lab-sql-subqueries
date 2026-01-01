-- 1

select  title, count(inventory_id) as n_of_copies
from sakila.inventory as i
join sakila.film as f on f.film_id = i.film_id
where title = 'Hunchback Impossible';

-- 2


select film_id, title, length
from sakila.film
where length > (select avg(length)
from sakila.film);

-- 3

select a.actor_id, concat( first_name , ' ', last_name) as full_name
from sakila.actor as a
join sakila.film_actor as fa on a.actor_id = fa.actor_id
join sakila.film as f on fa.film_id = f.film_id
where f.title = 'Alone Trip';

-- Bonus Identify all movies categorized as family films.

select f.title, ca.name as category
from sakila.film as f
join sakila.film_category as fc on fc.film_id = f.film_id
join sakila.category as ca on ca.category_id = fc.category_id
where ca.name = 'family';


SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS full_name, 
    c.email
FROM sakila.customer AS c
WHERE c.address_id IN (
    SELECT a.address_id
    FROM sakila.address AS a
    JOIN sakila.city AS ci ON a.city_id = ci.city_id
    JOIN sakila.country AS co ON ci.country_id = co.country_id
    WHERE co.country = 'Canada'
);


SELECT 
    f.title
FROM sakila.film AS f
JOIN sakila.film_actor AS fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (
    SELECT a.actor_id
    FROM sakila.actor AS a
    JOIN sakila.film_actor AS fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id
    ORDER BY COUNT(fa.film_id) DESC
    LIMIT 1
);

SELECT 
    p.customer_id
FROM sakila.payment AS p
GROUP BY p.customer_id
ORDER BY SUM(p.amount) DESC
LIMIT 1;

select f.title
from sakila.rental as r
join sakila.inventory as i on i.inventory_id = r.inventory_id
join sakila.film as f on f.film_id = i.film_id 
where r.customer_id = (
 SELECT 
    p.customer_id
 FROM sakila.payment AS p
 GROUP BY p.customer_id
 ORDER BY SUM(p.amount) DESC
 LIMIT 1;
 
 
 -- Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.

select avg(amount) as avg_tot_amount
from sakila.payment as p;

select c.customer_id, sum(amount) as tot_amount_spent
from sakila.customer as c
join sakila.payment as p on c.customer_id = p.customer_id
group by c.customer_id
having  tot_amount_spent > (
 select avg(amount) as avg_tot_amount
 from sakila.payment as p
 group by c.customer_id) ;
 
 -- or second way 
 SELECT 
    c.customer_id, 
    SUM(p.amount) AS tot_amount_spent
FROM sakila.customer AS c
JOIN sakila.payment AS p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
HAVING tot_amount_spent > (
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(amount) AS customer_total
        FROM sakila.payment
        GROUP BY customer_id
    ) AS customer_totals
);

