<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to output custom shipping rates. Uses the shipping methods table to provide the custom shipping rates options. Called from put_shiprates.cfm  --->

<cfscript>
	// Get Custom Settings
	GetCustom = Application.objShipping.getCustomSettings();
	
	//Create the structure with customer address information
	AddressInfo = Application.objCheckout.doAddresses(GetCustomer,GetShipTo);	
</cfscript>

	
<!--- Get Custom Shipping Rates --->
<cfinvoke component="#Request.CFCMapping#.shipping.custom" 
	returnvariable="Result" method="doCustomRates"
	TotalShip="#Session.CheckoutVars.TotalShip#"
	ShipType="#ShipSettings.ShipType#"
	MultPerItem="#GetCustom.MultPerItem#"
	CumulativeAmounts="#GetCustom.CumulativeAmounts#"
	MultMethods="#GetCustom.MultMethods#"
	ShipLocation="#ShipLocation#"
	AddressInfo="#AddressInfo#"
	Methods="#qryMethods#"
	debug="#YesNoFormat(GetCustom.Debug)#">	

<cfif Result.Success AND structKeyExists(Result.Rates,"#theMethod#")>
	
	<cfset est_shipamount = Result.Rates[theMethod]>	

<cfelse>
	<cfset est_shipping = "no">
	
</cfif><!--- success --->

