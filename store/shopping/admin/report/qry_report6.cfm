
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the information for the Affiliate Sales Report. Called by dsp_reports.cfm --->

<cfquery name="GetOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT N.Affiliate, 
SUM(OrderTotal) AS TotalSales, 
SUM(Tax) As TotalTax, 
SUM(Shipping) As TotalShipping,
SUM(OrderDisc) As TotalDisc,
SUM(Credits) As TotalCredit
FROM #Request.DB_Prefix#Order_No N
WHERE N.Affiliate <> 0 
AND N.Filled <> 0 
AND N.DateFilled >= #CreateODBCDateTime(StartDate)# 
AND N.DateFilled <= #CreateODBCDateTime(ToDate)# 
AND Void = 0
GROUP BY N.Affiliate
</cfquery>


<!--- This page is called by viewreport.cfm and is used to output the sales totals and referral fees for each Affiliate --->


