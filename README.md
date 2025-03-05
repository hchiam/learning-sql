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
