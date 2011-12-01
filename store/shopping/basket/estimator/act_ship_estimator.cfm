
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This template is used to calculate an estimated shipping cost for the shopping cart. Called by fuseaction=shopping.basket --->
<!--- This page should be called before put_ship_estimator.cfm --->
	

<cfif ShipSettings.ShowEstimator>

	<!--- Get the table of active shipping methods --->
	<cfset qryMethods = Application.objShipping.getShipMethods(ShipSettings.ShipType)>
	
	<cfset refresh_vars = "yes">
	<cfinclude template="../../checkout/act_get_checkout_vars.cfm">

	<cfparam name="attributes.est_zipcode" default="">
	<cfparam name="attributes.est_shipmethod" default="">
	<cfparam name="attributes.est_shipstate" default="">
	<cfparam name="theID" default="">
	<cfparam name="attributes.est_shipcountry" default="#Request.AppSettings.HomeCountry#">

	<cfscript>
		// Check if the shipping method choice and zip has been saved in memory
		if (NOT len(attributes.est_shipmethod) AND isDefined("Session.EstShipping")) {
			attributes.est_zipcode = Session.EstShipping.Zipcode;
			attributes.est_shipmethod = Session.EstShipping.ShipMethod;
			attributes.est_shipstate = Session.EstShipping.ShipState;
			attributes.est_shipcountry = Session.EstShipping.ShipCountry;
		}
		
		//If no shipping methods, set so custom shipping will work
		else if (NOT qryMethods.Recordcount) {
			attributes.est_zipcode = "99999";
			attributes.est_shipmethod = "999^Standard Shipping";
		}
		
		//If custom shipping method, display a default shipping amount
		else if (NOT len(attributes.est_shipmethod) AND ListFind("Price,Price2,Weight,Weight2,Items",ShipSettings.ShipType)) {
			attributes.est_zipcode = "99999";
			attributes.est_shipmethod = "#qryMethods.ID[1]#^#qryMethods.Name[1]#";
		}
	
		EstShipping = StructNew();
		EstShipping.Zipcode = attributes.est_zipcode;
		EstShipping.ShipMethod = attributes.est_shipmethod;
		EstShipping.ShipState = attributes.est_shipState;
		EstShipping.ShipCountry = attributes.est_shipcountry;
	</cfscript>
	
	<!--- Save current values back to the session --->
	<cfset Session.EstShipping = EstShipping>
	
	<!--- Determine location --->
	<cfscript>
	if (CompareNoCase(attributes.est_shipcountry, Request.AppSettings.HomeCountry) IS 0) 
		ShipLocation = "Domestic";
	else
		ShipLocation = "International";
	
	// Set freight costs for domestic or international
	if (Compare(ShipLocation, "Domestic") IS 0)
		TotalFreight = FreightCost.Domestic;
	else
		TotalFreight = FreightCost.Intl;
	</cfscript>
	
	<!--- Continue if information found --->
	<cfif len(attributes.est_zipcode) AND ListLen(attributes.est_shipmethod, "^") GT 1>
	
		<cfset theMethod = ListGetAt(attributes.est_shipmethod, 2, "^")>
		<cfset theID = ListGetAt(attributes.est_shipmethod, 1, "^")>
		
		<cfif TotalShip IS NOT 0>
		
			<!--- load temporary tables --->
			<cfinclude template="../../checkout/customer/act_newcustomer.cfm">	
			
			<!--- Update the temporary user tables with the selected zip code --->
			<cfquery name="UpdCustomer" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#TempCustomer 
			SET Zip = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.est_zipcode#">,
			State = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.est_shipstate#">,
			Country = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.est_shipcountry#">
			WHERE TempCust_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
			</cfquery>
			
			<cfquery name="UpdShipTo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#TempShipTo 
			SET Zip = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.est_zipcode#">,
			State = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.est_shipstate#">,
			Country = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.est_shipcountry#">
			WHERE TempShip_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
			</cfquery>
			
			<!--- get customer queries --->
			<cfinclude template="../../checkout/customer/qry_get_tempcustomer.cfm">
			<cfinclude template="../../checkout/customer/qry_get_tempshipto.cfm">
			
			<!--- Calculate the shipping rate --->
			<cfswitch expression="#ShipSettings.ShipType#">
				
				<cfcase value="FedEx">
					<cfinclude template="act_fedex.cfm">
				</cfcase>
				
				<cfcase value="UPS">
					<cfinclude template="act_upstools.cfm">
				</cfcase>
				
				<cfcase value="USPS">
					<cfinclude template="act_uspostal.cfm">
				</cfcase>
				
				<cfcase value="Intershipper">
					<cfinclude template="act_intershipper.cfm">
				</cfcase>
				
				<cfcase value="Price,Price2,Weight,Weight2,Items">
					<cfinclude template="act_custom.cfm">
				</cfcase>
	
			</cfswitch>		
			
			<!--- If a shipping amount was returned, add the handling percentage and base rate --->
			<cfif isDefined("est_shipamount")>
			
				<!--- Check if this is a free shipping amount --->
				<cfif Session.CheckoutVars.TotalBasket GT ShipSettings.freeship_min 
					AND listFind(ShipSettings.freeship_ShipIDs,theID)>
					<cfset est_shipamount = 0>
				<cfelse>
					<cfset est_handling = Session.CheckoutVars.TotalCost * ShipSettings.ShipHand>
					<cfset est_shipamount = est_shipamount + ShipSettings.ShipBase + est_handling>
					<cfset est_shipamount = Round(est_shipamount*100)/100>
				</cfif>
				
			</cfif>
		
		<cfelse>
			<!--- TotalShip IS 0 --->
			<cfset est_shipamount = 0>
			
		
		</cfif>
	
	</cfif>	

</cfif>

<!--- If store is set to combine shipping and freight, add freight amount --->
<cfif isDefined("est_shipamount") AND NOT ShipSettings.ShowFreight AND TotalFreight IS NOT 0>
	<cfset est_shipamount = est_shipamount + TotalFreight>
	<cfset TotalFreight = 0>
</cfif>
		



