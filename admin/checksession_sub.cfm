<cflock timeout="10" throwontimeout="No" type="EXCLUSIVE" scope="SESSION">
<cfif NOT ParameterExists(session.UserID) OR session.UserID IS "">
	<div align="center" style="margin-top:20px; color:#ff0000; font-weight:bold;">Your Session Has Expired. <br>Please Close This Window, Logout and Log In Again.</div>
	<cfabort>
</cfif>
</cflock>
