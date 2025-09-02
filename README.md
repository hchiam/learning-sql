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

Web Dev Simplified https://www.youtube.com/watch?v=p3qvj9hO_Bo
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
```
