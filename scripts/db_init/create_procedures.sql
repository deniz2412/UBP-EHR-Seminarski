USE ehr;

-- Stored procedure 1: GetPatientDetails
CREATE PROCEDURE sp_GetPatientDetails
    @subject_id INT
AS
BEGIN
    SELECT p.subject_id, p.gender, p.anchor_age, p.anchor_year, p.dod,
           a.hadm_id, a.admittime, a.dischtime, a.admission_type, a.discharge_location
    FROM ehr_schema.patients p
    LEFT JOIN ehr_schema.admissions a ON p.subject_id = a.subject_id
    WHERE p.subject_id = @subject_id;
END

-- Stored procedure 2: GetDiagnosesByAdmission
CREATE PROCEDURE sp_GetDiagnosesByAdmission
    @hadm_id INT
AS
BEGIN
    SELECT seq_num, icd_code, icd_version
    FROM ehr_schema.diagnoses_icd
    WHERE hadm_id = @hadm_id;
END

-- Stored procedure 3: GetMedicationsByPatient
CREATE PROCEDURE sp_GetMedicationsByPatient
    @subject_id INT
AS
BEGIN
    SELECT p.drug, p.starttime, p.stoptime, p.route
    FROM ehr_schema.prescriptions p
    INNER JOIN ehr_schema.admissions a ON p.hadm_id = a.hadm_id
    WHERE a.subject_id = @subject_id;
END

-- Stored procedure 4: InsertNewPatient
CREATE PROCEDURE sp_InsertNewPatient
    @subject_id INT,
    @gender VARCHAR(5),
    @anchor_age INT,
    @anchor_year INT,
    @dod DATE = NULL
AS
BEGIN
    INSERT INTO ehr_schema.patients (subject_id, gender, anchor_age, anchor_year, dod)
    VALUES (@subject_id, @gender, @anchor_age, @anchor_year, @dod);
END

-- Stored procedure 5: CalculateAverageLengthOfStay
CREATE PROCEDURE sp_CalculateAverageLengthOfStay
AS
BEGIN
    SELECT AVG(DATEDIFF(day, admittime, dischtime)) AS avg_length_of_stay
    FROM ehr_schema.admissions;
END


exec sp_GetPatientDetails 10001217;
exec sp_GetDiagnosesByAdmission 24597018;
exec sp_GetMedicationsByPatient 10001217;
exec sp_InsertNewPatient 5, 'M', 45, 1975, '2020-01-01';
exec sp_CalculateAverageLengthOfStay;