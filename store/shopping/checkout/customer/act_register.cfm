<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Saves the customer information during checkout. Called from act_save_order.cfm and by shopping.checkout (step=register) --->

<!--- Initialize variables (these are what we'll ultimately be setting) ----->
<cfif Session.User_ID>
	<cfquery name="GetUserNum" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Customer_ID, ShipTo FROM #Request.DB_Prefix#Users
	WHERE User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
	<cfset attributes.Customer_ID = GetUserNum.Customer_ID>
	<cfset attributes.shipto = GetUserNum.shipto>
<cfelse>
	<cfparam name="attributes.Customer_ID" default = "0">
	<cfparam name="attributes.shipto" default="0">
</cfif>


<!--- Shipto first so we can correctly add the customer record's shipto field ------->
<cfquery name="GetTempRecord" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#TempShipTo 
WHERE TempShip_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
</cfquery>

<cfif GetTempRecord.Recordcount>

	<cfset this_field = "shipto">
	<cfset this_ID = attributes.shipto>
	<cfset shiptoID = 0>
	<cfinclude template="act_addcustomer.cfm">

	<cfset attributes.shipto = this_ID>

<cfelse>
	<cfset attributes.shipto = 0>
</cfif>


<!--- Update Customer --->
<cfquery name="GetTempRecord" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#TempCustomer 
WHERE TempCust_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
</cfquery>

<cfif NOT GetTempRecord.Recordcount>

	<cfset Message = "There has been an error in your customer registration. Please try again.">
	<cfset attributes.step = "error">

<cfelse>

	<cfset this_field = "customer_ID">
	<cfset this_ID = attributes.customer_ID>
	<cfinclude template="act_addcustomer.cfm">

	<cfset attributes.customer_ID = this_ID>
	
	
</cfif>
