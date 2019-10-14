--Create feature called IsAlone for passengers who don't have children/spouses/parents/siblings

alter table Wrangle.train drop column if exists IsAlone
alter table Wrangle.Test drop column if exists IsAlone

go

alter table Wrangle.train add IsAlone int
alter table Wrangle.test add IsAlone int

go
--Reset the flag
Update Wrangle.train Set IsAlone = 0
Update Wrangle.train Set IsAlone = 0

Update Wrangle.train Set IsAlone = 1 where FamilySize = 1
Update Wrangle.test Set IsAlone = 1 where FamilySize = 1

go

--Find correlation between isAlone and survival rate
Select	
	IsAlone,
	AVG(CAST(Survived AS DECIMAL(12,2))) as mean
From Wrangle.train
group by IsAlone
order by mean desc

go
Select top 5 * From Wrangle.train