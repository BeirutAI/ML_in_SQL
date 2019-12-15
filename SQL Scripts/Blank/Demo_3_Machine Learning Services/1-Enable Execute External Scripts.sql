--https://www.sqlshack.com/how-to-use-python-in-sql-server-2017-to-obtain-advanced-data-analytics/
--Configure SQL to run external scripts
sp_configure

go

EXEC sp_configure 'external scripts enabled', 1
RECONFIGURE WITH OVERRIDE

go

--Reboot SQL Instance

go

