<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<cfcomponent displayname="Intershipper Shipping Rates Tool" hint="This component is used for handling the Intershipper API for shipping rates." output="No">
<!--- This component developed by Mary Jo Sminkey maryjo@cfwebstore.com --->
<!--- This tag was developed using the XML Tools provided by Intershipper (intershipper.com) --->
<!--- Originally developed for use with CFWebstore e-commerce (www.cfwebstore.com) --->

<!--- Requires CFMX 6 or higher --->

<!--- This code is owned by Dogpatch Software and may not be distributes or reused without permission --->

<!--- Set Directory path for logs --->
<cfset variables.Directory = GetDirectoryFromPath(ExpandPath("*.*"))>
<cfset variables.Directory = variables.Directory & "logs" & Request.Slash>
<cfset variables.logfile = variables.Directory & "intershipper_log.txt">

<!--- Include logging functions --->
<cfinclude template="logging.cfm">

<!------------------------- COMPONENT INITIALIZATION ----------------------------------->
<cffunction name="init" access="public" output="no" returntype="intershipper">
    <cfreturn this>
  </cffunction>

<!------------------------- BEGIN ALL PACKAGES RATE FUNCTION ----------------------------------->
<cffunction name="getAllRates" returntype="struct" displayname="UPS rates for multiple shipments" hint="Retrieve UPS rates for multiple shipments and combine rates into one structure, by running the doUPSRate method for each shipper." output="No" access="public">

<!--- Required Attributes 
	ShipArray
	AddressInfo
	Username
	Password
--->
<!--- Optional Attributes
	Carriers
	ServiceClassese 
	Units
	Packaging
	Contents
	DeliveryType
	ShipMethod
	COD
	DeclaredValue
	Currency
	SortBy
	 
	timeout
	logging
	Debug (set to Yes or True to see output of request sent and full response received)
 --->
 
<!--- Returned Values --->
<!--- Success = 1 if rate returned, otherwise 0 --->
<!--- If Success, returns structure of the rates --->
<!--- If Error, returns ErrorMessage --->

<cfscript>
	//structure to hold the combined rates for the shippers 
	var IntRates = StructNew();
	var allResult = StructNew();
	var unmatchedRates = StructNew();
	var errorMessage = '';
	var debugstring = '';
	// loop counters
	var item = 0;
	var key = '';
	
	//Service names list
	var serviceNames = '';
	
	// For each shipper, retrieve the shipment rates
	var numshippers = ArrayLen(arguments.ShipArray);
	
	// structure to hold all other local vars
	var v = StructNew();	

	//add other necessary information to arguments scope
	StructInsert(arguments, "shipment", "");
	
</cfscript> 

	<cfloop index="item" from="1" to="#numshippers#">
		
	<cfscript>
		v.ItemStruct = arguments.ShipArray[item];

		//add the package to ship to the arguments collection
		StructUpdate(arguments, "shipment", v.ItemStruct);
		
		//rate structure for each shipment
		v.tempRates = StructNew();
		v.tempList = serviceNames;
		
		// Run the UPS request for this shipper 
		v.Result = doIntershipper(argumentcollection=arguments);

		//append debug string
		debugstring = debugstring & v.Result.debug;
		if (v.Result.Success and Item is 1) {
			//if first package, add rates to the structure
			StructAppend(IntRates, v.Result.Rates, "No");
			serviceNames = ListAppend(serviceNames, StructKeyList(v.Result.Rates));
			}
		else if (v.Result.Success) {
			//add rates to temporary structure
			StructAppend(v.tempRates, v.Result.Rates, "No");
		}
		else 
			errorMessage = v.Result.errormessage;
		
		// combine rates if more than one shipment
		if (StructCount(v.tempRates)) {					
			for (key IN v.tempRates) {
				if (StructKeyExists(IntRates, "#key#")) {
				IntRates[key] = IntRates[key] + v.tempRates[key];
				v.tempList = ListDeleteAt(v.tempList, ListFind(v.tempList, key));
				}
			}
			// after looping through all values, check for items that didn't have matches
			for (k=1; k lte ListLen(v.tempList); k=k+1) {
				StructInsert(unmatchedRates, ListGetAt(v.tempList, k), "0", "true");
			}
		}
		</cfscript>					

	</cfloop>
	
	<cfscript>
	//after processing all data, remove any rates that were missing matches
	if (NOT StructIsEmpty(unmatchedRates)) {
		for (key In unmatchedRates) {
			if (StructKeyExists(IntRates, "#key#"))
			StructDelete(IntRates, key);
		}
	}
	
	//if no rates left or error message returned, return error message	
	StructInsert(allResult, "Rates", IntRates);
	if (NOT StructIsEmpty(IntRates) AND NOT len(errorMessage)) {
		StructInsert(allResult, "Success", "1");
		StructInsert(allResult, "ErrorMessage", "");
	}
	else {
		StructInsert(allResult, "Success", "0");
		StructInsert(allResult, "ErrorMessage", errorMessage);
	}
	
	// add debug
	StructInsert(allResult, "debug", debugstring);
	
	</cfscript>		
	
	<!--- Add dump of final rates --->
	<cfif len(allResult.debug)>
		<cfsavecontent variable="v.adddebug">			
			<cfdump var="#arguments.ShipArray#">
			<cfoutput>#allResult.debug#</cfoutput>
			<cfdump var="#IntRates#">
		</cfsavecontent>
		<cfset allResult.debug =  v.adddebug>
	</cfif>
 
 	<cfreturn allResult>
 

