
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieve the information the selected page to display. Called by page.display --->

<cfparam name="attributes.pageaction" default="">
<!--- Used to check for invalid query strings --->
<cfparam name="invalid" default="0">

<cftry>
<!--- Get settings for this page --->
<cfquery name="qry_get_page" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT P.*, CC.Template 
FROM #Request.DB_Prefix#Pages P 
LEFT OUTER JOIN #Request.DB_Prefix#CatCore CC ON P.CatCore_ID = CC.CatCore_ID 
WHERE 
	<cfif len(attributes.pageaction)>
		PageAction = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.pageaction#">	
	<cfelseif isdefined("attributes.page_ID")>
		Page_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.page_ID#">
	</cfif>
</cfquery>

<cfcatch type="Any">
	<cfset invalid = 1>
</cfcatch>
</cftry>


