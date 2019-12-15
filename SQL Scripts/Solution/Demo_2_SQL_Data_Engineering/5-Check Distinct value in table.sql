--Check Distinct value in table
Declare @SQL nvarchar(max)
set @SQL = ''
;with cols as (
select Table_Schema, Table_Name, Column_Name, Row_Number() over(partition by Table_Schema, Table_Name
order by ORDINAL_POSITION) as RowNum
from INFORMATION_SCHEMA.COLUMNS
)

select @SQL = @SQL + case when RowNum = 1 then '' else ' union all ' end
+ ' select ''' + Column_Name + ''' as Column_Name, count(distinct ' + quotename (Column_Name) + ' ) As DistinctCountValue, 
count( '+ quotename (Column_Name) + ') as CountValue FROM ' + quotename (Table_Schema) + '.' + quotename (Table_Name)
from cols
where Table_Name = 'train' --print @SQL

exec  (@SQL)

