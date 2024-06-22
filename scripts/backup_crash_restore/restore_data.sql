-- 1. Restore Full Backup (sa NORECOVERY)
USE master;
RESTORE DATABASE ehr
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\ehr_full.bak'
WITH NORECOVERY;

-- 2. Restore Differential Backup (sa NORECOVERY)
RESTORE DATABASE ehr
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\ehr_diff.bak'
WITH NORECOVERY;

-- 3. Restore Transaction Log Backups (do željenog trenutka)
RESTORE LOG ehr
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\ehr.trn'
WITH RECOVERY, STOPAT = '2024-06-22 12:00:00'; -- Vratiti do 22. juna 2024. u 12:00

-- Recovery param vraća bazu u pristupno stanje, posljednji restore treba biti WITH RECOVERY