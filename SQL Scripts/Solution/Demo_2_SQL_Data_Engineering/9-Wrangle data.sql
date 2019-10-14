drop table if exists Wrangle.train
drop table if exists Wrangle.test

go

--Take a copy of the table 'train' and 'test' into another schema 'Wrangle'
Select * into Wrangle.train From train
Select * into Wrangle.test From test


--Check the result
Select top 2 * From Wrangle.train
