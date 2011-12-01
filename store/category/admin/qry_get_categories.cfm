
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of categories. Filters according to the search parameters that are passed. Called by category.admin&category=list|listform --->

<cfloop index="namedex" list="PID,Catcore_ID,Name,AccessKey,Display,highlight,Sale,catcore_content">
	<cfparam name="attributes.#namedex#" default="">
</cfloop>
		
<cfquery name="qry_get_categories"   datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
	SELECT C.*, CC.Catcore_Name AS catcore_name, A.Name AS accesskey_name
	FROM (#Request.DB_Prefix#Categories C 
	INNER JOIN #Request.DB_Prefix#CatCore CC ON C.CatCore_ID = CC.CatCore_ID) 
	LEFT OUTER JOIN #Request.DB_Prefix#AccessKeys A ON C.AccessKey = A.AccessKey_ID
	WHERE 1 = 1
<cfif trim(attributes.PID) is not "">
		AND C.Parent_ID = #attributes.PID#</cfif>
<cfif trim(attributes.Catcore_ID) is not "">
		AND C.CatCore_ID = #attributes.Catcore_ID#</cfif>
<cfif trim(attributes.Name) is not "">
		AND C.Name like '%#attributes.Name#%'</cfif>
<cfif len(attributes.AccessKey)>
		AND C.AccessKey = #attributes.AccessKey#</cfif>
<cfif trim(attributes.Display) is not "">
		AND C.Display = #attributes.Display#</cfif>
<cfif trim(attributes.highlight) is not "">
		AND C.Highlight = #attributes.highlight#</cfif>
<cfif trim(attributes.Sale) is not "">
		AND C.Sale = #attributes.Sale#</cfif>
<cfif attributes.catcore_content is not "">
	AND CC.#attributes.catcore_content# = 1</cfif>
	
	ORDER BY C.Priority, C.Name
</cfquery>
		


