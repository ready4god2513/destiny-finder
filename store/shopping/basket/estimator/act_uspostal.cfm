<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Sofware may be contacted at info@cfwebstore.com --->

<!--- This page is used to estimate a USPS shipping rate. Calls the USPS API to determine the selected rate and returns it to the calculator. Called from shopping/basket/act_ship_estimator.cfm  --->

<cfscript>
	thisType = "USPS";
	
	// Get UPS Settings
	GetUSPS = Application.objShipping.getUSPSSettings();
	
	MerchantInfo = StructNew();
	MerchantInfo.Zip = GetUSPS.Merchantzip;
	MerchantInfo.Country = "US^United States";
	
	//Create the structure with customer address information
	AddressInfo = Application.objCheckout.doAddresses(GetCustomer,GetShipTo);	

</cfscript>

<cftry>
	<!--- Create the array of shippers and packages --->
	<cfset ShippingData = Application.objShipping.doShippingData(MerchantInfo, GetUSPS.MaxWeight)>
	
	<cfcatch type="DropShipError">
		<cfset est_shipping = "no">
	</cfcatch>

</cftry>

<!--- Continue if no errors so far --->
<cfif NOT isDefined("est_shipping")>

	
	<!--- Determine whether to run domestic or international rates --->
	<cfif AddressInfo.Country IS "US">
		<cfset ratetype = "Domestic">
	<cfelse>
		<cfset ratetype = "International">
	
		<!--- Get USPS Country Name --->
		<cfquery name="USPScountry" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
			SELECT Name FROM #Request.DB_Prefix#USPSCountries 
			WHERE Abbrev = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#AddressInfo.Country#">
		</CFQUERY>
			<cfset AddressInfo.Country = iif(USPSCountry.RecordCount, "USPScountry.Name", DE("NotFound"))>
	</cfif>
	
	<!--- Run the USPS request --->
	<cfinvoke component="#Request.CFCMapping#.shipping.uspostal" 
		returnvariable="Result" method="getAllRates"
		userid="#GetUSPS.Userid#" 
		server="#GetUSPS.Server#" 
		AddressInfo="#AddressInfo#"
		ShipArray="#ShippingData#"
		logging="#YesNoFormat(GetUSPS.Logging)#"
		debug="#YesNoFormat(GetUSPS.Debug)#">
	
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


