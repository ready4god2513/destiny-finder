<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Queries the orders to display for the order download --->

<cfparam name="attributes.FromOrder" default="">
<cfparam name="attributes.ToOrder" default="">
<cfparam name="attributes.FromDate" default="">
<cfparam name="attributes.ToDate" default="">
<cfparam name="attributes.ordertype" default="AllOrders">

<!--- Make sure this is a valid date --->
<cftry>

	<cfif len(attributes.FromDate)>
		<cfif listlen(attributes.FromDate,'-') is 1>
			<cfset FromDate = CreateDateTime(attributes.FromDate, 1, 1, 0, 0, 0)>
		<cfelseif listlen(attributes.FromDate,'-') is 2>
			<cfset FromDate = CreateDate(listfirst(attributes.FromDate,"-"), listlast(attributes.FromDate,"-"), 1)>
		<cfelseif  listlen(attributes.FromDate,'-') is 3>
			<cfset FromDate = CreateODBCDateTime(attributes.FromDate)>
		</cfif>
	</cfif>
	
	<cfif len(attributes.ToDate)>
		<cfif listlen(attributes.ToDate,'-') is 1>
			<cfset ToDate = CreateODBCDateTime(CreateDateTime(#attributes.ToDate#, 12, 31, 23, 59, 59))>
		<cfelseif listlen(attributes.ToDate,'-') is 2>
			<cfset thisdate= CreateDate(listfirst(attributes.ToDate,"-"),listlast(attributes.ToDate,"-"),1) >
			<cfset ToDate = CreateDateTime(Year(thisdate), Month(thisdate), DaysInMonth(thisdate), 23, 59, 59)>
		<cfelseif  listlen(attributes.ToDate,'-') is 3>
			<cfset ToDate = CreateDateTime(Year(attributes.ToDate), Month(attributes.ToDate), Day(attributes.ToDate), 23, 59, 59)>
		</cfif>
	</cfif>

<cfcatch>
<!--- If error, invalid date information was entered, don't set dates --->
	<cfset attributes.FromDate="">
	<cfset attributes.ToDate="">
</cfcatch>

</cftry>

<cfif len(attributes.FromDate) OR  len(attributes.ToDate)>
	<cfset attributes.FromOrder="">
	<cfset attributes.ToOrder="">
</cfif>


<cfquery name="GetOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT O.*, N.*, 
C.FirstName as Billto_FirstName,
C.LastName as Billto_LastName,
C.Company as Billto_Company,
C.Address1 as Billto_Address1,
C.Address2 as Billto_Address2,
C.City as Billto_City,
C.County as Billto_County,
C.State as Billto_State,
C.State2 as Billto_State2,
C.Zip as Billto_Zip,
C.Country as Billto_Country,
C.Phone as Billto_Phone,
C.Phone2 as Billto_Phone2,
C.Fax as Billto_Fax,
C.Email as Billto_Email,
1 as Billto_Resident,
S.FirstName as Shipto_FirstName,
S.LastName as Shipto_LastName,
S.Company as Shipto_Company,
S.Address1 as Shipto_Address1,
S.Address2 as Shipto_Address2,
S.City as Shipto_City,
S.County as Shipto_County,
S.State as Shipto_State,
S.State2 as Shipto_State2,
S.Zip as Shipto_Zip,
S.Country as Shipto_Country,
S.Phone as Shipto_Phone,
S.Phone2 as Shipto_Phone2,
S.Fax as Shipto_Fax,
S.Email as Shipto_Email,
1 as Shipto_Resident,
D.*,
P.Short_Desc as Description

FROM ((((#Request.DB_Prefix#Order_Items O 
	INNER JOIN #Request.DB_Prefix#Order_No N ON O.Order_No = N.Order_No) 
	INNER JOIN #Request.DB_Prefix#Customers C on N.Customer_ID = C.Customer_ID)
	LEFT JOIN #Request.DB_Prefix#Customers S on N.ShipTo = S.Customer_ID)
	LEFT JOIN #Request.DB_Prefix#CardData D on N.Card_ID = D.ID)
	LEFT JOIN #Request.DB_Prefix#Products P on O.Product_ID = P.Product_ID
	
WHERE 1=1
	<cfif isNumeric(attributes.FromOrder)>
		AND O.Order_No >= #attributes.FromOrder-Get_Order_Settings.BaseOrderNum#
	</cfif>	
	<cfif isNumeric(attributes.ToOrder)>
		AND O.Order_No <= #attributes.ToOrder-Get_Order_Settings.BaseOrderNum#
	</cfif>	
	<cfif isDate(attributes.FromDate)>
		AND N.DateOrdered >= #FromDate# 
	</cfif>	
	<cfif isDate(attributes.ToDate)>
		AND N.DateOrdered <= #ToDate# 
	</cfif>	
	<cfif attributes.ordertype is "FilledOrders">
		AND Filled = 1
		AND Void = 0
	</cfif>
	
ORDER BY O.Order_No
</cfquery>

