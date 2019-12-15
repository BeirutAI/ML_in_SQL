--# remove Parch and SibSp and FamilySize
alter table Wrangle.train drop column Parch,SibSp,FamilySize
alter table Wrangle.test drop column Parch,SibSp,FamilySize

go

Select top 5 * From Wrangle.train