-------------------------------------------------------------------------------
--Let's explore the FamilySize survived
Select	
	_______,
	AVG(CAST(Survived AS DECIMAL(12,2))) as mean
From Wrangle.train
group by _______
order by mean desc