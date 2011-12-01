<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the inventory amounts for products based on the cached and inventory settings. Called by qry_get_products.cfm --->

<cfparam name="ProdList" default="">

<!--- Get NuminStock for these products --->
<cfquery name="qry_num_in_stock" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Product_ID, NumInStock FROM #Request.DB_Prefix#Products
WHERE <cfif len(ProdList)> Product_ID IN (#ProdList#)
		AND 1 = 1
	<cfelse>0 = 1 </cfif>
</cfquery>	

<!--- If we are hiding out of stock products, check if any products in the query are now out of stock --->
<cfif Request.AppSettings.InvLevel IS NOT "None" AND NOT Request.AppSettings.OutOfStock>
	<cfquery name="check_outofstock" dbtype="query">
		SELECT * FROM qry_num_in_stock
		WHERE NumInStock <= 0 
	</cfquery>
	
	<!--- If there are items out of stock in the cache, update the cached product query --->
	<cfif check_outofstock.Recordcount>
	
		<cfset NumRemoved = check_outofstock.Recordcount>
		
		<!--- First, update the product list --->
		<cfset NewEndRow = iif((EndRow + NumRemoved) LTE qry_Get_products.Recordcount, (EndRow + NumRemoved), qry_Get_products.Recordcount)>

		<cfloop index="x" from="#EndRow+1#" to="#NewEndRow#">
			<cfset ProdList = ListAppend(ProdList, qry_Get_products.Product_ID[x])>
		</cfloop>
		
		<!--- Remove Out of Stock Prods --->
		<cfloop query="check_outofstock">
			<cfset ProdList = ListDeleteAt(ProdList, ListFind(ProdList, check_outofstock.Product_ID))>
		</cfloop>
	
		<!--- Query-of-Query to get data without the out-of-stock products --->
		<cfquery name="qry_Get_products" dbtype="query">
		SELECT * FROM qry_Get_products
		WHERE Product_ID NOT IN (#ValueList(check_outofstock.Product_ID)#)
		</cfquery>

	</cfif>


</cfif>
