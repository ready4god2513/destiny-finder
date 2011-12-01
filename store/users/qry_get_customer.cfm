
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This query gets all the Customer information for a particular customer_ID --->

<!--- Administrators can pass a User ID in, Users must use their own --->
<cfmodule template="../access/secure.cfm"
	keyname="users"
	requiredPermission="1"
	> 

<cfquery name="qry_get_customer" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT * FROM #Request.DB_Prefix#Customers
	WHERE Customer_ID = <cfqueryparam value="#attributes.Customer_id#" cfsqltype="CF_SQL_INTEGER">
	<cfif NOT ispermitted>
		AND User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
</cfquery>



