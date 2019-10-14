--Now we need to convert Embarked to integer

Select
		top 5 *
From Wrangle.[train]

Update Wrangle.train set Embarked = '0' where Embarked ='S'
Update Wrangle.train set Embarked = '1' where Embarked ='C'
Update Wrangle.train set Embarked = '2' where Embarked ='Q'


Update Wrangle.test set Embarked = '0' where Embarked ='S'
Update Wrangle.test set Embarked = '1' where Embarked ='C'
Update Wrangle.test set Embarked = '2' where Embarked ='Q'

Select
		top 5 *
From Wrangle.[train]
