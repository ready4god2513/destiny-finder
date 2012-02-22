<cfquery name="insertRecords" datasource="#APPLICATION.DSN#">
	CREATE TABLE passion_surveys 
	  ( 
	     id            INT IDENTITY(1, 1) PRIMARY KEY, 
	     user_id       INT NOT NULL,
	     created_at DATETIME 
	  )
</cfquery>

<cfquery name="insertRecords" datasource="#APPLICATION.DSN#">
	CREATE TABLE passion_survey_results 
	  ( 
	     id            INT IDENTITY(1, 1) PRIMARY KEY,
	     passion_survey_id       INT NOT NULL, 
	     name     VARCHAR(2000), 
	     value      VARCHAR(2000), 
	     created_at DATETIME 
	  )
</cfquery>