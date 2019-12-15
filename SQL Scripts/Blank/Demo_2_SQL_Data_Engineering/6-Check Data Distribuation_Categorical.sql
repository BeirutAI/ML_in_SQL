-------------------------------------------------------------------------------
--Drop table if exists '[Statistics].Data_describe_Categorical
drop table  if exists _______

--Combine all queries in one table using ';with [Alias] as ('
_______
_______
_______

Select Distinct
	 'count' as ColumnName
	,(Select cast(Count(Sex) as varchar(50)) from train ) as Sex
	,(Select cast(Count(Ticket) as varchar(50)) from train ) as Ticket
	,(Select cast(Count(Cabin) as varchar(50)) from train ) as Cabin
	,(Select cast(Count(Embarked) as varchar(50)) from train ) as Embarked
			  
	From train

_______

Select Distinct
	 'unique' as ColumnName
	,(Select cast(Count(distinct Sex)as varchar(50)) from train ) as Sex
	,(Select cast(Count(distinct Ticket)as varchar(50)) from train ) as Ticket
	,(Select cast(Count(distinct Cabin)as varchar(50)) from train ) as Cabin
	,(Select cast(Count(distinct Embarked)as varchar(50)) from train ) as Embarked

	From train

_______ 

Select Distinct
	 'top' as ColumnName
	,(Select top 1  Sex		 from train	where Sex is not null	group by Sex  order by count(*) desc) as Sex
	,(Select top 1  Ticket   from train where Ticket is not null group by Ticket  order by count(*) desc) as Ticket
	,(Select top 1  Cabin    from train where Cabin is not null  group by Cabin  order by count(*) desc) as Cabin
	,(Select top 1  Embarked from train where Embarked is not null group by Embarked  order by count(*) desc) as Embarked

	From train

_______

Select 
	'freq' as ColumnName
	,(Select distinct  cast(MAX(count(Sex))		 OVER () as varchar(50))  From train group by Sex) as 'Sex'
	,(Select distinct  cast(MAX(count(Ticket))	 OVER () as varchar(50))  From train group by Ticket) as 'Ticket'
	,(Select distinct  cast(MAX(count(Cabin))	 OVER () as varchar(50))  From train group by Cabin) as 'Cabin'
	,(Select distinct  cast(MAX(count(Embarked)) OVER () as varchar(50))  From train group by Cabin) as 'Embarked'

_______

--Insert the result into a new table [Statistics].Data_Describe_Categorical
__________________


--Explore table [Statistics].Data_Describe_Categorical
Select * From [Statistics].Data_Describe_Categorical

