-------------------------------------------------------------------------------
drop table if exists Wrangle.train
drop table if exists Wrangle.test

go

--Take a copy of the table 'train' and 'test' into another schema 'Wrangle'
___________
___________

--Check the result
Select top 2 * From Wrangle.train
