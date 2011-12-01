
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves a specific Customer record for editing. Called by the fuseaction users.admin&customer=edit --->

<cfquery name="qry_get_Customer" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" >
	SELECT * FROM #Request.DB_Prefix#Customers
	WHERE Customer_ID = #attributes.Customer_ID#
</cfquery>
		
		


