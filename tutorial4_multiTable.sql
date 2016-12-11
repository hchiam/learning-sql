/*you can query multiple tables that have relationships with each other*/

/*JOIN = select from table1 join table2 on table1.colName = table2.colName*/
/*LEFT JOIN = select from table1 LEFT join table2 on table1.colName = table2.colName*/
/*SHOW AS RENAMED COLUMNS = select ... as ...*/

/*(table named "albums" already created in tutorial)*/

/*create table*/
create table artists(id integer primary key, name text);

/*show all data from both tables*/
select * from albums;
select * from artists;

/*show (all) artist(s) with the (unique) id*/
select * from artists where id = 3;
/*show all albums for that artist*/
select * from albums where artist_id = 3;

/*show all data in these tables' columns for these tables*/
select albums.name, albums.year, artists.name from albums, artists;

/*HERE IS HOW YOU QUERY MULTIPLE TABLES AND PUT THE DATA IN ONE TABLE OUTPUT:*/
/*HERE IS HOW YOU QUERY MULTIPLE TABLES AND PUT THE DATA IN ONE TABLE OUTPUT:*/
/*HERE IS HOW YOU QUERY MULTIPLE TABLES AND PUT THE DATA IN ONE TABLE OUTPUT:*/

/*show JOINT data from the "albums" and "artists" tables WHERE the "album" is linked to the "artist"*/
select * 
from albums
join artists
on albums.artist_id = artists.id;

/*"left join" returns all rows from "left" table (table1), with matching rows from "right" table (table2) or NULL if no match in "right" table*/
select * 
from albums 
left join artists 
on albums.artist_id = artists.id;

/*RENAME COLUMNS to avoid confusion with two columns both originally named as "name"*/
SELECT
  albums.name AS 'Album',
  albums.year,
  artists.name AS 'Artist'
FROM
  albums
JOIN artists ON
  albums.artist_id = artists.id
WHERE
  albums.year > 1980;