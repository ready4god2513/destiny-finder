
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the information for a giftwrap option. Called by shopping.admin&giftwrap=edit --->

<cfquery name="qry_get_giftwrap"   datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
	SELECT * FROM #Request.DB_Prefix#Giftwrap
	WHERE Giftwrap_ID = #attributes.Giftwrap_ID#
</cfquery>
		
