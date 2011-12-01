<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<cfcomponent displayname="Shipping Functions" hint="This component is used for handling various shipping functions for the store." output="No">
<!--- This component developed by Mary Jo Sminkey maryjo@cfwebstore.com --->
<!--- Developed for use with CFWebstore e-commerce (www.cfwebstore.com) --->

<!--- Requires CFMX 6 or higher --->

<!--- This code is owned by Dogpatch Software and may not be distributes or reused without permission --->

<!--- Include global functions --->
<cfinclude template="../../includes/cfw_functions.cfm">


<!------------------------- COMPONENT INITIALIZATION ----------------------------------->
<cffunction name="init" access="public" output="no" returntype="shipping">
    <cfreturn this>
  </cffunction>

<!------------------------- BEGIN SHIPPING ARRAY FUNCTION ----------------------------------->

<cffunction name="doShipArray" returntype="array" displayname="Create Shipping Array" hint="This function takes the specific API settings and an array of packages and splits it as needed by the maximum weight setting." output="No" access="public">

<cfargument name="MaxWeight" type="numeric" required="Yes" hint="The maximum weight allowed for a package">
<cfargument name="TotalWeight" type="numeric" required="Yes" hint="Total weight of the order">
<cfargument name="TempArray" type="array" required="Yes"  hint="The temporary shipping array before splitting up packages">

<!--- structure to hold all local vars --->
<cfset var v = StructNew()>
<cfset var PackageArray = arguments.TempArray>

<cfscript>
//
v.FinalShip = arguments.TotalWeight;

//Check if TempArray has items (oversized packages). If so, subtract weights from the total weight
	if (ArrayLen(PackageArray) IS NOT 0) {
		v.numitems = ArrayLen(PackageArray);
		for (i=1;i LTE v.numitems; i=i+1) {
			v.ItemStruct = PackageArray[i];
			v.ItemWeight = (v.ItemStruct.Weight * v.ItemStruct.Quantity);
			v.FinalShip = v.FinalShip - v.ItemWeight;
		}
	}
	
	// Check if the final shipping amount for grouped items is over the maximum shipping weight.
	// If so, divide the package up accordingly 

	if (v.FinalShip GT 0 OR ArrayLen(PackageArray) IS 0) {
	
		if (arguments.MaxWeight LT v.FinalShip) {
			v.numPacks = Ceiling(v.FinalShip/arguments.MaxWeight);
			v.weightperpack = Round(v.FinalShip/v.numPacks*100)/100;
		}
		else {
			v.numPacks = 1;
			v.weightperpack = v.FinalShip;
			}	
			
		// Add the packages to the array 
		v.ItemShip = StructNew();
		v.ItemShip.Pack_Length = 0;
		v.ItemShip.Pack_Width = 0;
		v.ItemShip.Pack_Height = 0;
		v.ItemShip.Quantity = v.numPacks;
		v.ItemShip.Weight = v.weightperpack;
		// Add the structure to the array 
		temp = ArrayAppend(PackageArray, v.ItemShip);
	}


</cfscript>

<cfreturn PackageArray>

</cffunction>
<!------------------------- END SHIPPING ARRAY FUNCTION ----------------------------------->


