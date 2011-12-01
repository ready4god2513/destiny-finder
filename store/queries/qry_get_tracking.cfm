
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the tracking information for an order. Called by shopping.tracking --->

<cfset order_no = attributes.ordernum - Get_Order_Settings.BaseOrderNum>

<cfparam name="attributes.Shipper" default="UPS">

<!--- Get order information --->
<cfquery name="qry_get_tracking" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT O.Order_No, O.Shipper, O.Tracking, C.Zip
FROM #Request.DB_Prefix#Order_No O, #Request.DB_Prefix#Customers C
WHERE O.Customer_ID = C.Customer_ID
AND O.Order_No = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#order_no#">
</cfquery>

<cfquery name="qry_get_PO_tracking" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT PO.Tracking
FROM #Request.DB_Prefix#Order_No O, #Request.DB_Prefix#Order_PO PO
WHERE O.Order_No = PO.Order_No
AND O.Order_No = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#order_no#">
AND PO.Shipper = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#attributes.Shipper#">
</cfquery>


