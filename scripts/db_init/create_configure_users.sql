-- Kreiranje korisničkih naloga (logins)
CREATE LOGIN admin WITH PASSWORD = 'passwordnijepassword124';
CREATE LOGIN doktor WITH PASSWORD = 'doktor123';
CREATE LOGIN medicinski_tehnicar WITH PASSWORD = 'medicinski_tehnicar123';
CREATE LOGIN istrazivac WITH PASSWORD = 'istrazivac123';
CREATE LOGIN analiticar WITH PASSWORD = 'analiticar123';

-- Kreiranje korisnika (users) u bazi podataka
USE ehr; -- Ime baze podataka
CREATE USER admin FOR LOGIN admin;
CREATE USER doktor FOR LOGIN doktor;
CREATE USER medicinski_tehnicar FOR LOGIN medicinski_tehnicar;
CREATE USER istrazivac FOR LOGIN istrazivac;
CREATE USER analiticar FOR LOGIN analiticar;

-- Dodjela uloga i prava
-- Admin
ALTER ROLE db_owner ADD MEMBER admin; -- Admin ima sva prava

-- Doktor
ALTER ROLE db_datareader ADD MEMBER doktor;  -- Doktor može čitati sve podatke
ALTER ROLE db_datawriter ADD MEMBER doktor; -- Doktor može ažurirati podatke
GRANT EXECUTE TO doktor;                       -- Doktor može izvršavati storne procedure

-- Medicinski tehničar
ALTER ROLE db_datareader ADD MEMBER  medicinski_tehnicar; -- Tehnicar može čitati većinu podataka
DENY SELECT ON ehr_schema.patients TO medicinski_tehnicar; -- Tehnicar ne može vidjeti lične podatke pacijenata
GRANT SELECT ON ehr_schema.admissions TO medicinski_tehnicar;
GRANT SELECT ON ehr_schema.prescriptions TO medicinski_tehnicar;
GRANT SELECT ON ehr_schema.labevents TO medicinski_tehnicar -- Tehnicar može čitati određene tabele
-- Istraživač
ALTER ROLE db_datareader ADD MEMBER istrazivac; -- Istraživač može čitati podatke
DENY SELECT ON ehr_schema.patients TO istrazivac; -- Istraživač ne može vidjeti lične podatke pacijenata
DENY SELECT ON ehr_schema.admissions TO istrazivac; -- Istraživač ne može vidjeti detalje prijema/otpusta

-- Analiticar
ALTER ROLE db_denydatareader ADD MEMBER analiticar; -- Analiticar može čitati samo agregirane podatke
GRANT SELECT ON vw_AggregatePodaci TO analiticar; -- Analiticar može čitati iz view-a sa agregiranim podacima