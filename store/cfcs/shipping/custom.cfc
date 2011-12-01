<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<cfcomponent displayname="Custom Shipping Tool" hint="This component is used for calculating custom shipping rates." output="No">
<!--- This component developed by Mary Jo Sminkey maryjo@cfwebstore.com --->
<!--- This tag was developed using the XML Tools provided by U.S.P.S. --->
<!--- Originally developed for use with CFWebstore e-commerce (www.cfwebstore.com) --->

<!--- Requires CFMX 6 or higher --->

<!--- This code is owned by Dogpatch Software and may not be distributes or reused without permission --->

<!------------------------- COMPONENT INITIALIZATION ----------------------------------->
<cffunction name="init" access="public" output="no" returntype="custom">
    <cfreturn this>
  </cffunction>

<!------------------------- BEGIN CUSTOM SHIPPING RATES FUNCTION ----------------------------------->

<cffunction name="doCustomRates" returntype="struct" displayname="Calculate Custom Shipping Rates" hint="This function checks for records in the shipping and country tables and then creates rates using the selected methods" access="public" output="No">
<!--- Required Attributes 
	TotalShip
	ShipType
	ShipLocation
	AddressInfo
	Methods  --->
	
<!--- Returned Values --->
<!--- Success = 1 if rates returned, otherwise 0 --->
<!--- If Success, returns struct of rates --->
<!--- If Error, returns ErrorMessage --->


<cfargument name="ShipType" type="string" required="Yes" hint="Type of custom shipping used.">
<cfargument name="ShipLocation" type="string" required="Yes" hint="Setting for whether shipping is local or domestic.">

<cfargument name="AddressInfo" type="struct" required="Yes" hint="Customer and Merchant address information">
<cfargument name="TotalShip" type="numeric" required="No" default="0" hint="Total amount used to calculate shipping">
<cfargument name="Methods" type="query" required="Yes" displayname="Methods" hint="An array containing the list of shipping methods.">

<cfargument name="MultPerItem" type="boolean" required="No" default="Yes" hint="Used for shipping by item, to determine whether to multiply the item amounts by the shipping amount.">
<cfargument name="CumulativeAmounts" type="boolean" required="No" default="No" hint="Used for shipping by item, sets if the amounts in the shipping table are cumulative.">
<cfargument name="MultMethods" type="boolean" required="No" default="No" hint="Sets whether the shipping methods multiply the shipping total, or are added to it.">

<cfscript>
	var CustomRates = StructNew();
	var CustomerAddr = arguments.addressinfo;
	var ShipAmount = 0;	
	// queries 
	var getMethods = '';
	var calcShipping = '';
	var getCumAmounts = '';
	var GetCountryInfo = '';
	// loop counter 
	var i = 0;
	// structure to hold all other local vars
	var v = StructNew();
	
</cfscript>

<!--- Get subset of shipping methods --->
<cfquery name="getMethods" dbtype="query">
	SELECT * FROM arguments.Methods
	WHERE #arguments.ShipLocation# <> 0
	ORDER BY Priority
</cfquery>

<!--- Retrieve starting amount from shipping table --->
<cfquery name="calcShipping" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
	SELECT  MinOrder, Amount FROM #Request.DB_Prefix#Shipping 
	WHERE (MinOrder <= <cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#arguments.TotalShip#">) 
	AND (MaxOrder >= <cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#arguments.TotalShip#">)
</cfquery>


<!--- If cost found in table, set shipcost --->
<cfif calcShipping.RecordCount>
	<cfscript>
		ShipAmount = calcShipping.Amount;
		// Determine shipping, if using percentage rate or by quantity
		if (ListFind('Price2,Weight2',arguments.ShipType))
			ShipAmount = ShipAmount * arguments.TotalShip;
		//If shipping rates by item, first see if the amount is multiplied by number of items
		//If it is and using cumulative rates, only multiply by the number of items in this particular range
		else if (arguments.ShipType IS "Items" AND arguments.MultPerItem AND arguments.CumulativeAmounts)
			ShipAmount = ShipAmount * (arguments.TotalShip - calcShipping.MinOrder + 1);
		else if (arguments.ShipType IS "Items" AND arguments.MultPerItem)
			ShipAmount = ShipAmount * arguments.TotalShip;
	</cfscript>
	
	<!--- If shipping by item and cumulative, get all the lower amounts and include them as well --->
	<cfif arguments.ShipType IS "Items" AND arguments.CumulativeAmounts>
		<cfquery name="getCumAmounts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Amount, MaxOrder, MinOrder FROM #Request.DB_Prefix#Shipping 
		WHERE MaxOrder < <cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#arguments.TotalShip#">
		</cfquery>
				
		<cfloop query="getCumAmounts">
			<cfif arguments.MultPerItem>
				<cfset ShipAmount = ShipAmount + (getCumAmounts.Amount * (getCumAmounts.MaxOrder-getCumAmounts.MinOrder+1))>
			<cfelse>
				<cfset ShipAmount = ShipAmount + getCumAmounts.Amount>
			</cfif>
		</cfloop>
	
	</cfif>

	<cfquery name="GetCountryInfo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
		SELECT AddShipAmount FROM #Request.DB_Prefix#Countries 
		WHERE Abbrev = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ListGetAt(CustomerAddr.Country, 1, "^")#">
		AND Shipping <> 0
	</cfquery>
	
	<cfif GetCountryInfo.Recordcount IS 0>
		<cfset CustomRates.Success = 0>
	<cfelse>
		<cfscript>
		// Continue with the rate calculations 
		ShipAmount = ShipAmount + (ShipAmount * GetCountryInfo.AddShipAmount);
		CustomRates.Success = 1;
		CustomRates.Rates = StructNew();
		// If no shipping methods, add the final base rate to the shipping rate structure 
		if (arguments.Methods.RecordCount IS 0) 
			StructInsert(CustomRates.Rates, "Standard Shipping", ShipAmount);
		// If using shipping methods, make sure there is at least one for this location
		else if (getMethods.RecordCount IS 0) 
			CustomRates.Success = 0;
		else {
			for (i=1; i LTE getMethods.RecordCount; i=i+1) {
				//determine whether to multiply or add the shipping method amount
				if (arguments.MultMethods) {
					v.thisAmount = ShipAmount * getMethods.Amount[i];
				}
				else {
					v.thisAmount = ShipAmount + getMethods.Amount[i];
				}
				StructInsert(CustomRates.Rates, getMethods.Name[i],v.thisAmount);				
			}
		
		}
		</cfscript>
		
	</cfif>
		
<cfelse>
	<!--- No record in the shipping table found --->
	<cfset CustomRates.Success = 0>
</cfif>

<!--- Debugging Output --->
<cfif arguments.debug>
	<cfsavecontent variable="v.debugstring">
		<cfoutput>
			<cfdump var="#CustomRates#">
		</cfoutput>
	</cfsavecontent>
	<cfset CustomRates.debug = v.debugstring>
<cfelse>
	<cfset CustomRates.debug = "">
</cfif>

<cfreturn CustomRates>


</cffunction>
<!------------------------- END CUSTOM SHIPPING RATES FUNCTION ----------------------------------->

</cfcomponent>