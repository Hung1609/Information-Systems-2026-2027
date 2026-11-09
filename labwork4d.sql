/*
- List names of all the languages in the database (sorted alphabetically)?
- List full names of actors with “GER” in their last name, ordered by their first name
- Find all the addresses where postal code starts with “57”, and return addresses sorted.
- How many films involve a “DWARF” in their titles?
- Find full names of actors who played in a film involving ‘WAR’ in title and longer than 2.5 hours, along with the title, run length and release year of the movie, sorted by the actors’ last names.
- Find all the film categories in which there are between 55 and 65 films. Return the names of these categories and the number of films per category, sorted by the number of films descending.
- In how many film categories is the average dierence between the film replacement cost and the rental rate larger than 17?
- Find the address district(s) name(s) such that the minimal postal code in the district(s) is maximal over all the districts. Make sure your query ignores empty postal codes and district names.
- Find the names (first and last) of all the actors and customers whose first name is the same as the first name of the actor with ID 101 (exclude the actor with ID 101).
*/
use sakila;

-- 1.List names of all the languages in the database (sorted alphabetically)?
select name from language order by name;

-- 2.List full names of actors with “GER” in their last name, ordered by their first name
select concat(first_name, ' ', last_name) as full_name from actor where last_name like '%GER%' order by first_name;

-- 3.Find all the addresses where postal code starts with “57”, and return addresses sorted.
select address from address where postal_code like '57%' order by address;

-- 4.How many films involve a “DWARF” in their titles?
select count(title) from film where title like '%DWARF%';

-- 5.Find full names of actors who played in a film involving ‘WAR’ in title and longer than 2.5 hours, along with the title, run length and release year of the movie, sorted by the actors’ last names.
select concat(first_name, ' ', last_name) as full_name, title, release_year, length from actor join film_actor using (actor_id) join film using (film_id) where title like '%WAR%' and length > 150 order by last_name;

-- 6.Find all the film categories in which there are between 55 and 65 films. Return the names of these categories and the number of films per category, sorted by the number of films descending.
select count(film_id) as no_film, name from film_category join category using (category_id) group by (category_id) having no_film between 55 and 65 order by no_film desc;

-- 7.In how many film categories is the average dierence between the film replacement cost and the rental rate larger than 17?
create view Dierence as select replacement_cost - rental_rate as dierence, name, category_id from film join film_category using (film_id) join category using (category_id);
select count(category_id) from (select avg(dierence), category_id from Dierence group by (category_id) having avg(dierence) > 17) as qualified_category;

-- 8.Find the address district(s) name(s) such that the minimal postal code in the district(s) is maximal over all the districts. Make sure your query ignores empty postal codes and district names.
create view DistrictMinimalPostalCode as select min(postal_code) as minimal_postal_code, district from address where postal_code <> '' and district <> '' group by district;
select district, minimal_postal_code from DistrictMinimalPostalCode where minimal_postal_code = (select max(minimal_postal_code) from DistrictMinimalPostalCode); 

-- 9.Find the names (first and last) of all the actors and customers whose first name is the same as the first name of the actor with ID 101 (exclude the actor with ID 101).
select concat(first_name, ' ', last_name) as actor_full_name from actor where first_name = (select first_name from actor where actor_id = 101) and actor_id <> 101 union select concat(first_name, ' ', last_name) as customer_full_name from customer where first_name = (select first_name from actor where actor_id = 101);