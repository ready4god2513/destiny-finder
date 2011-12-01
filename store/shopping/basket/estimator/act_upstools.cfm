<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Sofware may be contacted at info@cfwebstore.com --->

<!--- This page is used to estimate a UPS shipping rate. Calls the UPS API to determine the selected rate and returns it to the calculator. Called from shopping/basket/act_ship_estimator.cfm  --->

<cfscript>	
	thisType = "UPS";
	
	// Get UPS Settings
	GetUPS = Application.objShipping.getUPSSettings();
	
	MerchantInfo = StructNew();
	MerchantInfo.Zip = GetUPS.Origzip;	
	MerchantInfo.City = GetUPS.Origcity;	
	MerchantInfo.Country = GetUPS.Origcountry;		
	
	//Create the structure with customer address information
	AddressInfo = Application.objCheckout.doAddresses(GetCustomer,GetShipTo);	
	
</cfscript>

<cftry>
	<!--- Create the array of shippers and packages --->
	<cfset ShippingData = Application.objShipping.doShippingData(MerchantInfo, GetUPS.MaxWeight)>
	
	<cfcatch type="DropShipError">
		<cfset est_shipping = "no">
	</cfcatch>

</cftry>

<!--- Continue if no errors so far --->
<cfif NOT isDefined("est_shipping")>

	
	<!--- Get UPS Shipping Amount --->
	<cfinvoke component="#Request.CFCMapping#.shipping.upstools" 
		returnvariable="Result" method="getAllRates"
		UserID="#GetUPS.Username#"
		Accesskey="#GetUPS.Accesskey#"
		UPSPassword="#GetUPS.Password#"
		ResRates="#YesNoFormat(GetUPS.ResRates)#"
		pickup="#GetUPS.Pickup#"
		units="#GetUPS.UnitsofMeasure#"
		customerclass="#GetUPS.CustomerClass#"
		package="#GetUPS.Packaging#"
		AddressInfo="#AddressInfo#"
		service="#theMethod#"
		ShipArray="#ShippingData#"
		logging="#YesNoFormat(GetUPS.Logging)#"
		debug="#YesNoFormat(GetUPS.Debug)#">
		
		<!--- Output debug if returned --->
		<cfif len(Result.Debug)>
			<cfinvoke component="#Request.CFCMapping#.global" method="putDebug" debugtext="#Result.Debug#">
		</cfif>
	
	<cfif Result.Success AND structKeyExists(Result.Rates,"#theMethod#")>
		
		<cfset est_shipamount = Result.Rates[theMethod]>
	
	<cfelse>
	
		<cfset est_shipping = "no">
		
	</cfif><!--- success --->

</cfif>


