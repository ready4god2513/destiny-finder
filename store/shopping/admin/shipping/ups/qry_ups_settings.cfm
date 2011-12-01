<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Displays the form to update the UPS Settings for the store. Called by shopping.admin&shipping=ups and shopping.admin&shipping=settings --->

<cfquery name="GetUPS" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
SELECT * FROM #Request.DB_Prefix#UPS_Settings
</cfquery>

<cfquery name="GetUPSPickup" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#UPS_Pickup
</cfquery>

<cfquery name="GetUPSPackages" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#UPS_Packaging
</cfquery>

<cfquery name="GetUPSOrigins" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#UPS_Origins
ORDER BY OrderBy
</cfquery>

