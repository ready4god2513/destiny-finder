
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieve the list of quantity discounts for a product. Also checks for any errors in the discounts. Called by product.admin&do=qty_discounts --->

<!--- Get current quantity discounts --->
<cfquery name="qry_get_qty_Discounts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#ProdDisc
WHERE Product_ID = #attributes.product_id#
ORDER BY Wholesale DESC, QuantFrom
</cfquery>


<!--- Error Checking ---->
<cfset attributes.message = "">
<cfset wholesale_above=0>
<cfset retail_above=0>
<cfset wholesale_max=0>
<cfset retail_max=0>

<cfloop query="qry_get_qty_Discounts">
	<cfif wholesale is "1" and quantto is "0">
		<cfset wholesale_above= wholesale_above + 1>
	</cfif>
	<cfif wholesale is "0" and quantto is "0">
		<cfset retail_above= retail_above + 1>
	</cfif>
	<cfif wholesale is "1" and quantfrom lte wholesale_max>
		<cfset attributes.message = "Warning! Overlapping Wholesale Quantities">
	</cfif>
	<cfif wholesale is "0" and quantfrom lte retail_max>
		<cfset attributes.message = "Warning! Overlapping Retail Quantities">
	</cfif>
	<cfif wholesale is "0">
		<cfset retail_max= quantto>
	<cfelse>
		<cfset wholesale_max= quantto>
	</cfif>
	
</cfloop>

	<cfif wholesale_above gt 1>
		<cfset attributes.message = "Warning! More than one unlimited Wholesale Quantity">
	</cfif>
	<cfif retail_above gt 1>
		<cfset attributes.message = "Warning! More than one unlimited Retail Quantity">
	</cfif>
	

