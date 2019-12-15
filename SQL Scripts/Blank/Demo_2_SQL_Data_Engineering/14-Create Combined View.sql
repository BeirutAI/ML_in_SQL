-------------------------------------------------------------------------------
--Drop view Wrangle.vwTrainTest is exists
_________________
go

--Create view Wrangle.vwTrainTest

__________ Wrangle.vwTrainTest

as


Select  
		 PassengerId
		,Survived
		,Pclass
		,Sex
		,Age
		,SibSp
		,Parch
		,Fare
		,Embarked
		,Title
		,'1' as isTrain
From Wrangle.[train]

______

Select  
		 PassengerId
		,null as Survived
		,Pclass
		,Sex
		,Age
		,SibSp
		,Parch
		,Fare
		,Embarked
		,Title
		,'0' as isTrain
From Wrangle.test
