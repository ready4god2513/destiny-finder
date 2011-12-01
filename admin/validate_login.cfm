
<!--- query the info on that username --->
<cfquery name="checkuser" datasource="#APPLICATION.DSN#" maxrows=1 dbtype="ODBC" timeout="5">
SELECT admin_active, admin_id, admin_fname, admin_lname, admin_username, admin_password,admin_user_type FROM AdminUsers
WHERE admin_username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.username#">
</cfquery>




<!--- check to see if that username exists --->
<cfif checkuser.recordcount LT 1>
	<cflocation url="admin.cfm?status=nouser">
	<cfabort>
</cfif>

<!--- check password --->
<cfset checkcaps = Compare(hash(form.LoginPassword), checkuser.admin_password)>
<cfif checkcaps neq 0>		
		
	
	<cflocation url="admin.cfm?status=loginfailed">
	<cfabort>
</cfif>	

<!--- check to see if that username is active --->
<cfif checkuser.admin_active IS 0>
	<cflocation url="admin.cfm?status=inactive">
	<cfabort>
</cfif>

<!--- set session variables --->
<cflock timeout="10" throwontimeout="No" type="EXCLUSIVE" scope="SESSION">
	<cfset session.userID = checkuser.admin_id>
	<cfset session.Username = "#checkuser.admin_username#">
	<cfset session.name = "#checkuser.admin_fname# #checkuser.admin_lname#">
	<cfset session.user_type = checkuser.admin_user_type>
</cflock>

<!--- update last login for this user as today's date--->
<cfset lastlogin = DateFormat(Now(), "mmmm dd, yyyy")>
<cfquery name="updatelastlogin" datasource="#APPLICATION.DSN#" dbtype="ODBC">
UPDATE AdminUsers
SET admin_lastlogin = '#lastlogin#'
WHERE admin_id = #checkuser.admin_id#
</cfquery>
		
<cflocation url="index.cfm" addtoken="No">
