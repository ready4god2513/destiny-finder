
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- called from dsp_addressbook.cfm to get all customer records a user has created. --->

<!--- Administrators can pass a User ID in, Users must use their own --->
<cfmodule template="../../access/secure.cfm"
	keyname="users"
	requiredPermission="1"
	> 
<cfif ispermitted>
	<cfparam name="attributes.uid" default="#Session.User_ID#">
<cfelse>	
	<cfset attributes.uid = Session.User_ID>	
</cfif>

<cfquery name="qry_get_addressbook" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT * FROM #Request.DB_Prefix#Customers
	WHERE User_ID = <cfqueryparam value="#attributes.UID#" cfsqltype="CF_SQL_INTEGER">
	ORDER BY Company, LastName, FirstName
</cfquery>


