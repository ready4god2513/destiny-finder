
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to retrieve the list of products related to the current product. Called by product.admin&do=related --->

<cfquery name="qry_get_Product_item"   datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
	SELECT P.Product_ID, Name, SKU, Short_Desc
	FROM #Request.DB_Prefix#Product_Item PI, #Request.DB_Prefix#Products P 
	WHERE PI.Product_ID = P.Product_ID
	AND PI.Item_ID = #attributes.Product_id#
</cfquery>
		


