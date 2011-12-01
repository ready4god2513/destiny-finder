
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the information for a specific access key. Called by access.admin&accessKey=edit/act --->

<cfquery name="qry_get_AccessKey"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT * FROM #Request.DB_Prefix#AccessKeys
	WHERE AccessKey_ID = #attributes.AccessKey_id#
</cfquery>
		
	

	
