/*
Embarked feature takes S, Q, C values based on port of embarkation. 
Our training dataset has two missing values. We simply fill these with the most common occurance.
*/

Select 
		Embarked,
		Count(*) as Total 
From Wrangle.[train]
group by Embarked
order by Total desc

--So we fill the empty with S

Update Wrangle.train set Embarked ='S' where Embarked is null


--Check correlation
Select	
	Embarked,
	AVG(CAST(Survived AS DECIMAL(12,2))) as mean
From Wrangle.train
group by Embarked
order by mean desc