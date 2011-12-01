<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is called by the shopping.tracking fuseaction and used to process the order tracking form for UPS Tracking. --->


<cfscript>
function ReturnDate(string) {
	datestring = Mid(string, 5, 2) & "/" & Right(string, 2) & "/" & Left(string, 4);
	return datestring;
}
</cfscript>

<cfscript>
function ReturnTime(string) {
	timestring = Left(string, 2) & ":" & Mid(string, 3, 2) & ":" & Right(string, 2);
	timestring = TimeFormat(timestring, "h:mm tt");
	return timestring;
}
</cfscript>



<cfif isDefined("attributes.submit_tracking")>

	<cfif NOT len(attributes.ordernum) OR NOT len(attributes.zipcode)>
		<cfset attributes.message = "Please enter both the order number and the billing zipcode for the order.">
	<cfelseif NOT isDefined("attributes.Agree")>
		<cfset attributes.message = "You must agree to the Terms and Conditions to track your order.">
	<cfelseif NOT IsNumeric(attributes.ordernum)>
		<cfset attributes.message = "Please enter a valid order number.">
	<!--- Form submission okay, check for order information --->
	<cfelse>
	
		<cfset attributes.Shipper = "UPS">
		<cfinclude template="../../../queries/qry_get_tracking.cfm">
		<!--- Check and make sure order was found, zip code was correct, shipper was UPS, and tracking information correct --->
		<cfif NOT qry_get_tracking.recordcount AND NOT qry_get_PO_tracking.recordcount>
			<cfset attributes.message = "Sorry, no UPS tracking information was found for this order.">
			
		<cfelseif NOT len(qry_get_tracking.Tracking) AND NOT len(qry_get_PO_tracking.Tracking)>
			<cfset attributes.message = "Sorry, no tracking information was found for this order.">
			
		<cfelseif Left(qry_get_tracking.zip, 5) IS NOT Left(attributes.zipcode, 5)>
			<cfset attributes.message = "Please enter a valid order number/billing zip code combination.">
			
		<cfelseif qry_get_tracking.Shipper IS NOT 'UPS' AND NOT qry_get_PO_tracking.recordcount>
			<cfset attributes.message = "Sorry, no UPS tracking information was found for this order.">
			
		<cfelse>
			<!--- UPS tracking information found, so submit the tracking request to UPS --->
			
		<!--- Get UPS Settings --->
		<cfset GetUPS = Application.objShipping.getUPSSettings()>
		
		<!--- 		Accesskey="2BCD38E6A412D22A"
			Username="maryjo313"
			Password="4tazntosh" --->
			
			<cfset ShipNumber = 0>
			<cfset trackingNums = ValueList(qry_get_PO_tracking.Tracking)>
			<cfset trackingNums = ListAppend(trackingNums, qry_get_tracking.Tracking)>
			
			<cfloop index="trackingnum" list="#trackingNums#">
			
			<cfset ShipNumber = ShipNumber + 1>
			
				<!--- Get UPS Tracking Information --->
				<cfinvoke component="#Request.CFCMapping#.shipping.upstools" 
					returnvariable="Result" method="getTracking"
					UserID="#GetUPS.username#"
					Accesskey="#GetUPS.accesskey#"
					UPSPassword="#GetUPS.password#"
					TrackingNumber="#trackingnum#"
					debug="#YesNoFormat(GetUPS.Debug)#"
					logging="#YesNoFormat(GetUPS.Logging)#">
					
				<!--- Output debug if returned --->
				<cfif len(Result.Debug)>
					<cfinvoke component="#Request.CFCMapping#.global" method="putDebug" debugtext="#Result.Debug#">
				</cfif>
			
			<cfif Result.Success>
				<cfinclude template="put_tracking.cfm">
				<cfset ShowTracking = "Yes">
			
			<cfelse>
				<cfset attributes.message = Result.errormessage>
				<cfinclude template="put_trackingerror.cfm">
			</cfif>			
			
			</cfloop>
		
		</cfif>
		
	
	</cfif>
</cfif>