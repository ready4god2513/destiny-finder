<cfquery name="getResults" datasource="#APPLICATION.DSN#">
	SELECT *
	FROM Results
	WHERE invite_uid = 'z6rz0e'
</cfquery>

<cfdump var="#getResults#">
	
<cfset assessments = CreateObject("component", "cfcs.users")>
<cfdump var="#assessments.findByInviteId("f7yeiv")#">