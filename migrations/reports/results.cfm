<cfquery name="results" datasource="#APPLICATION.DSN#" maxrows="10">
	SELECT *
	FROM Results
	ORDER BY last_modified DESC
</cfquery>

<cfdump var="#results#">
<cfdump var="#REQUEST#">
<cfdump var="#SESSION#">