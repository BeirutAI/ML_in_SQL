-------------------------------------------------------------------------------
--https://www.mssqltips.com/sqlservertutorial/9128/sql-server-statistical-window-functions-percentiledisc-and-percentilecont/
--Get Statistics for Pclass column (STDEVP,min,max,AVG)
Select   Distinct

		'Pclass' as ColumnName
		,_____(Pclass) std
		,_____(Pclass) as min
		,_____(Pclass) as max
		,_____(Pclass) as mean
		,_____(CAST(Pclass AS DECIMAL(12,2))) as mean

From train


--Get Percentile for Age column
 Select distinct
	  'Age' as ColumnName
	 ,PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY age)  OVER (PARTITION BY 1) as '25%'
 	 ,PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY age)  OVER (PARTITION BY 1) as '50%'
 	 ,PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY age)  OVER (PARTITION BY 1) as '75%'
 
 From 	train
 where age is not null	
 group by age





