<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Initializes the shipping information for the checkout process. Retrieves current customer shipping information for the user, or creates a new blank record. Called by shopping.checkout (step="") --->

<!--- Check if there is already a record --->
<cfquery name="CheckRecord" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT TempShip_ID FROM #Request.DB_Prefix#TempShipTo
WHERE TempShip_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
</cfquery>

<cfif NOT CheckRecord.RecordCount AND attributes.shipto IS NOT 0>

	<cfset Application.objUsers.AddBlankRecord(TableName="TempShipTo")>

</cfif>
