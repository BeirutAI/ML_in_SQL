--https://docs.microsoft.com/en-us/sql/advanced-analytics/package-management/install-additional-python-packages-on-sql-server?view=sql-server-2017
--`E:\Program Files\Microsoft SQL Server\MSSQL14.SQL2017\PYTHON_SERVICES`

--The belwo script tell you the location of the instance
SELECT
     SERVERPROPERTY('instancedefaultdatapath') AS [DefaultFile], 
     SERVERPROPERTY('instancedefaultlogpath') AS [DefaultLog]

go
--Open E:\Program Files\Microsoft SQL Server\MSSQL14.SQL2017\PYTHON_SERVICES\Scripts
--Install the below libraries
--pip install opencv-python
--pip install scikit-learn
--pip install jupyter

--Then run jupyter notebook

--Test python script is working
-- Pass the below
--Python
--Script :  from sklearn.linear_model import LogisticRegression
--			logreg = LogisticRegression()
--			print(logreg)

EXECUTE sp_execute_external_script
@language =N'________',
@script=N'_______';
GO

