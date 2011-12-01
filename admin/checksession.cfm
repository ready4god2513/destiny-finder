<cflock timeout="10" throwontimeout="No" type="EXCLUSIVE" scope="SESSION">
<cfif NOT ParameterExists(session.UserID) OR session.UserID IS "">
	<cflocation url="admin.cfm">
	<cfabort>
</cfif>
</cflock>