</cffunction>


<!------------------------- END ALL PACKAGES RATE FUNCTION ----------------------------------->


<!------------------------- BEGIN INTERSHIPPER RATE REQUEST FUNCTION ----------------------------------->

<cffunction name="doIntershipper" returntype="struct" displayname="Retrieve Intershipper Rates" hint="This function sends a rate request to Intershipper and returns all the available rates." access="public" output="No">
<!--- Required Attributes 
	Username
	Password
	AddressInfo
	Shipment  --->
	
<!--- Optional Attributes
	Carriers
	ServiceClassese 
	Units
	Packaging
	Contents
	DeliveryType
	ShipMethod
	COD
	DeclaredValue
	Currency
	SortBy
	Timeout (max timeout for CF_HTTP request)
	Debug (set to Yes or True to see output of request sent and full response received)
 --->
 
 <!--- Returned Values --->
<!--- Success = 1 if rate returned, otherwise 0 --->
<!--- If Success, returns Postage --->
<!--- If Error, returns ErrorMessage --->

<cfargument name="userid" type="string" required="Yes" displayname="UserID" hint="Intershipper User ID for this merchant to access API.">
<cfargument name="int_password" type="string" required="Yes" displayname="Password" hint="Intershipper Password for this merchant to access API." >

<cfargument name="addressinfo" type="struct" required="Yes" displayname="Customer and Merchant address information" hint="The shipping and receiving address information." default="">

<cfargument name="Shipment" type="struct" required="Yes" displayname="Shipment Information" hint="An structure containing the information for the packages that will be shipped.">

<cfargument name="carriers" type="string" required="No" default="UPS" displayname="Carriers" hint="The shipping carriers to return rates for. Default is UPS.">
<cfargument name="ServiceClasses" type="string" required="No" default="GND" displayname="Service Classes" hint="The service classes to return rates for. Default is Ground (GND)."> 
<cfargument name="units" type="string" required="No" default="LBS/IN" displayname="Units of Measurement" hint="The units of measurement being used. Default setting is pounds and inches.">

<cfargument name="packaging" type="string" required="No" default="BOX" displayname="Packaging Type" hint="Type of packaging used for this shipment. Default is your own packaging.">
<cfargument name="contents" type="string" required="No" default="OTR" displayname="Package Contents" hint="Code for the type of package contents. Default is Other (OTR).">

<cfargument name="shipmethod" type="string" required="No" default="DRP" displayname="Shipment Method" hint="Shipment method used. Default is drop-off (DRP).">

<cfargument name="COD" default="No" type="boolean" required="No" displayname="COD" hint="Set if this is a COD shipment">
<cfargument name="DeclaredValue" default="0" type="numeric" required="No" displayname="Declared Value" hint="Set the decalred value of this shipment.">

<cfargument name="currency" type="string" required="No" default="USD" displayname="Currency" hint="Currency to be used for the rate lookup. Default is USD.">
<cfargument name="sortby" type="string" required="No" default="Rate" displayname="Sort By" hint="Sort method to use for rate reply. Default is by lowest to highest rates.">


<cfargument name="timeout" type="numeric" required="No" default="10" displayname="Tag Timeout" hint="Amount of time to allow before timing out the http request. Default is 10 seconds.">
<cfargument name="debug" type="boolean" default="no" displayname="Output Debug" hint="Toggles whether to display debug information or not.">
<cfargument name="logging" type="boolean" default="No" displayname="XML logging" hint="Sets whether to log the XML requests and responses.">

<CFSCRIPT>
// structure to hold all local vars 
var v = StructNew();
var temprequest = '';
var IntRates = StructNew();
var theResponse = StructNew();

