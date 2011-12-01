
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the information for the Top Products by Total Sales Report. Called by dsp_reports.cfm --->

<cfquery name="GetOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Max(O.Name) AS Name, O.Product_ID, 
SUM(O.Quantity) AS ProductsSold_Sum,
SUM((O.Price+O.OptPrice-O.DiscAmount+O.AddonMultP)*O.Quantity+O.AddonNonMultP-O.PromoAmount) AS ProductsPrice_Sum
FROM #Request.DB_Prefix#Order_Items O, #Request.DB_Prefix#Order_No N
WHERE N.Order_No = O.Order_No
AND N.DateOrdered >= #CreateODBCDateTime(StartDate)# 
AND N.DateOrdered <= #CreateODBCDateTime(ToDate)# 
AND Void = 0
GROUP BY O.Product_ID
ORDER BY 4 DESC
</cfquery>

<!--- This page is called by viewreport.cfm and is used to output the top products by total sales --->


