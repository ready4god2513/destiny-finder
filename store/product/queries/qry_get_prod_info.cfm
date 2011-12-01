
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page retrieves the subset of options, addons and reviews for a selected product, from the tables containing multiple options/addons/reviews. --->

<cfparam name="qry_get_products.Product_ID" default="0">

<!--- Get stock amount for this product --->
<cfquery name="qry_prod_stock" dbtype="query">
SELECT NumInStock FROM qry_num_in_stock
WHERE Product_ID = #qry_get_products.Product_ID#
</cfquery>

<!--- Get options for this product --->
<cfquery name="GetProdOpts" dbtype="query">
SELECT * FROM GetOptions
WHERE Product_ID = #qry_get_products.Product_ID#
</cfquery>

<!--- Get addons for this product --->
<cfquery name="GetProdAddons" dbtype="query">
SELECT * FROM GetAddons
WHERE Product_ID = #qry_get_products.Product_ID#
</cfquery>

<!--- Get custom fields for this product --->
<cfquery name="GetProdCustom" dbtype="query">
SELECT * FROM GetCustomInfo
WHERE Product_ID = #qry_get_products.Product_ID#
</cfquery>

<!--- Get group price for this product --->
<cfquery name="GetGroupPrice" dbtype="query">
SELECT * FROM qry_grp_prices
WHERE Product_ID = #qry_get_products.Product_ID#
</cfquery>

<!--- Get reviews for this product --->
<cfif request.appsettings.productreviews>
	<cfquery name="qry_prod_reviews" dbtype="query">
	SELECT * FROM GetReviews
	WHERE Product_ID = #qry_get_products.Product_ID#
	</cfquery>
</cfif>
