
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of permissions groups --->

<cfquery name="qry_get_groups" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" >
	SELECT * FROM #Request.DB_Prefix#Permission_Groups
	ORDER BY Name
</cfquery>
	

	
