/*you can calculate things using SQL*/

/*COUNT = count(*)*/
/*GROUP BY = group by ...*/
    /*FOR EXAMPLE: select column1, count(*) from table1 group by column1;*/
/*SUM = sum(columnName)*/
/*MAX = max(columnName)*/
/*MIN = min(columnName)*/
/*AVERAGE = avg(columnName)*/
/*ROUND TO n DIGITS= round(number, n)*/
/*ROUND TO INTEGER= round(number)*/

select * from fake_apps;

/*COUNT how many entries there are*/
select count(*) from fake_apps;

/*COUNT how many entries there are, but only those that fall under a condition*/
select count(*) from fake_apps 
where price = 0;

/*show entries in column, and counts of each type of entry (based on GROUPs in a column)*/
select price, count(*) from fake_apps 
group by price;

/*...now add a condition:*/
select price, count(*) from fake_apps 
where downloads > 20000 
group by price;

/*sum up the numbers in a column*/
select sum(downloads) from fake_apps;

/*get MAX in a column*/
select max(downloads) from fake_apps;

/*get max in a column, as well as values for other corresponding columns*/
select name, category, max(downloads) from fake_apps 
group by category;

/*get MIN in a column*/
select min(downloads) from fake_apps;

/*get min in a column, as well as values for other corresponding columns*/
select name, category, min(downloads) from fake_apps 
group by category;

/*get AVERAGE in a column*/
select avg(downloads) from fake_apps;

/*get average in a column, as well as values for other corresponding column*/
select price, avg(downloads) from fake_apps 
group by price;

/*get average in a column (ROUNDed to 2 digits), as well as values for other corresponding column*/
select price, round(avg(downloads), 2) from fake_apps 
group by price;

/*get average in a column (ROUNDed to INTEGER), as well as values for other corresponding column*/
select price, round(avg(downloads)) from fake_apps 
group by price;