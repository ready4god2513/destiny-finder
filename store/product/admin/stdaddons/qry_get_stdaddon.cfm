
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the information for a standard addon. Called by product.admin&stdaddon=edit --->

<cfmodule template="../../../access/secure.cfm"	keyname="product" requiredPermission="1">

<cfquery name="qry_get_Stdaddon" datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
	SELECT * FROM #Request.DB_Prefix#StdAddons
	WHERE Std_ID = #attributes.Std_ID#
	<!--- If not full product admin, filter by user to check for access --->
	<cfif not ispermitted>	
	AND User_ID = #Session.User_ID# </cfif>
</cfquery>
		

