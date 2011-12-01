
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of products. Filters according to the search parameters that are passed. Called by product.admin&product=list|listform|related and feature.admin&feature=related_prod--->

<cfmodule template="../../../access/secure.cfm"	keyname="product" requiredPermission="1">

<cfloop index="namedex" list="name,sku,display,highlight,notsold,sale,hot,type,event_id,account_id,CID,nocat,prodid">
	<cfparam name="attributes.#namedex#" default="">
</cfloop>

<cfif attributes.nocat is "1">
	<cfset attributes.cid = "">
</cfif>
		
<cfquery name="qry_get_products"   datasource="#Request.ds#"	 username="#Request.user#"  password="#Request.pass#" >
	SELECT DISTINCT P.Product_ID, P.Wholesale, P.OptQuant, P.Base_Price, P.Retail_Price, P.Name, P.SKU, 
	P.Display, P.Highlight,  P.Account_ID, P.Priority, P.NumInStock, P.NotSold, P.Sale, P.Hot, P.Prod_Type
	FROM #Request.DB_Prefix#Products P 
	LEFT JOIN #Request.DB_Prefix#Product_Category PC ON PC.Product_ID = P.Product_ID
	
	<cfif len(attributes.cid)>
	WHERE PC.Category_ID = #attributes.cid#
	<cfelseif attributes.nocat IS "1">
	WHERE P.Product_ID NOT IN (SELECT Product_ID FROM Product_Category)
	<cfelse> 
	WHERE 1 = 1
	</cfif>

<cfif trim(attributes.name) is not "">
		AND P.Name Like '%#attributes.name#%'	</cfif>
<cfif trim(attributes.sku) is not "">
		AND P.SKU Like '%#attributes.sku#%' </cfif>
<cfif trim(attributes.display) is not "">
		AND P.Display = #attributes.display#	</cfif>
<cfif trim(attributes.highlight) is not "">
		AND P.Highlight = #attributes.highlight#	</cfif>
<cfif trim(attributes.notsold) is not "">
		AND P.NotSold = #attributes.notsold#	</cfif>
<cfif trim(attributes.sale) is not "">
		AND P.Sale = #attributes.sale#	</cfif>
<cfif trim(attributes.hot) is not "">
		AND P.Hot = #attributes.hot#	</cfif>
<cfif trim(attributes.type) is not "">
		AND P.Prod_Type = '#attributes.type#'	</cfif>
<cfif trim(attributes.event_id) is not "">
		AND P.Event_ID = #attributes.event_id# </cfif>
<cfif trim(attributes.account_id) is not "">
		AND P.Account_ID = #attributes.account_id# </cfif>
<cfif isNumeric(attributes.prodid)>
		AND P.Product_ID = #attributes.prodid# </cfif>
<!--- If not full product admin, filter by user --->
<cfif not ispermitted>	
		AND P.User_ID = #Session.User_ID# </cfif>
		
	ORDER BY P.Priority, P.Name

</cfquery>
		


