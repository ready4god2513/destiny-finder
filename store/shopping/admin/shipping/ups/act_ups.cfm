<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to save the UPS Settings for the store. Called by shopping.admin&shipping=ups --->

<!--- Determine Customer Class --->
<cfswitch expression="#attributes.Pickup#">
	<cfcase value="01">
		<!--- Wholesale --->
		<cfset CustomerClass = '01'>
	</cfcase>
	<cfcase value="03">
		<!--- Occasional --->
		<cfset CustomerClass = '03'>
	</cfcase>
	<cfdefaultcase>
		<!--- Retail --->
		<cfset CustomerClass = '04'>
	</cfdefaultcase>
</cfswitch>

<cfquery name="UpdUPS" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
UPDATE #Request.DB_Prefix#UPS_Settings
SET MaxWeight = #attributes.MaxWeight#,
UnitsofMeasure = '#attributes.UnitsofMeasure#',
Pickup = '#attributes.Pickup#',
CustomerClass = '#CustomerClass#',
Packaging = '#attributes.Packaging#',
OrigZip = '#attributes.OrigZip#',
OrigCity = '#attributes.OrigCity#',
OrigCountry = '#attributes.OrigCountry#',
Origin = '#attributes.Origin#',
UseAV = #attributes.UseAV#,
Logging = #attributes.Logging#,
Debug = #attributes.Debug#
</cfquery>

<!--- Update Cached Settings --->
<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
<cfset Application.objShipping.getUPSSettings()>

<!--- Refresh cached Query for UPS shipping methods, using new origin --->
<cfinclude template="act_refresh_queries.cfm">

