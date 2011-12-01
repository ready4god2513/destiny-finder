<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to output FedEx shipping rates. Calls the FedEx API to determine rates available and outputs ones selected for the store. Called from put_shiprates.cfm  --->

<cfscript>
	thisType = "FedEx";
	
	//Get FedEx Shipping Methods
	qry_FedExMethods = Application.objShipping.getFedExMethods();
	
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
		<cfset errormessage = cfcatch.message>	
	</cfcatch>

</cftry>

<!--- Continue if no errors so far --->
<cfif NOT len(errormessage)>

	<!--- Get FedEx Shipping Amounts --->
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
		logging="#YesNoFormat(GetFedEx.Logging)#"
		debug="#YesNoFormat(GetFedEx.Debug)#">
		
		<!--- Output debug if returned --->
		<cfif len(Result.Debug)>
			<cfinvoke component="#Request.CFCMapping#.global" method="putDebug" debugtext="#Result.Debug#">
		</cfif>
	
	
	<cfif Result.Success>
	
		<!--- Get the FedEx specific shipping settings --->
		<cfquery name="TypeSettings" dbtype="query">
			SELECT * FROM ShipSettings
			WHERE ShipType = '#thisType#'
		</cfquery>
		
		<cfscript>
		//Set variables for rate selection output
			RateStuff = StructNew();
			RateStuff.RateStruct = Result.Rates;
			RateStuff.Methods = qry_FedExMethods;
			RateStuff.ShipType = thisType;
			RateStuff.AddType = 0;
			RateStuff.Settings = TypeSettings;
			RateStuff.RateCount = RateCount;
			
			//set amount of freight to add
			if(NOT ShipSettings.ShowFreight) 
				RateStuff.AddFreight = TotalFreight;
			else 
				RateStuff.AddFreight = 0;
			
			//Output the selected rates to the shipping page
			RateOutput = Application.objShipping.doRateOutput(argumentcollection=RateStuff);
			
			//If rates output, turn off the No Shipping Flag
			if (NOT RateOutput.NoShipping)
				NoShipping = RateOutput.NoShipping;
			
			//Update the rate counter
			RateCount = RateOutput.RateCount;	
		
		</cfscript>
	
	<cfelse>
		<cfset errorMessage = Result.errormessage>
		
	</cfif><!--- success --->
	
</cfif>





