USE ehr;
-- Trigger 1: Prevent Duplicate Admissions
CREATE TRIGGER tr_PreventDuplicateAdmissions
ON ehr_schema.admissions
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN ehr_schema.admissions a ON i.subject_id = a.subject_id
            AND i.admittime BETWEEN a.admittime AND a.dischtime
    )
    BEGIN
        RAISERROR ('Duplicate admission for the same patient in the overlapping time period.', 16, 1);
    END
END
GO

-- Trigger 2: Enforce Unique Patient ID
CREATE TRIGGER tr_EnforceUniquePatientID
ON ehr_schema.patients
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted i WHERE i.subject_id IN (SELECT subject_id FROM ehr_schema.patients))
    BEGIN
        RAISERROR ('Patient ID already exists.', 16, 1);
    END
    ELSE
    BEGIN
        INSERT INTO ehr_schema.patients SELECT * FROM inserted;
    END
END
GO

-- Trigger 3: New Microbiology Event Notification
CREATE TRIGGER tr_NotifyNewMicrobiologyEvent
ON ehr_schema.microbiologyevents
AFTER INSERT
AS
BEGIN
    DECLARE @microevent_id INT;
    DECLARE @org_name VARCHAR(255);

    SELECT @microevent_id = i.microevent_id, @org_name = i.org_name
    FROM inserted i;

    PRINT 'New microbiology event occurred Event ID = ' + CAST(@microevent_id AS VARCHAR(10)) + ', ORG_NAME = ' + @org_name;
END


-- Trigger 4: Warn On High Heart Rate
CREATE TRIGGER tr_WarnOnHighHeartRate
ON ehr_schema.chartevents
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE itemid IN (SELECT itemid FROM ehr_schema.d_items WHERE label = 'Heart Rate') AND valuenum > 150)
    BEGIN
        PRINT 'WARNING: High heart rate detected!';
    END
END
GO

-- Trigger 5: Prevent Future Admission Dates
CREATE TRIGGER tr_PreventFutureAdmissionDates
ON ehr_schema.admissions
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE admittime > GETDATE())
    BEGIN
        RAISERROR ('Admission date cannot be in the future.', 16, 1);
    END
END
GO