-- Full Backup
BACKUP DATABASE ehr
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\ehr_full.bak'
WITH INIT;

-- Differential Backup (nakon nekih promjena u bazi)
BACKUP DATABASE ehr
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\ehr_diff.bak'
WITH DIFFERENTIAL, INIT;

-- Transaction Log Backup (periodicno, npr. svakih 15 minuta)
BACKUP LOG ehr
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\ehr.trn'
WITH INIT;
