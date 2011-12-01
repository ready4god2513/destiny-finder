
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the selected category. Called by category.admin&category=edit --->

<cfquery name="qry_get_category" datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
	SELECT C.*, CC.PassParams
	FROM #Request.DB_Prefix#Categories C 
	LEFT JOIN #Request.DB_Prefix#CatCore CC ON C.CatCore_ID = CC.CatCore_ID
	WHERE C.Category_ID = #attributes.CID#
</cfquery>
		


