--update Wrangle.train set fare = 0
--update Wrangle.train set IsAlone = 0
--update Wrangle.train set sex = 1


alter table Wrangle.train alter column Sex int
alter table Wrangle.train alter column Embarked int
alter table Wrangle.train alter column Title int
alter table Wrangle.train alter column Fare int


Select top 5 * from Wrangle.train



go

Declare @PythonScript nvarchar(max)
Set @PythonScript =N'
import pandas as pd

from sklearn.linear_model import LogisticRegression

X_train = train_df.drop("Survived", axis=1)
Y_train = train_df["Survived"]

logreg = LogisticRegression()
logreg.fit(X_train, Y_train)

Y_pred = logreg.predict(X_train)
#print(Y_pred)

print(X_train.shape, Y_train.shape)

acc_log = round(logreg.score(X_train, Y_train) * 100, 2)
print(acc_log)

'


EXECUTE sp_execute_external_script
    @language = N'Python'
    , @script = @PythonScript
    , @input_data_1 = N'Select Survived,Pclass,Sex,Age,Fare,Embarked,Title,IsAlone From [Wrangle].[Train] '
	, @input_data_1_name = N'train_df'

