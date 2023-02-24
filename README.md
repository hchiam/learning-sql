# Learning SQL

Just one of the things I'm learning. https://github.com/hchiam/learning

## Older tutorials

- http://tutorialzine.com/2016/01/learn-sql-in-20-minutes
- https://www.codecademy.com/courses/learn-sql
- https://github.com/hchiam/learning-sql/tree/master/youtube-tutorial

## Node.js MySQL tutorial

- https://github.com/hchiam/learning-sql/tree/master/node-mysql

## Miscellaneous notes

UDF (user-defined function): https://cloud.google.com/bigquery/docs/reference/standard-sql/user-defined-functions:

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
