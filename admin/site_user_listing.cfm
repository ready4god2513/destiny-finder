<cfinclude template="checksession_sub.cfm">
<!--- add / edit admin users --->
	<cfquery name="getusers" datasource="#APPLICATION.DSN#" dbtype="ODBC">
	SELECT user_first_name, user_last_name, user_id, user_active, user_email FROM Users
	WHERE user_type = 1
	ORDER BY user_last_name, user_first_name
	</cfquery>
<cfinclude template="functions/admin_functions.cfm">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>User Listing</title>
	<link rel="stylesheet" href="css/style.css" type="text/css" />
	<link rel="stylesheet" href="css/mocha.css" type="text/css" />
</head>

<body>
<cfif isDefined("url.memo")>
	<cfoutput>#listing_memo(action=url.memo, title=url.title)#</cfoutput>
</cfif>

<div style="width:500px;margin-right:auto;margin-left:auto;margin-top:5px;">
	<div id="table_headings">
	<div style="width:390px;float:left;">User Name &nbsp;&nbsp;<a href="site_users.cfm?user_id=new"><img src="images/action_add.gif" />Add New</a></div>
	<div style="width:10px;float:left; margin-top:4px;text-align:center;">&nbsp;</div>
	<div style="width:90px;float:left; margin-top:4px;">Active</div>
		<div style="clear:both;"></div>
	</div>
	
	<cfoutput query="getusers">
				<div id="<cfif currentrow MOD 2>even_row<cfelse>odd_row</cfif>">
			<div id="name_column" style="width:165px;"><a href="site_users.cfm?user_id=#getusers.user_id#"><img src="images/edit.gif" />&nbsp;#getusers.user_first_name#&nbsp;#getusers.user_last_name#</a></div>
			<div id="column_one" style="width:235px;text-align:center;">
				&nbsp;
			</div>
			<div id="column_two" style="width:90px;"><cfif "#getusers.user_active#" EQ "true"><img src="images/action_check.gif" /><cfelse><img src="images/action_no.gif" /></cfif></div>
				<div style="clear:both;"></div>
		</div>
		
	</cfoutput>	
<div style="clear:both;"></div>
</div>
</body>
</html>
