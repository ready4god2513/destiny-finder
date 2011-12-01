 <cfinclude template="checksession_sub.cfm">
<!--- add / edit admin users --->
	<cfquery name="getusers" datasource="#APPLICATION.DSN#" dbtype="ODBC">
	SELECT admin_fname, admin_lname, admin_id, admin_active, admin_username FROM AdminUsers
	<cfif session.userID GT 1>
	WHERE admin_id > 1
	</cfif>
	ORDER BY admin_lname, admin_fname
	</cfquery>
<cfinclude template="functions/admin_functions.cfm">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Page Listing</title>
	<link rel="stylesheet" href="css/style.css" type="text/css" />
	<link rel="stylesheet" href="css/mocha.css" type="text/css" />
</head>

<body>
<cfif isDefined("url.memo")>
	<cfoutput>#listing_memo(action=url.memo, title=url.title)#</cfoutput>
</cfif>

<div style="width:500px;margin-right:auto;margin-left:auto;margin-top:5px;">
	<div id="table_headings">
	<div style="width:200px;float:left;">User Name &nbsp;&nbsp;<a href="users.cfm?admin_id=new"><img src="images/action_add.gif" />Add New</a></div>
	<div style="width:190px;float:left; margin-top:4px;">&nbsp;</div>
	<div style="width:100px;float:left; margin-top:4px;">Active</div>
		<div style="clear:both;"></div>
	</div>
	
	<cfoutput query="getusers">
		<cfif getusers.admin_username NEQ "admin">
		<div id="<cfif currentrow MOD 2>even_row<cfelse>odd_row</cfif>">
			<div id="name_column"><a href="users.cfm?admin_id=#getusers.admin_id#"><img src="images/edit.gif" />&nbsp;#getusers.admin_fname#&nbsp;#getusers.admin_lname#</a></div>
			<div id="column_one">
			&nbsp;</div>
			<div id="column_two"><cfif "#getusers.admin_active#" EQ "true"><img src="images/action_check.gif" /><cfelse><img src="images/action_no.gif" /></cfif></div>
				<div style="clear:both;"></div>
		</div>
		</cfif>
	</cfoutput>	
<div style="clear:both;"></div>
</div>
</body>
</html>
