<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to save the FedEx Settings for the store. Called by shopping.admin&shipping=fedex --->

<cfparam name="attributes.UseGround" default="0">
<cfparam name="attributes.UseExpress" default="0">

<cfquery name="UpdFedEx" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
UPDATE #Request.DB_Prefix#FedEx_Settings
SET MaxWeight = #attributes.MaxWeight#,
UnitsofMeasure = '#attributes.UnitsofMeasure#',
Dropoff = '#attributes.Dropoff#',
AccountNo = '#attributes.AccountNo#',
Packaging = '#attributes.Packaging#',
OrigZip = '#attributes.OrigZip#',
OrigState = '#attributes.OrigState#',
OrigCountry = '#attributes.OrigCountry#',
UseGround = #attributes.UseGround#,
UseExpress = #attributes.UseExpress#,
Logging = #attributes.Logging#,
Debug = #attributes.Debug#
</cfquery>

<!--- Update Cached Settings --->
<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
<cfset Application.objShipping.getFedExSettings()>



