
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to retrieve the information for a selected feature. Called by feature.display|print --->

<cfparam name="attributes.Feature_ID" default="0">
<!--- Used to check for invalid query strings --->
<cfparam name="invalid" default="0">

<cfif Session.User_ID>
	<cfset accesskeys = '0,1'>
	<cfset key_loc = ListContainsNoCase(session.userPermissions,'contentkey_list',';')>
	<cfif key_loc>
		<cfset accesskeys = ListAppend(accesskeys,ListLast(ListGetAt(session.userPermissions,key_loc,';'),'^'))>
	</cfif>
</cfif>
<cfparam name="accesskeys" default="0">


<cftry>
	<cfquery name="qry_Get_Feature"  datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
	SELECT * FROM #Request.DB_Prefix#Features F
	WHERE Feature_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Feature_ID#">
	AND Approved = 1
	AND Display = 1
	AND NOT EXISTS (SELECT C.Category_ID FROM #Request.DB_Prefix#Categories C 
		INNER JOIN #Request.DB_Prefix#Feature_Category FCat ON C.Category_ID = FCat.Category_ID
		 WHERE FCat.Feature_ID = F.Feature_ID
		AND C.Display = 0 )
	AND (Start <= #createODBCdate(now())# OR Start is null)
	AND (Expire >= #createODBCdate(now())# OR Expire is null)
	</cfquery>

	<!--- Check if there are any categories with an access key that this feature belongs to --->
	<cfquery name="qry_check_accesskey" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
		SELECT C.Category_ID, C.AccessKey FROM #Request.DB_Prefix#Categories C
		INNER JOIN #Request.DB_Prefix#Feature_Category FCat ON C.Category_ID = FCat.Category_ID
		WHERE FCat.Feature_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Feature_ID#">
		AND C.AccessKey IS NOT NULL AND C.AccessKey <> 0 AND C.AccessKey NOT IN (<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#accesskeys#" list="Yes">)
	</cfquery>

<cfcatch type="Any">
	<cfset invalid = 1>
</cfcatch>
</cftry>
