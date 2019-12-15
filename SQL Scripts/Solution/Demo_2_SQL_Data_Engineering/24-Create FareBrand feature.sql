--Very Good references
--https://docs.microsoft.com/en-us/sql/t-sql/functions/percent-rank-transact-sql?view=sql-server-2017
--https://docs.microsoft.com/en-us/sql/t-sql/functions/ntile-transact-sql?view=sql-server-2017
--https://www.sqlshack.com/data-science-sql-server-data-analysis-transformation-binning-a-continuous-variable/

--The below divide the rows in an ordered partition into a specified number of groups
--The groups are numbered, starting at one. For each row, NTILE returns the number of the group to which the row belongs.



;With Data
as
(
Select 
		Fare,
		NTILE(4) OVER(ORDER BY Fare asc)  AS Quartile 

From [Wrangle].[train]
)

Select 
	Min(Fare) as Fare_Min,
	Max(Fare) as Fare_max,
	Quartile
From Data
Group by Quartile

go

--alter table Wrangle.train drop column FareBand int
--alter table Wrangle.test drop column FareBand int

--alter table Wrangle.train add FareBand int
--alter table Wrangle.test add FareBand int
--select * into Wrangle.Train_Test from Wrangle.Train
/*
select * into Wrangle.Train from Wrangle.Train_Test
drop table Wrangle.Train
*/
go

Update T
Set T.Fare = Case 
		when Fare >= 0 and Fare <= 7.8958 then '0'
		when Fare > 7.8958 and Fare < 14.4542 then '1'
		when Fare >= 14.4542 and Fare <= 31 then '2'
		else '3' End
From Wrangle.Train T

 
go

Update T
Set T.Fare = Case 
		when Fare >= 0 and Fare <= 7.8958 then '0'
		when Fare > 7.8958 and Fare < 14.4542 then '1'
		when Fare >= 14.4542 and Fare <= 31 then '2'
		else '3' End
From Wrangle.Test T

go

Select 
	top 5 * 
From Wrangle.Train


