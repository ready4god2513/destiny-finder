<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page is called by the shopping.tracking fuseaction and used to display the tracking information for the order for UPS Tracking. --->

<!--- <cfdump var="#Result#"> --->

<!--- Get Service from list of UPS Methods --->
<cfset qryUPSMethods = Application.objShipping.getUPSMethods()>

<cfquery name="GetService" dbtype="query">
SELECT Name FROM qryUPSMethods
WHERE Code = '#Right(Result.Service, 2)#'
</cfquery>			

<cfmodule template="../../../customtags/format_output_box.cfm"
box_title="UPS OnLine<sup>&reg;</sup> Tools Tracking - Shipment ###ShipNumber#"
width="500"
align="left"
>

<!--- Determine status of shipment --->
<cfoutput>
<table width="100%">
<tr align="left"> 
<td class="trackbold" width="10%" nowrap="nowrap">UPS Tracking Number:</td>
<td class="track" nowrap="nowrap">#Result.TrackNumber#</td>
</tr>
<tr align="left"> 
<td class="trackbold" nowrap="nowrap">Service Type:</td>
<td class="track" nowrap="nowrap">#GetService.Name#</td>
</tr>
<cfif IsDefined("Result.Weight")>
	<tr align="left"> 
	<td class="trackbold">Weight:</td>
	<td class="track">#Result.Weight# #Result.WeightUnit#</td>
	</tr>
</cfif>
<tr> 
<td colspan="2">&nbsp;</td>
</tr>
<cfif IsDefined("Result.Address.City")>
	<tr align="left"> 
	<td class="trackbold" nowrap="nowrap">Shipped To:</td>
	<td class="track">#Result.Address.City.XMLText#<cfif isDefined("Result.Address.StateProvinceCode")>, #Result.Address.StateProvinceCode.XMLText#</cfif>, #Result.Address.CountryCode.XMLText#</td>
	</tr>
</cfif>
<cfif IsDefined("Result.PickupDate")>
	<tr align="left"> 
	<td class="trackbold" nowrap="nowrap">Shipped or Billed on:</td>
	<td class="track">#ReturnDate(Result.PickupDate)#</td>
	</tr>
</cfif>
<cfif IsDefined("Result.ScheduledDeliveryDate")>
	<tr align="left"> 
	<td class="trackbold">Scheduled Delivery:</td>
	<td class="track">#ReturnDate(Result.ScheduledDeliveryDate)#</td>
	</tr>
</cfif>	
<cfif IsDefined("Result.Packages")>
	<tr align="left"> 
	<td class="trackbold">Packages:</td>
	<td class="track">#ArrayLen(Result.Packages)#</td>
	</tr>
</cfif>	
<tr> 
<td colspan="2">&nbsp;</td>
</tr>
</table>

<cfif IsDefined("Result.Packages")>
<cfloop index="x" from="1" to="#ArrayLen(Result.Packages)#">

	<table width="100%" cellpadding="5" cellspacing="0">
	<tr align="left">
	<th class="track">Location</th><th class="track">Date</th><th class="track">Local Time</th><th class="track">Activity</th>
	</tr>
	<cfscript>
	NumActivity = ArrayLen(Result.Packages[x].Activity);
	lastLocation = "";
	currclass = 1;
	</cfscript>
	<cfloop index="i" from="1" to="#NumActivity#">
	<cfscript>
		printLocation = '';
		currArray = Result.Packages[x].Activity[i];
		theAddress = currArray.ActivityLocation.Address;
		currLocation = "";
		if (isDefined("theAddress.City"))
		currLocation = theAddress.City.XMLText & ", ";
		if (isDefined("theAddress.StateProvinceCode"))
		currLocation = currLocation & theAddress.StateProvinceCode.XMLText & ", ";
		currLocation = currLocation & theAddress.CountryCode.XMLText;
		if (lastLocation IS NOT currLocation) {
			currclass = currclass + 1;
			printLocation = currLocation;
		}
		tagclass = currclass MOD 2;
		lastLocation = currLocation;
	</cfscript>
	<!--- <cfdump var="#theAddress#"> --->
	<cfset Status = currArray.Status.StatusType.Description.XMLText>
	<tr align="left">
	<td class="track#tagclass#">#printLocation#</td>
	<td class="track#tagclass#">#ReturnDate(currArray.Date.XMLText)#</td>
	<td class="track#tagclass#">#ReturnTime(currArray.Time.XMLText)#</td>
	<td class="track#tagclass#">#Status#
	<cfif isDefined("currArray.ActivityLocation.Description") AND Status IS "DELIVERED"><br/>Package Left at #currArray.ActivityLocation.Description.XMLText#</cfif>
	</td>
	</tr>
	</cfloop>
	</table>


</cfloop>
</cfif>

</cfoutput>


</cfmodule><br/>