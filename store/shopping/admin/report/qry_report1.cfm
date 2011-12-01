
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the information for the Sales Summary Report. Called by dsp_reports.cfm --->

<!--- Get list of orders --->
<cfquery name="GetOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT SUM(OrderTotal) AS TotalSales, 
COUNT(Order_No) AS NumOrders, 
SUM(Tax) As TotalTax, 
SUM(Shipping) As TotalShipping,
SUM(OrderDisc) As TotalDisc,
SUM(Credits) As TotalCredit
FROM #Request.DB_Prefix#Order_No
WHERE DateOrdered >= #CreateODBCDateTime(StartDate)# 
AND DateOrdered <= #CreateODBCDateTime(ToDate)#
AND Void = 0
</cfquery>


<cfquery name="PendingOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT SUM(OrderTotal) AS TotalPending,
SUM(Tax) As PendingTax, 
SUM(Shipping) As PendingShipping,
SUM(OrderDisc) As PendingDisc,
SUM(Credits) As PendingCredit
FROM #Request.DB_Prefix#Order_No
WHERE DateOrdered >= #CreateODBCDateTime(StartDate)# 
AND DateOrdered <= #CreateODBCDateTime(ToDate)#
AND Void = 0
AND Paid = 0
</cfquery>

