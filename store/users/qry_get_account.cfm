
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This query gets the Account record for a particular user --->
<cfquery name="qry_get_account" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT A.* FROM #Request.DB_Prefix#Account A, #Request.DB_Prefix#Users U
	WHERE A.User_ID = U.User_ID
	AND U.User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
		
