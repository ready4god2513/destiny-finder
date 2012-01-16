<cfquery name="add_marketing_opt_in" datasource="#APPLICATION.dsn#">
	IF COL_LENGTH("users", "marketing_opt_in") IS NOT NULL
	BEGIN
		ALTER TABLE users
		ADD marketing_opt_in bit DEFAULT 0
	END
</cfquery>