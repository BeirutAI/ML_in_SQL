--Let's explore some aggregate functions

--Check Average of age
Select Avg(age) as avg_age
From train

--Check minimum and maximum of age
Select 
	 min(age) as min_age
	,max(age) as max_age
From train

--Check total rows of the table
Select 
	count(*) as Nb_Count 
From train


--Check distinct value of 'Sex' column
Select 
	Distinct  Sex
From train

--Check distinct count of column
Select 
	COUNT (DISTINCT Sex) as Count_Distinct 
From train


