--Convert Female and Male to integer
--Explore Wrangle.train top 5 rows
Select
		top 5 *
From Wrangle.train

---Update Wrangle.train and  Wrangle.test set Sex  = 1 when female and 0 when male

Update Wrangle.[train] set Sex = '1' where Sex ='female'
Update Wrangle.[train] set Sex = '0' where Sex ='male'

Update Wrangle.test set Sex = '1' where Sex ='female'
Update Wrangle.test set Sex = '0' where Sex ='male'

Select
		top 5 *
From Wrangle.train
