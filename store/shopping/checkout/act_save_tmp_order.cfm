
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Saves the order totals to the temporary table. Called by shopping.checkout (step=payment) --->

<!--- Store totals for this order in database --->
<cfquery name="UpdTotals" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
UPDATE #Request.DB_Prefix#TempOrder
SET 
OrderTotal = <cfqueryparam value="#Total#" cfsqltype="CF_SQL_DOUBLE">,
Tax = <cfqueryparam value="#Tax#" cfsqltype="CF_SQL_DOUBLE">,
ShipType = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ShipType#">, 
Shipping = <cfqueryparam value="#ShipCost#" cfsqltype="CF_SQL_DOUBLE">, 
Freight = <cfqueryparam value="#TotalFreight#" cfsqltype="CF_SQL_DOUBLE">,
OrderDisc = <cfqueryparam value="#BasketTotals.OrderDiscount#" cfsqltype="CF_SQL_DOUBLE">,
Credits = <cfqueryparam value="#Credits#" cfsqltype="CF_SQL_DOUBLE">,
AddonTotal = <cfqueryparam value="#BasketTotals.AddonTotal#" cfsqltype="CF_SQL_DOUBLE">
WHERE BasketNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
</cfquery>

<cfinclude template="qry_get_temporder.cfm">


