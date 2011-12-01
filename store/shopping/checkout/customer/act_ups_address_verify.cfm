<!--- CFWebstore®, version 5.63 --->

<!--- CFWebstore® is ©Copyright 1998-2004 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Sofware may be contacted at info@cfwebstore.com --->

<!--- This page is used to run the address verification for UPS. Called from do_checkout.cfm  --->

<cfscript>
if (NOT attributes.ShipToYes) {
	checkcity = attributes.City_shipto;
	checkstate = attributes.State_shipto;
	checkzip = attributes.Zip_shipto;
	checkcountry = ListGetAt(attributes.Country_shipto, 1, "^");
}
else {
	checkcity = attributes.City;
	checkstate = attributes.State;
	checkzip = attributes.Zip;
	checkcountry = ListGetAt(attributes.Country, 1, "^");
}
</cfscript>

<cfset GetUPS = Application.objShipping.getUPSSettings()>

<cfif GetUPS.UseAV AND checkcountry IS "US">

	<cfinvoke component="#Request.CFCMapping#.shipping.upstools" 
		returnvariable="Result" method="VerifyAddress"
		UserID="#GetUPS.Username#"
		Accesskey="#GetUPS.Accesskey#"
		UPSPassword="#GetUPS.Password#"
		City="#checkcity#"
		State="#checkstate#"
		Zipcode="#checkzip#"
		debug="#YesNoFormat(GetUPS.Debug)#">
		
		<!--- Output debug if returned --->
		<cfif len(Result.Debug)>
			<cfinvoke component="#Request.CFCMapping#.global" method="putDebug" debugtext="#Result.Debug#">
		</cfif>

<cfscript>

	if (Result.Success AND Result.ValidAddress)
		addressOK = 'yes';
	else if (Result.Success) {
		addressOK = 'no';	
		Message = 'The address entered is not a valid shipping address. <br/>Suggested city/state/zip combinations:';
		//create the list of available addresses.
		//Message = Message & "<table><tr><td class='formerror'><ul>";
		Message = Message & "<br/><br/><form><select size='3' name='addresses' class='formerror'>";
		NumAdds = ArrayLen(Result.Addresses);
		for (x=1; x LTE NumAdds; x=x+1) {
		Message = Message & "<option>#Result.Addresses[x].City#, #Result.Addresses[x].State# #Result.Addresses[x].Zip#</option>";
		//Message = Message & "<li>#Result.Addresses[x].City#, #Result.Addresses[x].State# #Result.Addresses[x].Zip#</li>";
		}
		//Message = Message & "</ul></td></tr></table>";
		Message = Message & "</select></form>";
	}
	else {
		addressOK = 'no';	
		Message = Result.errormessage;
		}

</cfscript>

<cfelse>
	
	<cfset addressOK = 'yes'>
			
</cfif>