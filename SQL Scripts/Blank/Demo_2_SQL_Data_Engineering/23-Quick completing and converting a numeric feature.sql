-------------------------------------------------------------------------------
--Let explore the fare value , we have empty value in the test.
Select
	*
From Wrangle.test
where Fare is null

--https://sqlperformance.com/2012/08/t-sql-queries/median+
Declare @Median decimal(18,2)
SELECT @Median = PERCENTILE_CONT(0.5) 
  WITHIN GROUP (ORDER BY fare) OVER ()
FROM Wrangle.Test

Select @Median


--Update Empty fare with the median
Update Wrangle.Test
Set Fare =_____
where fare is null