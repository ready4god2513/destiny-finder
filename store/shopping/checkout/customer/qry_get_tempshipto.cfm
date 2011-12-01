
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the customer shipping address from the temporary table. Called by dsp_addresses.cfm and from shipping\act_calc_shipping.cfm --->

<!------------
<cfif len(attributes.shipto)>

<cfquery name="GetShipTo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#Customers 
WHERE Customer_ID =<cfqueryparam value="#attributes.shipto#" cfsqltype="CF_SQL_INTEGER">
</cfquery>

<cfelse></cfif>-------------->

<cfquery name="GetShipTo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT * FROM #Request.DB_Prefix#TempShipTo 
WHERE TempShip_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
</cfquery>



