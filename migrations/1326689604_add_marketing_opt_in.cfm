<cfquery name="add_marketing_opt_in" datasource="#APPLICATION.dsn#">
	IF COL_LENGTH("Users", "marketing_opt_in") IS NOT NULL
	BEGIN
		ALTER TABLE Users
		ADD marketing_opt_in bit
	END
</cfquery>