
<!--- CFWebstore�, version 6.43 --->

<!--- CFWebstore� is �Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of category templates, must be set for use with categories. Used on the list pages for filter and for the category form page --->

<cfparam name="attributes.catcore_content" default="">

<cfquery name="qry_get_catCores"  datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
	SELECT CatCore_ID, Catcore_Name
	FROM #Request.DB_Prefix#CatCore
	WHERE Category = 1
	<cfif attributes.catcore_content is not "">
	AND #attributes.catcore_content# = 1
	</cfif>
</cfquery>
		


