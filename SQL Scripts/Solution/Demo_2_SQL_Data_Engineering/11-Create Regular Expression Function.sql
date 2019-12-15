-- First, drop the functions if they already exist.
--https://github.com/DevNambi/sql-server-regex/blob/master/install/load-assembly-2017.sql
EXEC sp_configure 'clr enabled', 1;  
RECONFIGURE;  
GO  
 
drop function if exists  dbo.RegexMatch
go

drop function if exists  dbo.RegexGroupMatch
go
drop function if exists  dbo.RegexReplace
go


-- Second, drop the assembly and remove trust if it already exists
IF (SELECT COUNT(1) FROM sys.trusted_assemblies WHERE description like 'sql-server-regex%')=1
BEGIN
	declare @AssemblyHash varbinary(64);
	SELECT @AssemblyHash=hash from sys.trusted_assemblies where description like 'sql-server-regex%'
	EXEC sp_drop_trusted_assembly @AssemblyHash;
END
go


-- Third, finally, trust and create the assembly (sql-server-regex-2016.dll is compatible with SQL Server 2017)
EXEC sp_add_trusted_assembly 
	0x52A8DC6C31B95961455746731FEC5DC4E8BF7F8791A6854473BB4F9A9577AA2BC4376213EC4AD9C3ADB0A0A55CEACCEBB9A01D7AC5CCBACA054B0F14EF4212D1, 
	N'sql-server-regex, version=1.0.6494.17073';

declare @AssemblyLocation varchar(8000);

set @AssemblyLocation = 'E:\SSITB\Beirut AI\SQL - AI\Scripts\Demo_2_SQL_Data_Engineering\CLR\sql-server-regex-2016.dll'

drop assembly IF EXISTS RegexAssembly

CREATE ASSEMBLY RegexAssembly  
FROM  @AssemblyLocation
WITH PERMISSION_SET = SAFE;  

go

-- see https://msdn.microsoft.com/en-us/library/ms186755.aspx for details

CREATE FUNCTION dbo.RegexMatch (@input nvarchar(max), @pattern nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME [RegexAssembly].[UDF].[Match]
go

CREATE FUNCTION dbo.RegexGroupMatch (@input nvarchar(max), @pattern nvarchar(max), @group nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME [RegexAssembly].[UDF].[GroupMatch]
go

CREATE FUNCTION dbo.RegexReplace (@input nvarchar(max), @pattern nvarchar(max), @replacement nvarchar(max))
RETURNS nvarchar(max)
AS EXTERNAL NAME [RegexAssembly].[UDF].[Replace]
go



declare @regex_pattern varchar(max) = '[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+'
Declare @str varchar(max) = 'Hi my name is John and email address is john.doe@somecompany.co.uk'
select dbo.RegexMatch(@str, @regex_pattern)