<!------------------------- START SHIPPING DATA FUNCTION ----------------------------------->
<cffunction name="doShippingData" description="Do Shipping Data" hint="Takes the customer address and merchant information and shipping data and creates a final array of shipping information" access="public" output="No" returntype="array">

	<cfargument name="MerchantInfo" type="struct" required="Yes" hint="Structure with the default merchant information.">
	<cfargument name="MaxWeight" type="numeric" required="Yes" hint="Maximum weight for a package.">

	<cfscript>
	//Final shipping array of packages and shipper information
	var ShippingData = ArrayNew(1);
	
	//queries
	var qryDropShippers = '';
	var getShipFrom = '';
	
	//loop counter
	var vendor = '';
	
	//Structure for any non-dropshipped items
	var BaseShipping = StructNew();
	//Structure for all drop-shipped items
	var DropShipper = '';
	//Structure for temporary shipping data
	var ShipInfo = '';
	//Structure for drop-shipper address information 
	var strShipFrom = '';
	
	//Process the non-drop-shipped items
	BaseShipping.TotalWeight = Session.CheckoutVars.TotalWeight - Session.CheckoutVars.DropShipWeight;
	BaseShipping.MaxWeight= arguments.MaxWeight;
	BaseShipping.TempArray = Session.CheckoutVars.ShipArray;
	
	//If any non-dropshipped packages, add to the array
	if (BaseShipping.TotalWeight IS NOT 0) {
		ShipInfo = StructNew();
		//Parse Merchant Information
		ShipInfo.ShipFrom = Application.objCheckout.doShipFrom(arguments.MerchantInfo);
		ShipInfo.TotalWeight = BaseShipping.TotalWeight;
		ShipInfo.Packages = doShipArray(argumentcollection=BaseShipping);
	
		ArrayAppend(ShippingData, ShipInfo);
	}
	</cfscript>

	<!--- Check for drop-shippers and add to the array of shipping packages --->
	<cfif NOT StructIsEmpty(Session.CheckoutVars.Dropshippers)>
		<cfset qryDropShippers = getDropShippers()>
		
		<cfloop collection="#Session.CheckoutVars.Dropshippers#" item="vendor">
			
			<!--- Get the vendor address --->
			<cfquery name="getShipFrom" dbtype="query">
			SELECT * FROM qryDropShippers
			WHERE Account_ID = #ListGetAt(vendor, 2, "_")#
			</cfquery>
			
			<cftry>
			<cfscript>
				//Create the final shipping array according to maximum weight settings
				DropShipper = StructNew();
				DropShipper.TotalWeight = Session.CheckoutVars.Dropshippers[vendor].TotalWeight;
				DropShipper.MaxWeight= arguments.MaxWeight;
				DropShipper.TempArray = Session.CheckoutVars.Dropshippers[vendor].ShipArray;
				
				//Parse Merchant Information
				strShipFrom = queryRowToStruct(getShipFrom);
				
				//Create array of ship from addresses and packages
				ShipInfo = StructNew();
				ShipInfo.ShipFrom = Application.objCheckout.doShipFrom(strShipFrom);
				ShipInfo.TotalWeight = DropShipper.TotalWeight;
				ShipInfo.Packages = doShipArray(argumentcollection=DropShipper);
				
				ArrayAppend(ShippingData, ShipInfo);
			</cfscript>
			
			<cfcatch type="Any">
				<cfthrow type="DropShipError" message="Failure in retrieving drop-shipper information.">
			</cfcatch>
			</cftry>
		
		</cfloop>
	
	</cfif>

	<cfreturn ShippingData>

</cffunction>


<!------------------------- END SHIPPING DATA FUNCTION ----------------------------------->


<!------------------------- BEGIN RATE SELECTION OUTPUT FUNCTION ----------------------------------->
<cffunction name="doRateOutput" returntype="struct" displayname="Output shipping rates" hint="This function outputs the rates sent in as selected in the rate methods settings for the selected shipper." output="Yes" access="public">

<cfargument name="RateStruct" type="struct" required="Yes" hint="Structure containing the calculated shipping rates">
<cfargument name="Methods" type="query" required="Yes" hint="Query containing the shipping methods for the store">
<cfargument name="ShipType" type="string" required="Yes" hint="Type of shipping being used">
<cfargument name="AddType" type="boolean" required="No" default="1" hint="Determines whether to add the shipping type in front of the rate name. Default is to be turned on">
<cfargument name="Settings" type="query" required="Yes" hint="The shipping settings for the shipping type">
<cfargument name="AddFreight" type="numeric" required="No" default="0" hint="Amount of freight to add to the shipping cost, if any.">
<cfargument name="RateCount" type="numeric" required="No" default="0" hint="Counter used for the number of rate selections output to the page">

<!--- structure to hold all local vars --->
<cfset var v = StructNew()>

<cfset v.RateCount = arguments.RateCount>

<cfif NOT isDefined("Session.ShippingRates")>
	<cfset Session.ShippingRates = ArrayNew(1)>
</cfif>

