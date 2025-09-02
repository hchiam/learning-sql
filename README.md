# Learning SQL

Just one of the things I'm learning. https://github.com/hchiam/learning

## Older tutorials

- http://tutorialzine.com/2016/01/learn-sql-in-20-minutes
- https://www.codecademy.com/courses/learn-sql
- https://github.com/hchiam/learning-sql/tree/master/youtube-tutorial

## Node.js MySQL tutorial

- https://github.com/hchiam/learning-sql/tree/master/node-mysql

## Miscellaneous notes

Here's an alternative diagram to using venn diagrams to understand SQL joins: https://www.reddit.com/r/SQL/comments/1bv88ht/please_use_these_instead_of_those_abominable_venn/

UDF (user-defined function):

- https://cloud.google.com/bigquery/docs/reference/standard-sql/user-defined-functions:

temporary UDF:

```sql
CREATE TEMP FUNCTION AddFourAndDivideTemporary(x INT64, y INT64)
RETURNS FLOAT64
AS (
  (x + 4) / y
);

SELECT
  val, AddFourAndDivideTemporary(val, 2)
FROM
  UNNEST([2,3,5,8]) AS val;
```

persistent UDF: (requires a dataset like "`mydataset.`" specified for the function)

```sql
CREATE FUNCTION mydataset.AddFourAndDividePersistent(x INT64, y INT64)
RETURNS FLOAT64
AS (
  (x + 4) / y
);

SELECT
  val, mydataset.AddFourAndDividePersistent(val, 2)
FROM
  UNNEST([2,3,5,8,12]) AS val;
```

https://dba.stackexchange.com/questions/283022/what-does-the-go-statement-do-in-sql-server
- `GO` = end of scope = came from telling CLI that it can now send the server the batch of multiline SQL code
- `;` separates lines in a batch and does not separate scope

https://www.w3schools.com/sql/sql_delete.asp
- ```sql
  DELETE FROM table_name WHERE condition; --OK
  ```
- ```sql
  DELETE FROM table_name; --likely BAD: will delete entire table
  ```

https://www.youtube.com/watch?v=3JW732GrMdg
- PostgreSQL technically can do a lot

