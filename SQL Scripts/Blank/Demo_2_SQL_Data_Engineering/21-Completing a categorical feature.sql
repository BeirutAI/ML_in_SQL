-------------------------------------------------------------------------------
/*
Embarked feature takes S, Q, C values based on port of embarkation. 
Our training dataset has two missing values. We simply fill these with the most common occurance.
*/
--Check the distribuation of embarked class
Select 
		Embarked,
		________ as Total 
From Wrangle.train
group by Embarked
order by Total desc

--So we fill the empty with the most value

Update Wrangle.train set Embarked =_____ where Embarked is null


--Check Embarked correlation
Select	
	________,
	AVG(CAST(Survived AS DECIMAL(12,2))) as mean
From Wrangle.train
group by Embarked
order by mean desc