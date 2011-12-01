
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of products the selected discount is currently assigned to. Called by product.admin&discount=products --->

<cfquery name="qry_get_product_item" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
	SELECT P.Product_ID, P.Name, P.SKU, P.Short_Desc
	FROM #Request.DB_Prefix#Discount_Products DP, #Request.DB_Prefix#Products P 
	WHERE DP.Product_ID = P.Product_ID
	AND DP.Discount_ID = #attributes.discount_id#
</cfquery>
		


