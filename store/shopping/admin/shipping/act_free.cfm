<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Updates the information for the free shipping promotion. Called by shopping.admin&shipping=free --->

<cfparam name="attributes.freeship_shipids" default="">

<cfif NOT len(Trim(attributes.freeship_min))>
	<cfset freeship_min = 0>
<cfelse>
	<cfset freeship_min = attributes.freeship_min> 
</cfif>



<cfquery name="UpdShipsettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
UPDATE #Request.DB_Prefix#ShipSettings
SET Freeship_Min = #freeship_min#,
Freeship_ShipIDs = '#attributes.freeship_shipids#'
</cfquery>


<!--- Get New Settings --->
<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
<cfinclude template="../../qry_ship_settings.cfm">


