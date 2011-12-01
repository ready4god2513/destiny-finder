
<cfparam name="Form.Page" default="0">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>CFWebstore Version Updater</title>
</head>

<body>
This page has been created to update the current data in your store to the new CFWebstore version 6.<br>
<br>

<cfif ListFind("1,2,3,4,5", Form.Page)>

<cfoutput>
NOW RUNNING PART #Form.Page# OF THE MIGRATION<br><br>
</cfoutput>

<cfswitch expression="#Form.Page#">

	<cfcase value="1">
		Updating your store settings, adding new pages, setting up new tax and shipping tables<br><br>
	</cfcase>

	<cfcase value="2">
		Hashing the user passwords, encrypting credit card numbers, and migrating product options to new tables<br><br>
	</cfcase>
	
	<cfcase value="3">
		Migrating the product/category discounts to new tables<br><br>
	</cfcase>

	<cfcase value="4">
		Updating the group/user permissions with new settings<br><br>
	</cfcase>

</cfswitch>

<cfflush>

<cfinclude template="migrations#Form.Page#.cfm">

	Changes complete<br>
	<br>
	<cfif ListFind("1,2,3,4", Form.Page)>
		<form action="migration.cfm" method="post">
		<cfoutput>
		<input type="Hidden" name="Page" value="#(Form.Page+1)#">
		</cfoutput>
		<input type="submit" value="Continue">
		</form>	
		
	<cfelse>
		ColdFusion updates complete! You are now ready to set up your new version 6 store.<br><br>
	</cfif>
	
	
<cfelse>
	Invalid migration page requested.
</cfif>
	
</body>
</html>