Web Dev Simplified
- https://www.youtube.com/watch?v=p3qvj9hO_Bo
```sql
CREATE DATABASE record_company;
USE record_company; --to run commands on this database
CREATE TABLE bands (
  id INT NOT NULL AUTO_INCREMENT, --AUTO_INCREMENT = don't have to do anything when adding a row
  name VARCHAR(255) NOT NULL, --VARCHAR = variable length string with max length (#), and NOT NULL = always required to be filled
  PRIMARY KEY (id) --to tell SQL which column is the primary key (unique "identifier"/"index") of each row
);
CREATE TABLE albums (
  id INT NOT NULL AUTO_INCREMEMNT,
  name VARCHAR(255) NOT NULL, --again, NOT NULL, because we never want this column/value to be empty
  release_year INT, --this can be empty/null because we may not always have this info = optional
  band_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (band_id) REFERENCES bands(id) --band_id references the bands TABLE's id PRIMARY KEY
);

INSERT INTO bands(name) --id is auto-incremented
VALUES ('Iron Maiden');

INSERT INTO bands(name)
VALUES ('Deuce'), ('Avenged Sevenfold'), ('Ankor'); --batched inserted rows

SELECT * FROM bands;

SELECT * FROM bands LIMIT 2; --get the first two rows

SELECT name FROM bands;

--here's how you can alias column names: (you can also alias table names - see later below)
SELECT id AS 'ID', --rename column with an 'alias', e.g. might be useful to rename to what name(s) an API expects
  name AS 'Band Name'
FROM bands;

SELECT * FROM bands ORDER BY name; --ASC (ascending) is the default, you have to specify DESC (descending)

SELECT * FROM bands ORDER BY name DESC;

INSERT INTO albums (name, release_year, band_id)
VALUES ('The Number of the Beast', 1985, 1),
  ('Power Slave', 1984, 1),
  ('Nightmare', 2018, 2),
  ('Nightmare', 2010, 3),
  ('Test Album', NULL, 3);

SELECT * FROM albums;

SELECT DISTINCT name FROM albums; --DISTINCT to de-dupe values like names in this case

UPDATE albums
SET release_year = 1982
WHERE id = 1; --you can add a WHERE filter to almost any SQL statement

SELECT * FROM albums
WHERE release_year < 2000;

SELECT * FROM albums
WHERE release_year BETWEEN 2000 AND 2018;

SELECT * FROM albums
WHERE name LIKE '%er%' --'%' can mean any symbol or even empty, so SQL wildcards in '%er%' work like JS regex /.*er.*/
  OR band_id = 2;

SELECT * FROM albums
WHERE release_year IS NULL;

--DELETE FROM albums; --WARNING: THIS WILL DELETE THE ENTIRE TABLE!!!

DELETE FROM albums
WHERE id = 5;
--SELECT * FROM albums;

SELECT * FROM bands
JOIN albums ON bands.id = albums.band_id;
--INNER JOIN is the default for JOIN (in MySQL), and only returns matches between both tables - which seems like a reasonable default to make easier to type
  --you'll most likely use JOIN (aka INNER JOIN)
--LEFT JOIN will get bands (on the left side of the "JOIN" keyword) with no corresponding albums
  --you'll more likely use LEFT JOIN than RIGHT JOIN
--RIGHT JOIN will get albums (on the right side of the "JOIN" keyword) with no corresponding bands
  --this is the same as LEFT JOIN but flipped, and so it might be harder to reason about

--the following two queries output the same data, but with different orders of table columns:
SELECT * FROM bands
LEFT JOIN albums ON bands.id = albums.band_id;
--id name              id name                   release_year band_id
--1  Iron Maiden       1 The Number of the Beast 1982         1
--1  Iron Maiden       2 Power Slave             1984         1
--2  Deuce             3 Nightmare               2018         2
--3  Avenged Sevenfold 4 Nightmare               2010         3
--4  Ankor

--and if you swap from LEFT to RIGHT and move bands to the right side of the RIGHT too,
--you get the first two columns for bands moved to the right of the table:

SELECT * FROM albums
RIGHT JOIN bands ON bands.id = albums.band_id;
--id name                    release_year band_id id name
--1  The Number of the Beast 1982         1       1  Iron Maiden
--2  Power Slave             1984         1       1  Iron Maiden
--3  Nightmare               2018         2       2  Deuce
--4  Nightmare               2010         3       3  Avenged Sevenfold
--                                                4  Ankor

SELECT AVG(release_year) FROM albums; --average is an example aggregate function that returns one value (technically one row with one column)
--unless you use GROUP BY to scope the AVG to groups of rows instead of to all rows in the whole table

--to get how many albums each band has, we canNOT just do this:
SELECT band_id, COUNT(band_id) FROM albums;

--we have to instead do this:

SELECT band_id, COUNT(band_id) FROM albums --to get how many albums each band has
GROUP BY band_id; --GROUP BY will "squish together" rows with same band_id, and then COUNT will count over those "squished together" rows
--i.e., GROUP BY will "create" rows each with a unique band_id before COUNT is applied

--AND NOW COMBINING A LOT OF THE ABOVE KNOWLEDGE TOGETHER IN THE NEXT FEW QUERIES:

--and now we can build on the above query to show more useful info: return band_name instead of band_id:
SELECT b.name AS band_name, COUNT(a.id) AS num_albums --get the final data we want with names that are self-documenting (and useful for an API)
FROM bands AS b --LEFT JOIN because we still want to show bands with no albums
LEFT JOIN albums AS a ON b.id = a.band_id
GROUP BY b.id; --group by unique band id for COUNT to work properly within bands and not over the whole table
--the above example shows you how to alias both column names and table names.
--i think i prefer reading/writing starting from FROM and JOIN where the aliases are, so that i can understand the SELECT line that uses the aliases
--mnemonic: "start from FROM"

--AND WHAT IF WE WANT THAT QUERY TO ALSO FILTER ON THE AGGREGATE FUNCTIONS?

--WHERE won't work because WHERE is evaluated before GROUP BY which is evaluated before aggregate functions like COUNT:
SELECT b.name AS band_name, COUNT(a.id) AS num_albums
FROM bands AS b
LEFT JOIN albums AS a ON b.id = a.band_id
WHERE num_albums = 1 --adding this here won't work! why? WHERE is evaluated before GROUP BY
GROUP BY b.id;

--"order of operations": WHERE -> GROUP BY -> SELECT (and its aggregate functions) -> HAVING
--https://stackoverflow.com/questions/2905292/where-vs-having
--prepending EXPLAIN to queries can show "Extra data" says both use index, but "rows" says different numbers of rows

--so instead use HAVING, which is WHERE but can be used on aggregate function data:
SELECT b.name AS band_name, COUNT(a.id) AS num_albums
FROM bands AS b
LEFT JOIN albums AS a ON b.id = a.band_id
--WHERE num_albums = 1 --adding this here won't work! why? WHERE is evaluated before GROUP BY
GROUP BY b.id
HAVING num_albums = 1;

--and you can still use both WHERE and HAVING, with WHERE restricted to not using the aggregate function data:
SELECT b.name AS band_name, COUNT(a.id) AS num_albums
FROM bands AS b
LEFT JOIN albums AS a ON b.id = a.band_id
WHERE b.name = 'Deuce'
GROUP BY b.id
HAVING num_albums = 1;
```

