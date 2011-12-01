<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Sofware may be contacted at info@cfwebstore.com --->

<!--- This page is used to output Intershipper shipping rates. Calls the Intershipper API to determine rates available and outputs ones selected for the store. Called from put_shiprates.cfm  --->

<cfscript>
	thisType = "Intershipper";
	
	//Get Intershipper Methods
	qryIntShipMethods = Application.objShipping.getIntShipMethods();
	
	// Get Intershipper Settings
	GetIntShip = Application.objShipping.getIntShipSettings();
	
	MerchantInfo = StructNew();
	MerchantInfo.Zip = GetIntShip.Merchantzip;	
	MerchantInfo.Country = ListGetAt(Request.AppSettings.HomeCountry, 1, "^");
	
	//Create the structure with customer address information
	AddressInfo = Application.objCheckout.doAddresses(GetCustomer,GetShipTo);		
	
</cfscript>

<cftry>
	<!--- Create the array of shippers and packages --->
	<cfset ShippingData = Application.objShipping.doShippingData(MerchantInfo, GetIntShip.MaxWeight)>
	
	<cfcatch type="DropShipError">
		<cfset errormessage = cfcatch.message>	
	</cfcatch>

</cftry>

<!--- Continue if no errors so far --->
<cfif NOT len(errormessage)>
			
	<!--- Run the Intershipper request --->
	<cfinvoke component="#Request.CFCMapping#.shipping.intershipper" 
		returnvariable="Result" method="getAllRates"
		Userid="#GetIntShip.Userid#"
		int_password="#GetIntShip.Password#"
		carriers="#GetIntShip.Carriers#"
	    ServiceClasses="#GetIntShip.Classes#"
		units="#GetIntShip.UnitsofMeasure#"
		AddressInfo="#AddressInfo#"
		ShipArray="#ShippingData#"
		logging="#YesNoFormat(GetIntShip.Logging)#"
		debug="#YesNoFormat(GetIntShip.Debug)#">
		
		<!--- Output debug if returned --->
		<cfif len(Result.Debug)>
			<cfinvoke component="#Request.CFCMapping#.global" method="putDebug" debugtext="#Result.Debug#">
		</cfif>
		
	<cfif Result.Success>
	
		<!--- Get the Intershipper specific shipping settings --->
		<cfquery name="TypeSettings" dbtype="query">
			SELECT * FROM ShipSettings
			WHERE ShipType = '#thisType#'
		</cfquery>
		
		<cfscript>
		//Set variables for rate selection output
			RateStuff = StructNew();
			RateStuff.RateStruct = Result.Rates;
			RateStuff.Methods = qryIntShipMethods;
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


