
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the affiliate information. Called from dsp_report.cfm --->

<cfquery name="GetInfo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT A.AffCode, A.AffPercent, U.User_ID, U.Username, C.FirstName, C.LastName, C.Company 
FROM (#Request.DB_Prefix#Affiliates A 
		INNER JOIN #Request.DB_Prefix#Users U ON A.Affiliate_ID = U.Affiliate_ID)
LEFT JOIN #Request.DB_Prefix#Customers C ON U.Customer_ID = C.Customer_ID
WHERE 
U.User_ID = <cfqueryparam value="#attributes.uid#" cfsqltype="CF_SQL_INTEGER">
</cfquery>

<cfif GetInfo.Recordcount>
	<cfquery name="GetDates" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT DISTINCT Year(DateOrdered) AS OrderYear, Month(DateOrdered) AS OrderMonth
	FROM #Request.DB_Prefix#Order_No 
	WHERE Affiliate = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#GetInfo.AffCode#">
	AND VOID = 0
	ORDER BY 1, 2 DESC
	</cfquery>
</cfif>