var thePackages = arguments.Shipment.Packages;

v.CustomerAddr = arguments.AddressInfo;
v.MerchantAddr = arguments.Shipment.ShipFrom;

// common attribute validation
arguments.carriers = replace(arguments.carriers, ' ', '', 'ALL');
if (arguments.carriers IS "ALL")
	arguments.carriers = "FDX,USP,UPS,DHL";
if (arguments.ServiceClasses IS "ALL")
	arguments.ServiceClasses = "3DY,2DY,1DY,GND";
if (v.CustomerAddr.Residence) 
	v.deliverytype = 'RES';
else
	v.deliverytype = 'COM';
	
if (ListLen(arguments.units, "/") is 2) {
	v.unitofweight = ListGetAt(arguments.units, 1, "/");
	v.unitoflength = ListGetAt(arguments.units, 2, "/");
	}
else {
	v.unitofweight = "LBS";
	v.unitoflength = "IN";
}
	
if(val(arguments.timeout) LTE 0)
	arguments.timeout = 45;

// begin the request document 
temprequest = 'Version=2.0.0.0&ShipmentID=&QueryID=#Session.User_ID#';
temprequest = temprequest & '&Username=#arguments.userid#&Password=#arguments.int_password#';

// add the carriers
v.numCarriers = ListLen(arguments.carriers);
temprequest = temprequest & '&TotalCarriers=#v.numCarriers#';

for (c=1; c lte v.numCarriers; c=c+1) {
	temprequest = temprequest & '&CarrierCode#c#=#ListGetAt(arguments.carriers, c)#';
	temprequest = temprequest & '&CarrierAccount#c#=';
	temprequest = temprequest & '&CarrierInvoiced#c#=0';
}

// add the classes
v.numClasses = ListLen(arguments.ServiceClasses);
temprequest = temprequest & '&TotalClasses=#v.numClasses#';

for (d=1; d lte v.numClasses; d=d+1) {
	temprequest = temprequest & '&ClassCode#d#=#ListGetAt(arguments.ServiceClasses, d)#';
}

temprequest = temprequest & '&DeliveryType=#v.deliverytype#';
temprequest = temprequest & '&ShipMethod=#arguments.shipmethod#';

// add merchant address information
temprequest = temprequest & '&OriginationName=&OriginationAddress1=&OriginationAddress2=';
temprequest = temprequest & '&OriginationAddress3=&OriginationCity=&OriginationState=';
temprequest = temprequest & '&OriginationPostal=#v.MerchantAddr.Zip#';
temprequest = temprequest & '&OriginationCountry=#v.MerchantAddr.Country#';

// add customer address information
temprequest = temprequest & '&DestinationName=&DestinationAddress1=&DestinationAddress2=&DestinationAddress3=';
temprequest = temprequest & '&DestinationCity=#v.CustomerAddr.City#';
temprequest = temprequest & '&DestinationState=#v.CustomerAddr.State#';
temprequest = temprequest & '&DestinationPostal=#v.CustomerAddr.Zip#';
temprequest = temprequest & '&DestinationCountry=#v.CustomerAddr.Country#';

temprequest = temprequest & '&Currency=#arguments.currency#&ShippingDate=';
temprequest = temprequest & '&SortBy=#arguments.sortby#';

// add the package information
v.numshipments = ArrayLen(thePackages);
// counter for total packages
v.count = 0;


for (i=1; i lte v.numshipments; i=i+1) {
	// Output a package for each quantity in the array
	v.ItemStruct = thePackages[i];
	v.numboxes = v.ItemStruct.Quantity;
	for (x=1; x lte v.numboxes; x=x+1) {	
		v.count = v.count + 1;
		temprequest = temprequest & '&BoxID#v.count#=#v.count#';
		temprequest = temprequest & '&Weight#v.count#=#v.ItemStruct.weight#';
		temprequest = temprequest & '&WeightUnit#v.count#=#v.unitofweight#';
		if (v.ItemStruct.Pack_Length IS 0) {
			temprequest = temprequest & '&Length#v.count#=6';
			temprequest = temprequest & '&Width#v.count#=6';
			temprequest = temprequest & '&Height#v.count#=6';
		}
		else {
			temprequest = temprequest & '&Length#v.count#=#v.ItemStruct.Pack_Length#';
			temprequest = temprequest & '&Width#v.count#=#v.ItemStruct.Pack_Width#';
			temprequest = temprequest & '&Height#v.count#=#v.ItemStruct.Pack_Height#';
		}
		temprequest = temprequest & '&DimensionalUnit#v.count#=#v.unitoflength#';
		temprequest = temprequest & '&Packaging#v.count#=#arguments.packaging#';
		temprequest = temprequest & '&Contents#v.count#=#arguments.contents#';
		temprequest = temprequest & '&Cod#v.count#=#arguments.COD#';
		temprequest = temprequest & '&Insurance#v.count#=#arguments.DeclaredValue#';
		
	}

}

