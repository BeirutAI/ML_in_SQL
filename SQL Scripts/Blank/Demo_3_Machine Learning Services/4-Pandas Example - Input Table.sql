--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--Execute Python SQl Script from input data and return output
--drop database if exists SQLAI
use master
go

Create DataBase SQLAI

go

use SQLAI

go
--Create Sales table
drop table if exists sales

CREATE TABLE Sales(
	Year INT NOT NULL,
	Quarter VARCHAR(10) NOT NULL,
	Client VARCHAR(10) NOT NULL,
	Revenue INT NOT NULL
)

--Insert records into the table
INSERT INTO Sales(Year, Quarter, Client, Revenue) VALUES (2014, 'Q1', 'Wallmart', 1000)
INSERT INTO Sales(Year, Quarter, Client, Revenue) VALUES (2014, 'Q2', 'Wallmart', 560)
INSERT INTO Sales(Year, Quarter, Client, Revenue) VALUES (2014, 'Q3', 'Wallmart', 2341)
INSERT INTO Sales(Year, Quarter, Client, Revenue) VALUES (2014, 'Q4', 'Wallmart', 4000)

INSERT INTO Sales(Year, Quarter, Client, Revenue) VALUES (2015, 'Q1', 'Wallmart', 654)
INSERT INTO Sales(Year, Quarter, Client, Revenue) VALUES (2015, 'Q2', 'Wallmart', 4555)
INSERT INTO Sales(Year, Quarter, Client, Revenue) VALUES (2015, 'Q3', 'Wallmart', 8760)
INSERT INTO Sales(Year, Quarter, Client, Revenue) VALUES (2015, 'Q4', 'Wallmart', 1233)

INSERT INTO Sales(Year, Quarter, Client, Revenue) VALUES (2014, 'Q1', 'Fox', 6593)
INSERT INTO Sales(Year, Quarter, Client, Revenue) VALUES (2014, 'Q2', 'Fox', 4332)
INSERT INTO Sales(Year, Quarter, Client, Revenue) VALUES (2014, 'Q3', 'Fox', 123)
INSERT INTO Sales(Year, Quarter, Client, Revenue) VALUES (2014, 'Q4', 'Fox', 6504)

INSERT INTO Sales(Year, Quarter, Client, Revenue) VALUES (2015, 'Q1', 'Fox', 34333)
INSERT INTO Sales(Year, Quarter, Client, Revenue) VALUES (2015, 'Q2', 'Fox', 431)
INSERT INTO Sales(Year, Quarter, Client, Revenue) VALUES (2015, 'Q3', 'Fox', 6665)
INSERT INTO Sales(Year, Quarter, Client, Revenue) VALUES (2015, 'Q4', 'Fox', 4443)

SELECT * FROM Sales
SELECT top 0 percent * FROM Sales -- get just rows

SELECT *
FROM (
	SELECT 
		Year, 
		ISNULL(Quarter, 'total') as Quarter, 
		Client, 
		Sum(Revenue) as Revenue
	FROM Sales
	GROUP BY Year, Quarter, Client
	WITH CUBE
	HAVING 
	(Year IS NOT NULL AND Client IS NOT NULL)
) 
x
PIVOT(SUM(Revenue) FOR Quarter in (Q1, Q2, Q3, Q4, total)) AS P
ORDER BY Year


--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

Declare @PythonScript nvarchar(max)
Set @PythonScript =N'
import pandas as pd

table = pd.crosstab(
    [data.Year, data.Client], # group by in rows
    data.Quarter, # group by in columns
    values = data.Revenue, # values to aggregate
    aggfunc= sum,
    margins= True
)

table.reset_index(inplace=True)

output = table
	'


EXECUTE sp_execute_external_script
    @language = N'Python'
    , @script = @PythonScript
    , @input_data_1 = N'SELECT CONVERT(VARCHAR, Year) AS Year, Quarter, Client, Revenue FROM Sales;'
	, @input_data_1_name = N'data'
	, @output_data_1_name = N'output'
WITH RESULT SETS ((
	Year NVARCHAR(10),
	Client NVARCHAR(10),
	Q1 INT,
	Q2 INT,
	Q3 INT,
	Q4 INT,
	Total INT
));

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
Print('Now how to save the output result to table')
--I Can save the scripts for later use 
drop table if exists Scripts

CREATE TABLE Scripts(
	Id int,
	Scripts nvarchar(max)
)


Declare @PythonScript nvarchar(max)
Set @PythonScript =N'
import pandas as pd

table = pd.crosstab(
    [data.Year, data.Client], # group by in rows
    data.Quarter, # group by in columns
    values = data.Revenue, # values to aggregate
    aggfunc= sum,
    margins= True
)

table.reset_index(inplace=True)

output = table
	'

insert into Scripts (Id,Scripts) values(1,@PythonScript)

Drop table if exists  Sales_Output 

CREATE TABLE Sales_Output(
	Year varchar(50),
	Client VARCHAR(50),
	Q1 INT,
	Q2 INT,
	Q3 INT,
	Q4 INT,
	Total INT

)

Declare @PythonScripts nvarchar(max)
Select @PythonScripts= Scripts From Scripts where ID=1

insert into Sales_Output
--INSERT INTO #Data  
EXECUTE sp_execute_external_script
    @language = N'Python'
    , @script = @PythonScripts
    , @input_data_1 = N'SELECT CONVERT(VARCHAR, Year) AS Year, Quarter, Client, Revenue FROM Sales;'
	, @input_data_1_name = N'data'
	, @output_data_1_name = N'output'

Select * From Sales_Output
