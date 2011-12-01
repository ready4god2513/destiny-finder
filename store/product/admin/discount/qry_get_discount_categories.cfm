
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of categories the selected discount is currently assigned to. Called by product.admin&discount=categories --->

<cfquery name="qry_get_category_item" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
	SELECT C.Name, C.Category_ID, C.ParentNames
	FROM #Request.DB_Prefix#Discount_Categories DC, #Request.DB_Prefix#Categories C
	WHERE DC.Category_ID = C.Category_ID
	AND DC.Discount_ID = #attributes.discount_id#
</cfquery>
		