temprequest = temprequest & '&TotalPackages=#v.count#';

temprequest = temprequest & '&TotalOptions=0';

</CFSCRIPT>

<!--- Send the request --->
<cfhttp method="get" url="http://www.intershipper.com/Interface/Intershipper/XML/v2.0/HTTP.jsp?#temprequest#" resolveurl="false" timeout="#arguments.timeout#">  


<cfscript>

	try {
		v.IntshipResponse = XmlParse(Trim(CFHTTP.FileContent));
		theResponse = v.IntshipResponse.XmlRoot;
	
		if (NOT isDefined("theResponse.Error"))
			{
			IntRates.success = 1;
			IntRates.error = '';
			//create an structure to hold the returned rates
			IntRates.Rates = StructNew();
			v.serviceList = '';
			v.unmatchedRates = StructNew();
			// retrieve the package information
			v.Packages = XMLSearch(theResponse, "package");
			//loop through each included package
			v.NumPackages = ArrayLen(v.Packages);
			for (i=1; i lte v.NumPackages; i=i+1) {
				// list used to check for matches, not used for first group of rates
				v.tempList = v.serviceList;
				//add each returned rate to the array
				v.thePackage = v.Packages[i];
				//extract the rate information
				v.returnedRates = XMLSearch(v.thePackage, "quote");
				v.NumRates = ArrayLen(v.returnedRates);
				// reverse loop to account for deleted services			
				for (j=v.NumRates; j gt 0; j=j-1) {
					v.ServiceCode = Evaluate("v.returnedRates[j].service.code.XmlText");
					v.RateCost = Evaluate("v.returnedRates[j].rate.amount.XmlText");
					v.RateCost = (v.RateCost/100);
					if (i is 1) {
						v.serviceList = ListPrepend(v.serviceList, v.ServiceCode);
						StructInsert(IntRates.Rates, v.ServiceCode, v.RateCost);
					}
					else {
						v.valueinList = ListFind(v.tempList, v.ServiceCode);
						if (v.valueinList) {
							IntRates.Rates[v.ServiceCode] = IntRates.Rates[v.ServiceCode] + v.RateCost;
							v.tempList = ListDeleteAt(v.tempList, v.valueinList);
						}		
					}
				}		
				// after looping through all values, check for items that didn't have matches
				for (k=1; k lte ListLen(v.tempList); k=k+1) {
					StructInsert(v.unmatchedRates, ListGetAt(v.tempList, k), "0", "true");
				}
			}			
			//after processing all data, remove any rates that were missing matches
				if (StructCount(v.unmatchedRates)) {
					for (key In v.unmatchedRates) {
					if (StructKeyExists(IntRates.Rates, "#key#"))
						StructDelete(IntRates.Rates, key);
					}
				}
		}
		else
		{
			IntRates.success = 0;
			IntRates.errormessage = theResponse.Error.XmlText;
		}
	}
		
	catch(Any excpt) {
		IntRates.success = 0;
		IntRates.errormessage = 'Invalid response received from Intershipper. #CFHTTP.FileContent#';		
	}
	
</cfscript>

<!--- Debugging Output --->
<cfif arguments.debug>
	<cfsavecontent variable="v.debug">
		<cfoutput>
		<H4>Request</H4>#htmleditformat(ToString(temprequest))#<br />
		<H4>Response</H4>#htmleditformat(Replace(CFHTTP.FileContent,">", ">#Chr(10)#", "ALL"))# 
		</cfoutput>
		<cfdump var="#theResponse#">
		<cfdump var="#IntRates#"> 
	</cfsavecontent>
	<cfset IntRates.debug = v.debug>
<cfelse>
	<cfset IntRates.debug = "">
</cfif>
	
<!--- Log files --->
<cfscript>
	if (arguments.logging) {
		LogXML('#tostring(temprequest)#', '#variables.logfile#', 'Request Sent');
		LogXML('#CFHTTP.FileContent#', '#variables.logfile#', 'Response Received');
	}
</cfscript>

<cfreturn IntRates>


</cffunction>
<!------------------------- END INTERSHIPPER RATE REQUEST FUNCTION ----------------------------------->


</cfcomponent>