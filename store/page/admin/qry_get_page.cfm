
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the selected page. Called by page.admin&do=edit --->

<cfquery name="qry_get_Page" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" >
	SELECT P.*, CC.PassParams
	FROM #Request.DB_Prefix#Pages P 
	LEFT JOIN #Request.DB_Prefix#CatCore CC ON P.CatCore_ID = CC.CatCore_ID
	WHERE P.Page_ID = #attributes.Page_ID#
</cfquery>

<cfquery name="qry_get_children" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#" >
	SELECT P.Page_ID FROM #Request.DB_Prefix#Pages P 
	WHERE P.Parent_ID = #attributes.Page_ID#
</cfquery>
		


