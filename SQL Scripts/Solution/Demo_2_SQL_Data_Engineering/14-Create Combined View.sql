--Drop view Wrangle.vwTrainTest is exists
drop view if exists Wrangle.vwTrainTest
go

Create view Wrangle.vwTrainTest

as


Select  
		 PassengerId
		,Survived
		,Pclass
		--,[Name]
		,Sex
		,Age
		,SibSp
		,Parch
		,Fare
		,Embarked
		,Title
		,'1' as isTrain
From Wrangle.[train]

union

Select  
		 PassengerId
		,null as Survived
		,Pclass
		--,[Name]
		,Sex
		,Age
		,SibSp
		,Parch
		,Fare
		,Embarked
		,Title
		,'0' as isTrain
From Wrangle.test
