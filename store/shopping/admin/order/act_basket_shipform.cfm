<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Updates Orders dropshipping information from put_basket_shipform.cfm template. Called by shopping.admin&order=display --->

<cfloop index="Order_ID" list="#attributes.Orderslist#">

	<cfset dropship_Account_ID = Evaluate("attributes.dropship_Account_ID#Order_ID#")>
	<cfset dropship_qty = Evaluate("attributes.dropship_qty#Order_ID#")>
	<cfset dropship_sku = Evaluate("attributes.dropship_sku#Order_ID#")>
	<cfset dropship_note = Evaluate("attributes.dropship_note#Order_ID#")>
	<cfset dropship_cost = Evaluate("attributes.dropship_cost#Order_ID#")>
	<cfif NOT len(Trim(dropship_cost))>
		<cfset dropship_cost = 0>
	</cfif>
	
	<cfquery name="UpdateOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#Order_Items
		SET Dropship_Account_ID = <cfif len(dropship_Account_ID)>#dropship_Account_ID#<cfelse>NULL</cfif>,
		Dropship_Qty = <cfif len(dropship_qty) AND len(dropship_Account_ID)>#dropship_qty#<cfelse>0</cfif>,
		Dropship_SKU = '#dropship_sku#',
		Dropship_Cost = <cfif len(dropship_cost)>#dropship_cost#<cfelse>NULL</cfif>,
		Dropship_Note = '#dropship_note#'
		WHERE Item_ID = #Order_ID#
		AND Order_No = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Order_No#">
	</cfquery>
	
</cfloop>