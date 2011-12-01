
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->


<!--- This page is used to update the discounts for the products in a category if changes made to the selected discounts. Called by act_category.cfm --->

<!--- Get the list of products in the category --->
<cfquery name="qry_get_products" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
	SELECT P.Product_ID	
	FROM #Request.DB_Prefix#Products P, #Request.DB_Prefix#Product_Category PC 
	WHERE PC.Product_ID = P.Product_ID
	AND PC.Category_ID = #attributes.CID#
</cfquery>

<!--- Loop through query and reset the product discounts --->
<cfloop query="qry_get_products">

	<cfset Application.objDiscounts.updProdDiscounts(qry_get_products.product_id)>

</cfloop>