practice: https://github.com/WebDevSimplified/Learn-SQL (has solutions) (or [my backup repo of the exercises](https://github.com/hchiam/Learn-SQL-exercises-WDS))
- for example, to get the number of songs for each band, given bands, albums, and songs:
- ```sql
  --using my mnemonic from earlier: "start from FROM",
  --you think: bands -> albums -> songs -> group by band_id -> select band name and number of songs:
  SELECT
    bands.name AS 'Band',
    COUNT(songs.id) AS 'Number of Songs'
  FROM bands
  JOIN albums ON bands.id = albums.band_id
  JOIN songs ON albums.id = songs.album_id
  GROUP BY albums.band_id;
  ```

https://stackoverflow.com/questions/2905292/where-vs-having
- combining SO and WDS info: `WHERE` -> `GROUP BY` -> `SELECT` (and aggregate function data like from `AVG()` or `COUNT()`) -> `HAVING`
- you can use `EXPLAIN` to get data on queries:
- ```sql
  --note how the "Extra" info for both says "Using index", but "rows" show 5 vs 10:
  
  EXPLAIN SELECT `value` v FROM `table` WHERE `value`>5;
  +----+-------------+-------+-------+---------------+-------+---------+------+------+--------------------------+
  | id | select_type | table | type  | possible_keys | key   | key_len | ref  | rows | Extra                    |
  +----+-------------+-------+-------+---------------+-------+---------+------+------+--------------------------+
  |  1 | SIMPLE      | table | range | value         | value | 4       | NULL |    5 | Using where; Using index |
  +----+-------------+-------+-------+---------------+-------+---------+------+------+--------------------------+
  
  EXPLAIN SELECT `value` v FROM `table` having `value`>5;
  +----+-------------+-------+-------+---------------+-------+---------+------+------+-------------+
  | id | select_type | table | type  | possible_keys | key   | key_len | ref  | rows | Extra       |
  +----+-------------+-------+-------+---------------+-------+---------+------+------+-------------+
  |  1 | SIMPLE      | table | index | NULL          | value | 4       | NULL |   10 | Using index |
  +----+-------------+-------+-------+---------------+-------+---------+------+------+-------------+
  ```
