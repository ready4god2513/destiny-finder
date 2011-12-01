
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to save the Shipping Settings for the store. Called by shopping.admin&shipping=settings --->

<!--- Replace double carriage returns with HTML paragraph tags. --->
<cfset HTMLBreak = Chr(60) & 'br/' & Chr(62)>
<cfset HTMLParagraph = HTMLBreak & HTMLBreak>
<cfset LineBreak = Chr(13) & Chr(10)>
<cfset NoShipMess = Replace(Trim(attributes.NoShipMess), LineBreak & LineBreak, HTMLParagraph & LineBreak & LineBreak, "ALL")>
<cfset ShipHand = Evaluate(Trim(attributes.ShipHand) / 100)>

<cfquery name="UpdSettings" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
UPDATE #Request.DB_Prefix#ShipSettings
SET ShipType = '#attributes.ShipType#',
AllowNoShip = #attributes.AllowNoShip#,
InStorePickup = #InStorePickup#,
ShowEstimator = #ShowEstimator#,
UseDropShippers = #UseDropShippers#,
ShowFreight = #ShowFreight#,
NoShipMess = '#NoShipMess#',
NoShipType = '#Trim(attributes.NoShipType)#',
ShipBase = #Trim(attributes.ShipBase)#,
ShipHand = #ShipHand#
WHERE ID = #attributes.ID#
</cfquery>

<!--- Get New Settings --->
<cfset Request.Cache = CreateTimeSpan(0, 0, 0, 0)>
<cfinclude template="../../qry_ship_settings.cfm">





