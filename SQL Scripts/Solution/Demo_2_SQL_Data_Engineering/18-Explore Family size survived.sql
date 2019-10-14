Select	
	FamilySize,
	AVG(CAST(Survived AS DECIMAL(12,2))) as mean
From Wrangle.train
group by FamilySize
order by mean desc