<cfscript>
	// values to return to the calling page 
	v.returnVals = StructNew();
	v.NoShipping = 1;
	
	v.numMethods = arguments.Methods.RecordCount;

	//Loop through rates turned on for the store
	for(i=1; i lte v.numMethods; i=i+1) {
	
		v.currCode = arguments.Methods.Code[i];
		v.currID = arguments.Methods.ID[i];
		
		// Check if this shipping method was returned
		if (StructKeyExists(arguments.RateStruct, v.currCode)) {
		
			v.NoShipping = 0;
			v.RateCount = v.RateCount + 1;
			
			v.RateAmount = arguments.RateStruct[v.currCode];
			v.currCarrier = arguments.ShipType;
			v.currName = arguments.Methods.Name[i];
			
			v.Handling = Session.CheckoutVars.TotalCost * arguments.Settings.ShipHand;
			v.ShipAmount = v.RateAmount + arguments.Settings.ShipBase + v.Handling;
			v.ShipAmount = Round(v.ShipAmount*100)/100;
			
			//Check if free shipping applies:
			//Basket total must be greater than the minimum AND the shiptype must be in the freeshipping list
			
			if (Session.CheckoutVars.TotalBasket GT arguments.Settings.freeship_min AND
				listFind(arguments.Settings.freeship_ShipIDs,v.currID))
				v.ShipAmount = 0;
				
			// Add this rate to the array of rates 
			NewRate = StructNew();
			NewRate.Carrier = v.currCarrier;
			NewRate.Name = v.currName;
			NewRate.Code = v.currCode;
			NewRate.Amount = v.ShipAmount;
			
			Session.ShippingRates[v.RateCount] = NewRate;
			
			//If only one type of shipping type available		
			if ((v.numMethods IS 1 OR StructCount(arguments.RateStruct) IS 1) AND v.RateCount IS 1 AND arguments.Settings.InStorePickup IS 0) {
				doRateChoice(v.ShipAmount, arguments.AddFreight, v.RateCount, v.currName, "Yes");
			}
			
			else {
				//Create the radio button for each type of shipping
				if (arguments.AddType) 
					doRateChoice(v.ShipAmount, arguments.AddFreight, v.RateCount, v.currName, "No", v.currCarrier);
				else
					doRateChoice(v.ShipAmount, arguments.AddFreight, v.RateCount, v.currName, "No");	
			}			
		
		}
	
	}
	
	temp = StructInsert(v.returnVals, "RateCount", v.RateCount);
	temp = StructInsert(v.returnVals, "NoShipping", v.NoShipping);
	</cfscript>

<cfreturn v.returnVals>

</cffunction>

<cffunction name="doRateChoice" output="Yes" returntype="boolean" hint="Outputs the individual radio buttons for shipping selections." access="public">
	<cfargument name="RateAmount" type="numeric" required="Yes" hint="The cost of the rate selection">
	<cfargument name="AddFreight" type="numeric" required="No" default="0" hint="Amount of freight to add to the shipping cost, if any.">
	<cfargument name="RateID" type="numeric" required="Yes" hint="The ID for this rate, set by the RateCount">
	<cfargument name="RateName" type="string" required="Yes" hint="The name for the rate as output to the customer">
	<cfargument name="Hidden" type="boolean" required="Yes" hint="Determines if the rate is output to a hidden form field">
	<cfargument name="AddText" type="string" required="No" default="" hint="Passes any additional text to be output in front of the rate name, usually the carrier name">
	
	<cfscript>
	 if (arguments.Hidden) {
	 	WriteOutput('<input type="hidden" name="RateID" value="' & arguments.RateID &'"/>');
		if (arguments.RateAmount IS 0 AND arguments.AddFreight IS 0) 
			WriteOutput('FREE!');
		else 
			WriteOutput(LSCurrencyFormat(arguments.RateAmount+arguments.AddFreight));
					
		WriteOutput('<br/>');		
	 }
	else {
	//Create the radio button for each type of shipping
		WriteOutput('<br/><input type="radio" name="RateID" value="' & arguments.RateID & '" ');
		if (arguments.RateID IS 1)
			WriteOutput('checked="checked"');
		WriteOutput('/>');
		if (len(arguments.AddText)) 
			WriteOutput(arguments.AddText);
		WriteOutput(' ' & arguments.RateName & ' - ');
		if (arguments.RateAmount IS 0 AND arguments.AddFreight IS 0) 
			WriteOutput('FREE!');
		else 
			WriteOutput(LSCurrencyFormat(arguments.RateAmount+arguments.AddFreight));				
	}		
	
	</cfscript>
	
	<cfreturn true>
	

</cffunction>
<!------------------------- END RATE SELECTION OUTPUT FUNCTION ----------------------------------->



