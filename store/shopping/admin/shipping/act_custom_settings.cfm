<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to save the Custom Shipping Settings for the store. Called by shopping.admin&shipping=customsettings --->

<cfquery name="UpdCustom" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
UPDATE #Request.DB_Prefix#CustomShipSettings
SET ShowShipTable = #attributes.ShowShipTable#,
MultPerItem = #attributes.MultPerItem#,
CumulativeAmounts = #attributes.CumulativeAmounts#,
MultMethods = #attributes.MultMethods#,
Debug = #attributes.Debug#
</cfquery>

<!--- Update Cached Settings --->
<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
<cfset Application.objShipping.getCustomSettings()>



