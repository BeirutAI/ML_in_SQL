--We will create new feature called FamilySize
alter table Wrangle.train drop column if exists FamilySize
alter table Wrangle.Test drop column if exists FamilySize

go

alter table Wrangle.train add FamilySize int
alter table Wrangle.test add FamilySize int

go
--Will update the value by adding SibSp + Parch + 1
Update Wrangle.train Set FamilySize = SibSp + Parch + 1
Update Wrangle.test  Set FamilySize = SibSp + Parch + 1


Select top 5 * From Wrangle.train