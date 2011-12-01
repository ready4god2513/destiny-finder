
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<cfparam name="attributes.permissions" default="">

<!--- This template is used externally for User pick lists --->
<cfquery name="qry_Get_Users" datasource="#Request.DS#" username="#Request.user#" 
password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#Users
WHERE 1=1
<cfif len(attributes.permissions)>
	AND 
	(Permissions LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#attributes.permissions#%">
	OR Group_ID IN (SELECT Group_ID FROM #Request.DB_Prefix#Groups 
		WHERE Permissions LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#attributes.permissions#%">) )
</cfif>

ORDER BY Username
</cfquery>



