-------------------------------------------------------------------------------
--Drop table if exists '[Statistics].Data_Aggregate' & '[Statistics].Data_Percentile' 
__________________________
__________________________


 --Create table [Statistics].Data_Aggregate 
___________ [Statistics].Data_Aggregate(
	[ColumnName] [varchar](50) NOT NULL,
	[Count] int,
	[mean] [decimal](38, 6) NULL,
	[std] [float] NULL,
	[min] [int] NULL,
	[max] [int] NULL
	
) ON [PRIMARY]
GO



___________ [Statistics].Data_Percentile(
	[ColumnName] [varchar](50) NOT NULL,
	[25%] decimal(18,10) NULL,
	[50%] decimal(18,10) NULL,
	[75%] decimal(18,10) NULL)


 --------------------------------------------------------------------------------------
 --------------------------------------------------------------------------------------

 Declare @Stat_Aggregate nvarchar(max) ='
		insert into [Statistics].[Data_Aggregate] (ColumnName,Count,std,min,max,mean)
		Select   Distinct

		''col_name'' as ColumnName
		,count(*) Count
		,STDEVP(col_name) std
		,min(col_name) as min
		,max(col_name) as max
		,AVG(CAST(col_name AS DECIMAL(12,2))) as mean
From train'

 Declare @Stat_PERCENTILE nvarchar(max) ='
		insert into [Statistics].[Data_Percentile]
	 Select distinct
	 ''col_name'' as ColumnName
	 ,PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY col_name)  OVER (PARTITION BY 1) as ''[25%]''
 	 ,PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY col_name)  OVER (PARTITION BY 1) as  ''[50%]''
 	 ,PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY col_name)  OVER (PARTITION BY 1) as ''[75%]''
 
 From 	train
 where col_name is not null	
 group by col_name'


Declare @Query_1 nvarchar(max)= replace(@Stat_Aggregate,'col_name','PassengerId')
Declare @Query_2 nvarchar(max)= replace(@Stat_Aggregate,'col_name','Survived')
Declare @Query_3 nvarchar(max)= replace(@Stat_Aggregate,'col_name','Pclass')
Declare @Query_4 nvarchar(max)= replace(@Stat_Aggregate,'col_name','Age')
Declare @Query_5 nvarchar(max)= replace(@Stat_Aggregate,'col_name','SibSp')
Declare @Query_6 nvarchar(max)= replace(@Stat_Aggregate,'col_name','Parch')
Declare @Query_7 nvarchar(max)= replace(@Stat_Aggregate,'col_name','Fare')

exec (@Query_1)
exec (@Query_2)
exec (@Query_3)
exec (@Query_4)
exec (@Query_5)
exec (@Query_6)
exec (@Query_7)

Declare @Query_1_Perc nvarchar(max)= replace(@Stat_PERCENTILE,'col_name','PassengerId')
Declare @Query_2_Perc nvarchar(max)= replace(@Stat_PERCENTILE,'col_name','Survived')
Declare @Query_3_Perc nvarchar(max)= replace(@Stat_PERCENTILE,'col_name','Pclass')
Declare @Query_4_Perc nvarchar(max)= replace(@Stat_PERCENTILE,'col_name','Age')
Declare @Query_5_Perc nvarchar(max)= replace(@Stat_PERCENTILE,'col_name','SibSp')
Declare @Query_6_Perc nvarchar(max)= replace(@Stat_PERCENTILE,'col_name','Parch')
Declare @Query_7_Perc nvarchar(max)= replace(@Stat_PERCENTILE,'col_name','Fare')

exec (@Query_1_Perc)
exec (@Query_2_Perc)
exec (@Query_3_Perc)
exec (@Query_4_Perc)
exec (@Query_5_Perc)
exec (@Query_6_Perc)
exec (@Query_7_Perc)


go


drop table if exists [Statistics].Data_Describe_Numerical

Select   AG.ColumnName
		,[Count]
		,[mean]
		,[std]
		,[min]
		,[25%]
		,[50%]
		,[75%]
		,[max]
		into [Statistics].Data_Describe_Numerical

From [Statistics].Data_Aggregate AG
inner join [Statistics].Data_Percentile Perc
on Perc.ColumnName = AG.ColumnName

go

Select
	*
From [Statistics].Data_Describe_Numerical



