<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Order Product Editing Upgrade - This form updates or deletes the products in the basket from the Order Manager.  --->

<!--- Make sure attributes.Quantity is a whole number; if not, set to 1 --->
<cfparam name="attributes.Quantity" default="1">

<cfif NOT isNumeric(attributes.Quantity)>
	<cfset attributes.Quantity = 1>
<cfelse>
	<cfset attributes.Quantity = Round(attributes.Quantity)>
</cfif>

<cfif attributes.Quantity LT 0>
	<cfset attributes.Quantity = 0>
</cfif>

<!--- Process Options---->
<cfset OptChoice = attributes.OptChoice>

<cfif attributes.productform_submit is "Update">

	<cfset HTMLBreak = Chr(60) & 'br' & Chr(62)>
	<cfset LineBreak = Chr(13) & Chr(10)>
	
	<cfset Addons = Replace(attributes.Addons, LineBreak, HTMLBreak, "All")>

	
	<!--- Update Orders Table  ---->
	<cfquery name="UpdateOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">	
	UPDATE #Request.DB_Prefix#Order_Items
	SET
	OptQuant = <cfif len(attributes.OptChoice)>#attributes.OptQuant#<cfelse>0</cfif>,
	OptChoice = <cfif len(attributes.OptChoice)>#attributes.OptChoice#<cfelse>0</cfif>,
	Options	= <cfif len(attributes.Options)>'#attributes.Options#',<cfelse>NULL,</cfif>
	<cfif NOT isDefined("attributes.NoAddonUpdate")>
	Addons = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Addons#" null="#YesNoFormat(NOT len(Addons))#">,
	AddonMultP = <cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#attributes.AddonMultP#">,
	AddonNonMultP = <cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#attributes.AddonNonMultP#">,
	</cfif>
	Quantity = #Val(attributes.Quantity)#, 
	Price = #Val(attributes.Price)#,
	OptPrice = #Val(attributes.OptPrice)#,
	DiscAmount = #Val(attributes.DiscAmount)#
	WHERE Item_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Orders_ID#">
	AND Order_No = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Order_No#">
	</cfquery>

<cfelseif attributes.productform_submit is "Delete">

	<!--- Delete Order Record --->
	<cfquery name="DeleteOrder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	DELETE FROM #Request.DB_Prefix#Order_Items
	WHERE Item_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Orders_ID#"> 
	AND Order_No = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Order_No#">
	</cfquery>
	
	<cfset attributes.Quantity = 0>
	
</cfif>

<!--- Update product inventory amounts --->
<cfset quantity =  attributes.quantity - attributes.Orig_Quantity>

<cfinclude template="act_basket_inventory.cfm">
	

<!--- Recalculate whole order & update Order_No table totals --->
	
	<!--- Get the order product information --->
	<cfquery name="GetOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT * FROM #Request.DB_Prefix#Order_Items
	WHERE Order_No = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Order_No#">
	</cfquery>
	
	<!--- Calculate new AddonTotal & Order Total ---->
	<cfset SubTotal = 0>
	<cfset AddonTotal = 0>

	<cfloop query="GetOrders">
		<cfset ProdPrice = GetOrders.Price + GetOrders.OptPrice + GetOrders.AddonMultP - GetOrders.DiscAmount>
		<cfset ProdTotal = (ProdPrice * GetOrders.Quantity) - GetOrders.PromoAmount>
		<cfset SubTotal = SubTotal + ProdTotal>
		<cfset AddonTotal = AddonTotal + GetOrders.AddonNonMultP>
	</cfloop>	

	<!--- Get the order total information --->
	<cfquery name="GetOrderNo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT * FROM #Request.DB_Prefix#Order_No
	WHERE Order_No = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Order_No#">
	</cfquery>
	
	<cfset OrderTotal = SubTotal + AddonTotal - GetOrderNo.OrderDisc - GetOrderNo.Credits + GetOrderNo.Tax + GetOrderNo.Shipping + GetOrderNo.Freight - GetOrderNo.AdminCredit>
	
		
	<!--- Update Order_No Table with new totals  ---->
	<cfquery name="UpdateOrderNo" datasource="#Request.DS#" username="#Request.user#" 	password="#Request.pass#">	
	UPDATE #Request.DB_Prefix#Order_No
	SET
	AddonTotal = #AddonTotal#,
	OrderTotal = #OrderTotal#,
	Admin_Name = '#Session.Realname#',
	Admin_Updated = #createODBCdatetime(now())#
	WHERE Order_No = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.Order_No#">
	</cfquery>

	