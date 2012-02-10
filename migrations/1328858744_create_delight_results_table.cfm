<cfquery name="insertRecords" datasource="#APPLICATION.DSN#">
	CREATE TABLE delight_survey_results
	(
		id int NOT NULL AUTO_INCREMENT,
		user_id int NOT NULL, 
		aptitudes varchar(2000), 
		delights varchar(2000), 
		last_modified datetime
	)
</cfquery>