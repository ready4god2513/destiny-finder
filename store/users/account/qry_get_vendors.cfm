
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used throughout the store to retrieve the list of store vendors. --->

<cfparam name="type1" default="vendor">

<cfquery name="qry_get_Vendors" datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
	SELECT Account_ID, Account_Name
	FROM #Request.DB_Prefix#Account
	WHERE Type1 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#type1#">
	ORDER BY Account_Name			
</cfquery>
		

