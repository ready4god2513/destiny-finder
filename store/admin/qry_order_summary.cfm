
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the information for the admin sales summar. Called by dsp_admin_home.cfm --->

<cfset Today = CreateDate(Year(Now()), Month(Now()), Day(Now()))>
<cfset ThisMonth = CreateDate(Year(Now()), Month(Now()), 1)>
<cfset ThisYear = CreateDate(Year(Now()), 1, 1)>

<!--- Summary of orders for today --->
<cfquery name="OrdersToday" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT SUM(OrderTotal) AS TotalSales, 
COUNT(Order_No) AS NumOrders
FROM #Request.DB_Prefix#Order_No
WHERE DateOrdered >= #CreateODBCDateTime(Today)# 
AND DateOrdered <= #CreateODBCDateTime(DateAdd('d', 1, Today))#
AND Void = 0
</cfquery>

<!--- Summary of orders for yesterday --->
<cfquery name="OrdersYester" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT SUM(OrderTotal) AS TotalSales, 
COUNT(Order_No) AS NumOrders
FROM #Request.DB_Prefix#Order_No
WHERE DateOrdered >= #CreateODBCDateTime(DateAdd('d', -1, Today))#
AND DateOrdered <= #CreateODBCDateTime(Today)# 
AND Void = 0
</cfquery>

<!--- Summary of orders for the month --->
<cfquery name="OrdersMonth" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT SUM(OrderTotal) AS TotalSales, 
COUNT(Order_No) AS NumOrders
FROM #Request.DB_Prefix#Order_No
WHERE DateOrdered >= #CreateODBCDateTime(ThisMonth)# 
AND DateOrdered <= #CreateODBCDateTime(DateAdd('m', 1, ThisMonth))#
AND Void = 0
</cfquery>

<!--- Summary of orders for last month --->
<cfquery name="OrdersLastMonth" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT SUM(OrderTotal) AS TotalSales, 
COUNT(Order_No) AS NumOrders
FROM #Request.DB_Prefix#Order_No
WHERE DateOrdered >= #CreateODBCDateTime(DateAdd('m', -1, ThisMonth))#
AND DateOrdered <= #CreateODBCDateTime(ThisMonth)# 
AND Void = 0
</cfquery>

<!--- Summary of orders for the year --->
<cfquery name="OrdersYear" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT SUM(OrderTotal) AS TotalSales, 
COUNT(Order_No) AS NumOrders
FROM #Request.DB_Prefix#Order_No
WHERE DateOrdered >= #CreateODBCDateTime(ThisYear)# 
AND DateOrdered <= #CreateODBCDateTime(DateAdd('yyyy', 1, ThisYear))#
AND Void = 0
</cfquery>

<!--- Summary of orders for last year --->
<cfquery name="OrdersLastYear" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT SUM(OrderTotal) AS TotalSales, 
COUNT(Order_No) AS NumOrders
FROM #Request.DB_Prefix#Order_No
WHERE DateOrdered >= #CreateODBCDateTime(DateAdd('yyyy', -1, ThisYear))#
AND DateOrdered <= #CreateODBCDateTime(ThisYear)# 
AND Void = 0
</cfquery>