<!------------------------- SHIPPING METHODS FUNCTION ----------------------------------->
<cffunction name="getShipMethods" output="No"access="public" hint="Retrieves a list of active shipping methods for the current shipping type." >

	<cfargument name="ShipType" type="string">
	
	<cfscript>
		var qryMethods = '';
	
		if (CompareNoCase(arguments.ShipType, "FedEx") IS 0)
			qryMethods = getFedExMethods();
		else if (CompareNoCase(arguments.ShipType, "UPS") IS 0)
			qryMethods = getUPSMethods();
		else if (CompareNoCase(arguments.ShipType, "USPS") IS 0)
			qryMethods = getUSPSMethods();
		else if (CompareNoCase(arguments.ShipType, "Intershipper") IS 0)
			qryMethods = getIntShipMethods();
		else
			qryMethods = getCustomMethods();
	
	</cfscript>	

	<cfreturn qryMethods>
	
</cffunction>

<!------------------------- FEDEX METHODS ----------------------------------->
<cffunction name="getFedExMethods" output="No" hint="Returns a query with the full list of FedEx Methods." access="public">
	
	<cfset var qryFedExMethods = "">

	<cfquery name="qryFedExMethods" datasource="#Request.DS#" username="#Request.user#" 
	password="#Request.pass#" cachedwithin="#Request.Cache#">
		SELECT * FROM #Request.DB_Prefix#FedExMethods
		WHERE Used = 1
		ORDER BY Priority, Shipper, Name
	</cfquery>
	
	<cfreturn qryFedExMethods>

</cffunction>

<!------------------------- UPS METHODS ----------------------------------->
<cffunction name="getUPSMethods" output="No" hint="Returns a query with the list of active UPS Methods." access="public">
	
	<cfset var GetOrigin = "">
	<cfset var qryUPSMethods = "">

	<cfquery name="GetOrigin" datasource="#Request.DS#" username="#Request.user#" 
	password="#Request.pass#" cachedwithin="#Request.Cache#">
		SELECT Origin FROM #Request.DB_Prefix#UPS_Settings
	</cfquery>
	
	<cfquery name="qryUPSMethods" datasource="#Request.DS#" username="#Request.user#" 
	password="#Request.pass#" cachedwithin="#Request.Cache#">
		SELECT ID, Name, Used, Priority, #GetOrigin.Origin#Code AS Code 
		FROM #Request.DB_Prefix#UPSMethods
		WHERE #GetOrigin.Origin#Code <> '00'
		AND Used = 1
		ORDER BY Priority
	</cfquery>
	
	<cfreturn qryUPSMethods>	

</cffunction>

<!------------------------- US POSTAL METHODS ----------------------------------->
<cffunction name="getUSPSMethods" output="No" hint="Returns a query with the list of active US Postal Methods." access="public">
	
	<cfset var qryUSPSMethods = "">
	
	<cfquery name="qryUSPSMethods" datasource="#Request.DS#" username="#Request.user#" 
	password="#Request.pass#" cachedwithin="#Request.Cache#">
		SELECT * FROM #Request.DB_Prefix#USPSMethods
		WHERE Used = 1
		ORDER BY Priority
	</cfquery>
	
	<cfreturn qryUSPSMethods>	

</cffunction>

<!------------------------- INTERSHIPPER METHODS ----------------------------------->
<cffunction name="getIntShipMethods" output="No" hint="Returns a query with the list of Intershipper Methods." access="public">
	
	<cfset var qryIntShipTypes = "">
	
	<cfquery name="qryIntShipTypes" datasource="#Request.DS#" username="#Request.user#" 
	password="#Request.pass#" cachedwithin="#Request.Cache#">
		SELECT * FROM #Request.DB_Prefix#IntShipTypes
		WHERE Used = 1
		ORDER BY Priority, Name
	</cfquery>
	
	<cfreturn qryIntShipTypes>	

</cffunction>

<!------------------------- CUSTOM SHIPPING METHODS ----------------------------------->
<cffunction name="getCustomMethods" output="No" hint="Returns a query with the list of Custom Shipping Methods." access="public">
	
	<cfset var qryShipMethods = "">
	
	<cfquery name="qryShipMethods" datasource="#Request.DS#" username="#Request.user#" 
	password="#Request.pass#" cachedwithin="#Request.Cache#">
		SELECT CM.*, CM.Name AS Code 
		FROM #Request.DB_Prefix#CustomMethods CM
		WHERE Used = 1
		ORDER BY Priority, Name
	</cfquery>
	
	<cfreturn qryShipMethods>	

</cffunction>


