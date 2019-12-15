-------------------------------------------------------------------------------
/*
More accurate way of guessing missing values is to use other correlated features. 
In our case we note correlation among Age, Gender, and Pclass. Guess Age values using 
median values for Age across sets of Pclass and Gender feature combinations. 
So, median Age for Pclass=1 and Gender=0, Pclass=1 and Gender=1, and so on...
*/


Select * from Wrangle.vwTrainTest
where PassengerId = 6

Drop table if exists #Age_Mean

--Create a new temp table as Age_Mean
Select 
	
	Sex,
	Pclass,
	AVG(age) as Mean
	--into #Age_Mean
	From Wrangle.vwTrainTest
	where age is not null
group by Sex,Pclass
order by sex

Update T
Set T.Age = cast(AM.Mean as int)
From Wrangle.train T
inner join #Age_Mean AM
--Join on Sex and PClass
on AM._____= T._____ and AM._____ = T._____
where T.Age is null

Update T
Set T.Age = cast(AM.Mean as int)
From [Wrangle].Test T
inner join #Age_Mean AM
on AM.Sex= T.Sex and AM.PClass = T.Pclass
where T.Age is null

Select * from Wrangle.vwTrainTest
where PassengerId = 6