/*CREATE = create*/
/*ADD = insert*/
/*SHOW = select*/
/*UPDATE = update*/
/*ALTER = alter (like adding a column)*/
/*DELETE = delete*/

/*CREATE empty table*/
create table celebs (id integer, name text, age integer);

/*ADD one entry that fills these columns*/
insert into celebs (id, name, age) values (1, 'Justin Bieber', 21);

/*SHOW everything in table*/
select * from celebs;

/*add other entries*/
insert into celebs (id, name, age) values (2, 'Beyonce Knowles', 33);
insert into celebs (id, name, age) values (3, 'Jeremy Lin', 26);
insert into celebs (id, name, age) values (4, 'Taylor Swift', 26);

/*show all entries under this column in this table*/
select name from celebs;

/*UPDATE table by setting a value based on a condition*/
update celebs 
set age = 22 
where id = 1;

/*show everything in table*/
select * from celebs;

/*ALTER table by adding new column to table*/
alter table celebs add column twitter_handle text;

/*show everything in table*/
select * from celebs;

/*update table by setting a value based on a condition*/
update celebs 
set twitter_handle = '@taylorswift13' 
where id = 4;

/*DELETE all from table that fall under a condition*/
delete from celebs where twitter_handle is null;

/*show everything in table*/
select * from celebs;