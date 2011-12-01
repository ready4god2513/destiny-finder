	<cfset session.User	= "">
	<cfset session.userID = "">
	<cfset session.Username = "">
	<cfset session.name = "">
	<cfset session.administrator = "0">
	<cfset session.primaryadministrator = "0">

<cfinclude template="templates/adminheader.cfm">

<p>You have successfully logged out.</p>

<a href="index.cfm">&laquo;Login again</a>

<cfinclude template="templates/adminfooter.cfm">