/*
Backup frequency
Azure SQL Managed Instance creates:

Full backups every week.
Differential backups every 12 to 24 hours.
Transaction log backups every 5-10 minutes.
The frequency of transaction log backups is based on the compute size and the amount of database activity. When you restore a database, the service determines which full, differential, and transaction log backups need to be restored.

 

How to monitor Azure SQL Database History backups
Azure SQL Database Backup History introduced a new Dynamic Management View(DMV) called Sys.dm_database_backups, that contains metadata information on all the active backups that are needed for enabling point-in-time restore within configured retention. 
Metadata information includes:

Backup_file_id – Backup file ID
Database_guid –Logical Database ID
Physical_Database_name – Physical Database Name
Server_name – Physical Server Name
Backup_start_date – Backup Start Timestamp
Backup_finish_date – Backup End Timestamp
Backup_Type – Type of Backup. D stands for Full Database Backup, L – Stands for Log Backup and I – Stands for differential backup
In_Retention – Whether backup is within retention period or not. 1 stands for within retention period and 0 stands for out of retention
*/


#SCRIPT-1
=======
SELECT db.name
    , backup_start_date
    , backup_finish_date
    , CASE backup_type
        WHEN 'D' THEN 'Full'
        WHEN 'I' THEN 'Differential'
        WHEN 'L' THEN 'Transaction Log'
    END AS BackupType
    , CASE in_retention
        WHEN 1 THEN 'In Retention'
        WHEN 0 THEN 'Out of Retention'
        END AS is_Backup_Available
FROM sys.dm_database_backups AS ddb
INNER MERGE JOIN sys.databases AS db
    ON ddb.physical_database_name = db.physical_database_name
ORDER BY backup_start_date DESC;

#SCRIPT-2
=======

SELECT db.name
    , backup_start_date
    , backup_finish_date
    , CASE backup_type
        WHEN 'D' THEN 'Full'
        WHEN 'I' THEN 'Differential'
        WHEN 'L' THEN 'Transaction Log'
    END AS BackupType
    , CASE in_retention
        WHEN 1 THEN 'In Retention'
        WHEN 0 THEN 'Out of Retention'
        END AS is_Backup_Available
FROM sys.dm_database_backups AS ddb
INNER MERGE JOIN sys.databases AS db
    ON ddb.physical_database_name = db.physical_database_name
WHERE db.name = 'SampleDB' 
ORDER BY backup_start_date DESC;

#SCRIPT-3
=======
SELECT * 
FROM sys.dm_database_backups     
ORDER BY backup_finish_date DESC; 
