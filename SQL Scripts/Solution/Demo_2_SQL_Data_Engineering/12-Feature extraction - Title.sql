--Add Title column
alter table Wrangle.train drop column if exists Title
alter table Wrangle.Test drop column if exists Title

alter table  Wrangle.train add Title varchar(50) null
alter table  Wrangle.test add Title varchar(50) null

go

--Extract Title from name using 'RegexMatch' function by passing the variables (Name and '([A-Za-z]+)\.')
Select 
		 dbo.RegexMatch([Name], '([A-Za-z]+)\.') as Title
		,Name
		From Wrangle.train

go

----------------------------------------------------
--Update Title by running the regular explression
Declare @regex_pattern varchar(max) = '([A-Za-z]+)\.'

Update Wrangle.Train Set Title =  replace(dbo.RegexMatch([Name], @regex_pattern),'.','')
Update Wrangle.Test  Set Title =  replace(dbo.RegexMatch([Name], @regex_pattern),'.','')

----------------------------------------
--Explorer title count grouped
Select
	 Title
	,Sex
	,Count(*) as TotalNb

From Wrangle.Train
Group by Title,Sex
order by Sex,TotalNb desc
go

----------------------------------------
--Replace common name with Rare
Select
	 Title
	,Count(*) as TotalNb

From Wrangle.Train
Group by Title
order by TotalNb desc


--# We can convert the categorical titles to ordinal.
UPDATE Wrangle.Train SET Title =
		CASE 
		WHEN Title = 'Mr' THEN '1'
		WHEN Title = 'Miss' THEN '2'
		WHEN Title = 'Mrs' THEN '3'
		WHEN Title = 'Master' THEN '4'
		WHEN Title = 'Rare' THEN '5'
		END;

UPDATE Wrangle.Test SET Title =
		CASE 
		WHEN Title = 'Mr' THEN '1'
		WHEN Title = 'Miss' THEN '2'
		WHEN Title = 'Mrs' THEN '3'
		WHEN Title = 'Master' THEN '4'
		WHEN Title = 'Rare' THEN '5'
		END;



--Now we can drop the column name after extracting the title
alter table Wrangle.Train drop column if exists [Name]

---Update Title , replace it with Rare 5 when empty
Update  Wrangle.train  Set Title = '5' Where Title is null
Update  Wrangle.train  Set Title = '5' Where Title is null
go

Select top 5 *
 
 From Wrangle.Train

