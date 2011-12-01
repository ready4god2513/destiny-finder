<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template updates the administrative basket edits. Called by shopping.admin&order=display ---->

<!--- Calculate the basket subtotal ---->
<cfset SubTotal = 0>

<cfloop query="GetOrder">
	<cfset SubTotal = SubTotal + GetOrder.PromoAmount + ((GetOrder.Price + GetOrder.OptPrice + AddonMultP - GetOrder.DiscAmount) * GetOrder.Quantity)>
</cfloop>

<cfset subtotal = subTotal+GetOrder.AddonTotal+GetOrder.Tax-GetOrder.OrderDisc-GetOrder.Credits>

<cfset attributes.Freight = val(attributes.Freight)>
<cfset attributes.ShippingTotal = val(attributes.ShippingTotal)>
<cfset attributes.AdminCredit = val(attributes.AdminCredit)>

<cfset OrderTotal = subtotal + attributes.Freight + attributes.ShippingTotal - attributes.AdminCredit>

<!---- Debug 
<cfoutput>subtotal:#subtotal#  total:#ordertotal#</cfoutput>
<cfabort>
----->

<!--- Update Order_No Table ---->
<cfquery name="UpdateOrderNo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">	
	UPDATE #Request.DB_Prefix#Order_No
	SET Freight = #attributes.Freight#,
	Shipping = #attributes.shippingTotal#,
	ShipType= <cfif len(attributes.shiptype)>'#attributes.ShipType#',<cfelse>'No Shipping',</cfif>
	AdminCredit = #attributes.admincredit#,
	AdminCreditText= '#attributes.admincredittext#',
	OrderTotal = #OrderTotal#,
	Admin_Name = '#Session.Realname#',
	Admin_Updated = #createODBCdatetime(now())#
	WHERE Order_No = #attributes.Order_No#
</cfquery>


