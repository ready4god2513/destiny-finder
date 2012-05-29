<cfquery name="getResults" datasource="#APPLICATION.DSN#">
	SELECT *
	FROM Results
	WHERE invite_uid = 'f7yeiv'
</cfquery>

<cfdump var="#getResults#">
	
<cfset assessments = CreateObject("component", "cfcs.assessment")>
<cfdump var="#assessments.retrieve_invites(invite_uid = "f7yeiv")#">