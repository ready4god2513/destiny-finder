<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Updates the Intershipper settings. Called by shopping.admin&shipping=intershipper --->

<cfif ListFind(attributes.Carriers,"ALL")>
	<cfset Carriers = "ALL">
<cfelse>
	<cfset Carriers = attributes.Carriers>
</cfif>

<cfif ListFind(attributes.Classes,"ALL")>
	<cfset Classes = "ALL">
<cfelse>
	<cfset Classes = attributes.Classes>
</cfif>

<cfquery name="UpdIntership" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
UPDATE #Request.DB_Prefix#Intershipper
SET MaxWeight = #attributes.MaxWeight#,
UnitsofMeasure = '#attributes.UnitsofMeasure#',
Carriers = '#Carriers#',
Classes = '#Classes#',
UserID = '#Trim(attributes.UserID)#',
Password = '#Trim(attributes.Password)#',
Pickup = '#attributes.Pickup#',
MerchantZip = '#attributes.MerchantZip#',
Logging = #attributes.Logging#,
Debug = #attributes.Debug#
</cfquery>

<!--- Update Cached Settings --->
<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
<cfset Application.objShipping.getIntShipSettings()>

