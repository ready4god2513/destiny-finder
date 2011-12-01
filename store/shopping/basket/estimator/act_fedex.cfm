<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to estimate a FedEx shipping rate. Calls the FedEx API to determine the selected rate and returns it to the calculator. Called from shopping/basket/act_ship_estimator.cfm  --->

<cfscript>
	thisType = "FedEx";
	
	// Get FedEx Settings
	GetFedEx = Application.objShipping.getFedExSettings();
	
	MerchantInfo = StructNew();
	MerchantInfo.Zip = GetFedEx.Origzip;	
	MerchantInfo.State = GetFedEx.Origstate;		
	MerchantInfo.Country = GetFedEx.Origcountry;	
	
	//Create the structure with customer address information
	AddressInfo = Application.objCheckout.doAddresses(GetCustomer,GetShipTo);	
	
	ShippersList = '';

	if (GetFedEx.UseGround)
		ShippersList = ListAppend(ShippersList, "FDXG");
		
	if (GetFedEx.UseExpress)
		ShippersList = ListAppend(ShippersList, "FDXE");

</cfscript>	

<cftry>
	<!--- Create the array of shippers and packages --->
	<cfset ShippingData = Application.objShipping.doShippingData(MerchantInfo, GetFedEx.MaxWeight)>
	
	<cfcatch type="DropShipError">
		<cfset est_shipping = "no">
	</cfcatch>

</cftry>

<!--- Continue if no errors so far --->
<cfif NOT isDefined("est_shipping")>
		
	<!--- Get the FedEx Shipping rate --->
	<cfinvoke component="#Request.CFCMapping#.shipping.fedex" 
		returnvariable="Result" method="getAllRates"
		accountnum="#GetFedEx.AccountNo#"
		meternum="#GetFedEx.MeterNum#"
		carriers="#ShippersList#"
		AddressInfo="#AddressInfo#"
		dropoff="#GetFedEx.Dropoff#"
		packaging="#GetFedEx.Packaging#"
		units="#GetFedEx.UnitsofMeasure#"
		ShipArray="#ShippingData#"
		service="#theMethod#"
		logging="#YesNoFormat(GetFedEx.Logging)#"
		debug="#YesNoFormat(GetFedEx.Debug)#">	
		
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


