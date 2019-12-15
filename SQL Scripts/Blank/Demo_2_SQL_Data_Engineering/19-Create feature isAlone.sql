-------------------------------------------------------------------------------
--Create feature called IsAlone for passengers who don't have children/spouses/parents/siblings

alter table Wrangle.train drop column if exists IsAlone
alter table Wrangle.Test drop column if exists IsAlone

go

--Add IsAclone as integer
alter table Wrangle.train add IsAlone ___
alter table Wrangle.test  add IsAlone ___

go
--Update IsAlone flag to zero in train and test
__________________________________
__________________________________

--Set IsAlone equal to 1 when familysize is 1
Update Wrangle.train Set IsAlone = __ where FamilySize = __
Update Wrangle.test  Set IsAlone = __ where FamilySize = __

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