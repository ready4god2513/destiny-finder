
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieve the permissions for the selected user or group. Called by act_set_permissions.cfm --->

<!--- attributes.type: user | group , attributes.ID: user_id | group_id --->
<cfquery name="qry_get_permissions" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" >
	SELECT Permissions
	FROM #Request.DB_Prefix##attributes.type#s
	WHERE #attributes.type#_ID = #attributes.ID#
</cfquery>

		
		