<!------------------------- SHIPPING SETTINGS FUNCTION ----------------------------------->
<cffunction name="getShipSettings" output="No"access="public" hint="Retrieves the settings for the active shipping type." >

	<cfargument name="ShipType" type="string">
	
	<cfscript>
		var qryShipSettings = '';
	
		if (CompareNoCase(arguments.ShipType, "FedEx") IS 0)
			qryShipSettings = getFedExSettings();
		else if (CompareNoCase(arguments.ShipType, "UPS") IS 0)
			qryShipSettings = getUPSSettings();
		else if (CompareNoCase(arguments.ShipType, "USPS") IS 0)
			qryShipSettings = getUSPSSettings();
		else if (CompareNoCase(arguments.ShipType, "Intershipper") IS 0)
			qryShipSettings = getIntShipSettings();
		else
			qryShipSettings = getCustomSettings();
				
	</cfscript>	

	<cfreturn qryShipSettings>
	
</cffunction>

<!------------------------- FEDEX SETTINGS ----------------------------------->
<cffunction name="getFedExSettings" output="No" hint="Returns a query with the list of FedEx Settings." access="public">
	
	<cfset var qryFedExSettings = "">

	<cfquery name="qryFedExSettings" datasource="#Request.DS#" username="#Request.user#" 
	password="#Request.pass#" cachedwithin="#Request.Cache#">
		SELECT * FROM #Request.DB_Prefix#FedEx_Settings
	</cfquery>
	
	<cfreturn qryFedExSettings>

</cffunction>

<!------------------------- UPS SETTINGS ----------------------------------->
<cffunction name="getUPSSettings" output="No" hint="Returns a query with the list of UPS Settings." access="public">
	
	<cfset var qryUPSSettings = "">

	<cfquery name="qryUPSSettings" datasource="#Request.DS#" username="#Request.user#" 
	password="#Request.pass#" cachedwithin="#Request.Cache#">
		SELECT * FROM #Request.DB_Prefix#UPS_Settings
	</cfquery>
	
	<cfreturn qryUPSSettings>

</cffunction>

<!------------------------- USPS SETTINGS ----------------------------------->
<cffunction name="getUSPSSettings" output="No" hint="Returns a query with the list of USPS Settings." access="public">
	
	<cfset var qryUSPSSettings = "">

	<cfquery name="qryUSPSSettings" datasource="#Request.DS#" username="#Request.user#" 
	password="#Request.pass#" cachedwithin="#Request.Cache#">
		SELECT * FROM #Request.DB_Prefix#USPS_Settings
	</cfquery>
	
	<cfreturn qryUSPSSettings>

</cffunction>

<!------------------------- INTERSHIPPER SETTINGS ----------------------------------->
<cffunction name="getIntShipSettings" output="No" hint="Returns a query with the list of USPS Settings." access="public">
	
	<cfset var qryIntShipSettings = "">

	<cfquery name="qryIntShipSettings" datasource="#Request.DS#" username="#Request.user#" 
	password="#Request.pass#" cachedwithin="#Request.Cache#">
		SELECT * FROM #Request.DB_Prefix#Intershipper
	</cfquery>
	
	<cfreturn qryIntShipSettings>

</cffunction>

<!------------------------- CUSTOM SHIPPING SETTINGS ----------------------------------->
<cffunction name="getCustomSettings" output="No" hint="Returns a query with the list of custom shipping Settings." access="public">
	
	<cfset var qryCustomSettings = "">

	<cfquery name="qryCustomSettings" datasource="#Request.DS#" username="#Request.user#" 
	password="#Request.pass#" cachedwithin="#Request.Cache#">
		SELECT * FROM #Request.DB_Prefix#CustomShipSettings
	</cfquery>
	
	<cfreturn qryCustomSettings>

</cffunction>

<!------------------------- DROP SHIPPERS ----------------------------------->
<cffunction name="getDropShippers" output="No" hint="Returns a query with the list of drop shipper addresses." access="public">
	
	<cfset var qryDropShippers = "">

	<cfquery name="qryDropShippers" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT A.Account_ID, C.City, C.State, C.Zip, C.Country 
		FROM #Request.DB_Prefix#Account A, #Request.DB_Prefix#Customers C
		WHERE A.Customer_ID = C.Customer_ID
		AND A.Type1= 'vendor' 
	</cfquery>
	
	<cfreturn qryDropShippers>

</cffunction>


</cfcomponent>