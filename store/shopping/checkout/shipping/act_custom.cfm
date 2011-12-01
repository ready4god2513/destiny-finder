<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is used to output custom shipping rates. Uses the shipping methods table to provide the custom shipping rates options. Called from put_shiprates.cfm  --->

<cfscript>
	//Initialize Shipping Types
	qryShipMethods = Application.objShipping.getCustomMethods();
	
	// Get Custom Settings
	GetCustom = Application.objShipping.getCustomSettings();
	
	//Create the structure with customer address information
	AddressInfo = Application.objCheckout.doAddresses(GetCustomer,GetShipTo);	
	
</cfscript>
	
<!--- Get Custom Shipping Rates --->
<cfinvoke component="#Request.CFCMapping#.shipping.custom" 
	returnvariable="Result" method="doCustomRates"
	TotalShip="#TotalShip#"
	ShipType="#ShipSettings.ShipType#"
	MultPerItem="#GetCustom.MultPerItem#"
	CumulativeAmounts="#GetCustom.CumulativeAmounts#"
	MultMethods="#GetCustom.MultMethods#"
	ShipLocation="#ShipLocation#"
	AddressInfo="#AddressInfo#"
	Methods="#qryShipMethods#"
	debug="#YesNoFormat(GetCustom.Debug)#">
	
	<!--- Output debug if turned on --->
	<cfif len(Result.Debug)>
		<cfinvoke component="#Request.CFCMapping#.global" method="putDebug" debugtext="#Result.Debug#">
	</cfif>

<cfif Result.Success>

	<!--- Set the shipping type to the current shipping method. 
	You can change this to a hard-coded setting if for some reason you use custom rates 
	along with one of the automated shippers. --->
	<cfset thisType = ShipSettings.ShipType>	

	<!--- Get the specific shipping settings --->
	<cfquery name="TypeSettings" dbtype="query">
		SELECT * FROM ShipSettings
		WHERE ShipType = '#thisType#'
	</cfquery>
	
	<cfscript>
		// Add the standard shipping method to the query of methods, used if shipping methods were not used
		QueryAddRow(qryShipMethods);
		QuerySetCell(qryShipMethods, "ID", "9999");
		QuerySetCell(qryShipMethods, "Name", "Standard Shipping");
		QuerySetCell(qryShipMethods, "Code", "Standard Shipping");
		QuerySetCell(qryShipMethods, "Used", "1");
		QuerySetCell(qryShipMethods, "Priority", "1");
		
		//Set variables for rate selection output
		RateStuff = StructNew();
		RateStuff.RateStruct = Result.Rates;
		RateStuff.Methods = qryShipMethods;
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
	<cfset NoShipping = 1>
	<cfset errorMessage = "">
	
</cfif><!--- success --->

