<cfquery name="getResults" datasource="#APPLICATION.DSN#">
	SELECT *
	FROM Results
	WHERE invite_uid = 'f7yeiv'
</cfquery>

<cfdump var="#getResults#">