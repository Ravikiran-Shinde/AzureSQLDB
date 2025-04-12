#SCRIPT-1
==========
CREATE DATABASE Database1Copy AS COPY OF DB1
SELECT * FROM sys.dm_operation_status;


#SCRIPT-2
==========

Select * from sys.dm_operation_status 
where operation in ('CREATE DATABASE COPY', 'DATABASE RESTORE')
order by Start_Time Desc;
