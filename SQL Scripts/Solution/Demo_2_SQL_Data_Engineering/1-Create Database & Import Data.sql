--First we need to create a database 'DataScience'
Create Database DataScience
go



--After we create the database we need to access it
Use DataScience

go

--The let's create a schema ('Statistics' & 'Wrangle') to organize the tables
Create Schema [Statistics]

go

Create Schema Wrangle

go

----
--Let's import manually the data

--Explore the columns of the table by running the below or simply click Alt+F1 by highlighting the table
SELECT Column_Name
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = N'train'


