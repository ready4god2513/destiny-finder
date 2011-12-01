<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->


<!--- This page does the basic shipping calculation for all shipping methods to determine if shipping rates will be needed. It determines if shipping is allowed to the country selected and checks for orders with no shipping cost. 
 --->
 
 <!--- Called from shopping.checkout (step=address|register|shipping|payment --->

<cfinclude template="../customer/qry_get_tempshipto.cfm">

<!--- First check if the user is shipping exempt --->
<cfquery name="CheckExempt" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
SELECT ShipExempt FROM #Request.DB_Prefix#Groups
WHERE Group_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Session.Group_ID#">
</cfquery>

<cfscript>
	if (GetShipTo.RecordCount and len(getshipto.country))
		check_country = GetShipTo.country;
	else
		check_country = getcustomer.country;

	if (CompareNoCase(check_country, Request.AppSettings.HomeCountry) IS 0) 
		ShipLocation = "Domestic";
	else
		ShipLocation = "International";

	// Shipping check for foreign orders
	if (get_Order_Settings.AllowInt IS 0 AND Compare(ShipLocation, "International") eq 0) {
		message = ShipSettings.NoShipMess;
		attributes.step ="Error";
	}									
	else if (NOT isDefined("attributes.backorder"))
		attributes.step ="shipping";

	// Set freight costs for domestic or international
	if (Compare(ShipLocation, "Domestic") IS 0)
		TotalFreight = FreightCost.Domestic;
	else
		TotalFreight = FreightCost.Intl;		

	// If exempt, set shipping and freight totals back to 0
	if (CheckExempt.RecordCount AND CheckExempt.ShipExempt IS NOT 0) {
		TotalShip = 0;
		TotalFreight = 0;		
	}	

	// If basket has no items with shipping charges 
	if (TotalShip IS 0) {
			
		NoShipping = 0;	
		ShipCost = 0;

		// Check for freight costs 
		if (TotalFreight IS NOT 0) 				
			ShipType = "Freight";
		else 
			ShipType = "No Shipping";
		
		// Skip shipping step and forward directly to payments IF the store has coupons turned off 
		// AND you don't want to use comments AND no required custom fields.
		
		if (get_Order_Settings.Giftcard is 0 AND get_Order_Settings.Delivery is 0 AND get_Order_Settings.Coupons is 0 AND NOT len(get_order_Settings.CustomText_Req) AND NOT len(get_order_Settings.CustomSelect_Req)) {
			attributes.step ="payment";
			attributes.comments = "";
		}	
	
	}

</cfscript>
