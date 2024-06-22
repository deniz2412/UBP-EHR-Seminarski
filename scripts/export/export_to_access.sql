
use master;
EXEC sp_dropserver 'AccessDB', 'droplogins';
EXEC sp_addlinkedserver
   @server = N'AccessDB',
   @provider = N'Microsoft.Jet.OLEDB.4.0',
   @srvproduct = N'OLE DB Provider for Jet',
   @datasrc = N'C:\Users\deniz\Desktop\UBP-EHR-Seminarski\exports\MSSSQL_to_Access.mdb';
GO
-- Export some tables to access
SELECT *
INTO AccessDB.dbo.patients
FROM ehr.ehr_schema.patients;

SELECT *
INTO AccessDB.dbo.admissions
FROM ehr.ehr_schema.admissions;