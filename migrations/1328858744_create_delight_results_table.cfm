<cfquery name="insertRecords" datasource="#APPLICATION.DSN#">
	CREATE TABLE delight_survey_results 
	  ( 
	     id            INT IDENTITY(1, 1)PRIMARY KEY, 
	     user_id       INT NOT NULL, 
	     aptitudes     VARCHAR(2000), 
	     delights      VARCHAR(2000), 
	     last_modified DATETIME 
	  )
</cfquery>