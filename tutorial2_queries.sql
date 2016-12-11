/*queries*/

/*UNIQUE = distinct*/
/*REGEX 'ab.d' = like 'ab_d' (wildcard character)*/
/*REGEX 'a(.)*' = like 'a%' (0 or more characters after)*/
/*REGEX '(.)*a(.)*' = like '%a%'*/
/*RANGE BETWEEN = between ... and ...*/
/*SHOW IN ORDER = select ... order by desc (desc = descending order, ascending by default; asc = explicitly specify ascending order)*/
/*LIMIT = limit # (asc --> show lowest few; desc --> show highest few)*/

select name, imdb_rating from movies;

/*show all UNIQUE values*/
select distinct genre from movies;

/*show all entries that fall under a condition*/
select * from movies
where imdb_rating > 8;

/*show all entries that have names LIKE 'Se' + some character + 'en'*/
select * from movies 
where name like 'Se_en';

/*show all entries that have names LIKE 'a' + character(s) after*/
select * from movies 
where name like 'a%';

/*show all entries that have names LIKE character(s) before + 'man' + character(s) after*/
select * from movies 
where name like '%man%';

/*show all entries that have names alphabetically between A and J (note: case matters)*/
select * from movies 
where name between 'A' and 'J';

/*show all entries that have values in a RANGE*/
select * from movies 
where year between 1990 and 2000;

/*add an extra condition to the previous command*/
select * from movies 
where year between 1990 and 2000 
and genre = 'comedy';

/*use a different extra condition (with "or")*/
select * from movies 
where genre = 'comedy' 
or year < 1980;

/*show data in ORDER (with descending order specified)*/
select * from movies 
order by imdb_rating desc;

/*show LIMITED TO (because ascending) lowest 3 results in order (with ascending order explicitly specified)*/
select * from movies 
order by imdb_rating asc 
limit 3;