
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to process the quick order form. Loops through the form and adds the items to the basket for each item found in the database. Called by shopping.quickact --->

<cfset Numbers = "">
<cfparam name="attributes.product_count" default="10">

<cfset attributes.xfa_LoginAction = "shopping.basket">

<cfif Session.User_ID>
	<cfset accesskeys = '0,1'>
	<cfset key_loc = ListContainsNoCase(session.userPermissions,'contentkey_list',';')>
	<cfif key_loc>
		<cfset accesskeys = ListAppend(accesskeys,ListLast(ListGetAt(session.userPermissions,key_loc,';'),'^'))>
	</cfif>
</cfif>
<cfparam name="accesskeys" default="0">


<cfloop index="num" from="1" to="#attributes.product_count#">

	<cfparam name="attributes.item#num#" default="">
	<cfparam name="attributes.product_ID#num#" default="">
	<cfparam name="attributes.quant#num#" default="1">

	<!--- User coming from the Quick Order free-fill page --->
	<cfif len(trim(attributes['item' & num])) AND isNumeric(attributes['quant' & num])>
		<cfset ItemInfo = Trim(attributes['item' & num])>
	
		<!--- Search for this product --->
		<cfquery name="Product" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
		SELECT P.Product_ID 
		FROM #Request.DB_Prefix#Products P
		LEFT JOIN #Request.DB_Prefix#Prod_CustInfo PC ON PC.Product_ID = P.Product_ID
		WHERE (P.SKU = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ItemInfo#">
		OR PC.CustomInfo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ItemInfo#">)
		AND P.Display = 1
		AND P.NotSold = 0
		AND P.AccessKey IN (#accesskeys#)
		AND (P.Sale_Start IS NULL OR P.Sale_Start <= <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">)
		AND (P.Sale_End IS NULL OR P.Sale_End >= <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">)
		</cfquery>
		
		<cfif Product.Recordcount>
		
			<cfset Application.objCart.doAddCartItem(Product_ID=Product.Product_ID, Quantity=attributes['quant' & num])>
				
		<cfelseif len(Evaluate("attributes.item#num#"))>
			
			<cfset Numbers = ListAppend(Numbers, " " & num)>

		</cfif>

	<!--- User is coming from a Quick Order category page --->
	<cfelseif len(Trim(attributes['product_ID' & num])) AND isNumeric(attributes['quant' & num])>
	
		<cfset variables.Product_ID = Trim(attributes['product_ID' & num])>
		<cfset variables.Quantity = Trim(attributes['quant' & num])>
		
		<cfset Application.objCart.doAddCartItem(Product_ID=variables.Product_ID, Quantity=variables.Quantity)>
		
	<cfelseif len(attributes['item' & num])>
		<cfset Numbers = ListAppend(Numbers, " " & num)>
	
	</cfif>

</cfloop>

<cfif len(Numbers)>
	<cfset Message = "The Order Code or SKU for product">
	<cfif Listlen(Numbers) GT 1>
		<cfset Message = Message & "s" & Numbers & " were">
	<cfelse>
		<cfset Message = Message & Numbers & " was">
	</cfif>
	<cfset Message = Message & " not valid, or you did not enter a quantity. If you would like to complete your order without this product, click on the checkout button to continue. Otherwise click on Continue Shopping to browse or search through our online catalog, or enter another number in the Quick Order form.">

</cfif>



