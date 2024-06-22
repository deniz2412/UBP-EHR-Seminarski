BEGIN TRANSACTION
BEGIN TRY
    BULK INSERT ehr_schema.table_name -- Table name
    FROM '**ABSOLUTE_PATH_TO_CSV_FILE**' -- CSV file path
    WITH
    (
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
        FIRSTROW = 2,
        ERRORFILE = '**ABSOLUTE_PATH_TO_ERROR_FILE**',
        TABLOCK
    );
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;
    SELECT
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH