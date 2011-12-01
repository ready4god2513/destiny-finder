
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the list of orders for order processing pages. Includes a number of specialized date search fields and other filters. Called by shopping.admin&order=pending|process|billing|filled|search --->

<cfloop index="namedex" list="order_no,UID,customer,orderdate,prodid,StartDate,ToDate,datefilled,filled,process,paid,affiliate,status,sort,sortorder,offlinepayment,ordertype">
	<cfparam name="attributes.#namedex#" default="">
</cfloop>

<!--- sort by: Order Number, last_name, status, shiptype, pay status, 

	bill city, bill state, bill country, 
	ship city, ship state, ship country,
-------------->

<!--- copy type of search from attributes.order --->
<cfif attributes.order IS NOT "search">
	<cfset attributes.ordertype = attributes.order>
<!--- copy ordertype to status if needed --->
<cfelseif len(attributes.ordertype) AND NOT ListFind("pending,process,filled", attributes.ordertype)>
	<cfset attributes.status = attributes.ordertype>
<cfelse>
	<cfset attributes.status = "all">
</cfif>


<!--- Get Minimum Date for date select box ---->				
<cfquery name="GetMinDate" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT MIN(DateOrdered) AS GetDate 
FROM #Request.DB_Prefix#Order_No 
</cfquery>

<cfif len(GetMinDate.GetDate)>
 <cfset MinDate = GetMinDate.GetDate>
<cfelse>
 <cfset MinDate=now()>
</cfif>

<!--- Get MAXIMUM Date for date select box ---->	
<cfset NowMonth = Month(Now())>
<cfset NowYear = Year(Now())>
<cfset NowDays = DaysInMonth(Now())>

<!--- Set Default Month for Month Box ---->	
<cfset ThisMonth = CreateDate(NowYear, NowMonth, NowDays)>

<!--- Make sure this is a valid date --->
<cftry>

<!--- If we have an order date, set the start and end date --->
<cfif len(attributes.orderdate)>
	<cfset Year = ListGetAt(attributes.orderdate, 1, "-")>
	<!--- Check if month entered --->
	<cfif listlen(attributes.orderdate,'-') gte 2>
		<cfset StartMonth = ListGetAt(attributes.orderdate, 2, "-")>
		<cfset EndMonth = ListGetAt(attributes.orderdate, 2, "-")>
	<cfelse>
		<cfset StartMonth = 1>
		<cfset EndMonth = 12>
	</cfif>
	<!--- Check if day entered --->
	<cfif listlen(attributes.orderdate,'-') is 3>
		<cfset StartDay = ListGetAt(attributes.orderdate, 3, "-")>
		<cfset EndDay = ListGetAt(attributes.orderdate, 3, "-")>
	<cfelse>
		<cfset StartDay = 1>
		<cfset EndDay = DaysinMonth(CreateDate(Year, StartMonth, StartDay))>
	</cfif>

	<cfset orderfrom = CreateDateTime(Year, StartMonth, StartDay, 0, 0, 0)>
	<cfset orderto = CreateDateTime(Year, EndMonth, EndDay, 23, 59, 59)>
</cfif>

<cfcatch>
<!--- If error, invalid date information was entered, don't set orderfrom variable --->
</cfcatch>

</cftry>

	
<!--- Clear variables --->
<cfset Year = "">
<cfset StartMonth = "">
<cfset EndMonth = "">
<cfset StartDay = "">
<cfset EndDay = "">

<!--- Make sure this is a valid date --->
<cftry>

<!--- If we have a filled date, set the filledstart and filledend date --->
<cfif len(attributes.datefilled)>
	<cfset Year = ListGetAt(attributes.datefilled, 1, "-")>
	<!--- Check if month entered --->
	<cfif listlen(attributes.datefilled,'-') gte 2>
		<cfset StartMonth = ListGetAt(attributes.datefilled, 2, "-")>
		<cfset EndMonth = ListGetAt(attributes.datefilled, 2, "-")>
	<cfelse>
		<cfset StartMonth = 1>
		<cfset EndMonth = 12>
	</cfif>
	<!--- Check if day entered --->
	<cfif listlen(attributes.datefilled,'-') is 3>
		<cfset StartDay = ListGetAt(attributes.datefilled, 3, "-")>
		<cfset EndDay = ListGetAt(attributes.datefilled, 3, "-")>
	<cfelse>
		<cfset StartDay = 1>
		<cfset EndDay = DaysinMonth(CreateDate(Year, StartMonth, StartDay))>
	</cfif>
	
	<cfset filledstart = CreateDateTime(Year, StartMonth, StartDay, 0, 0, 0)>
	<cfset filledto = CreateDateTime(Year, EndMonth, EndDay, 23, 59, 59)>
</cfif>

<cfcatch>
<!--- If error, invalid date information was entered, don't set filled variables --->
</cfcatch>

</cftry>


<!--- Set SEARCH Date Range for filled orders or order search ----> 
<cfif attributes.ordertype is "filled" OR attributes.order is "search">
 
 <cfif not isdate(attributes.startDate)>
 
  <cfparam name="attributes.startDay" default="1">
  <cfparam name="attributes.StartMonth" default="#nowMonth#">
  <cfparam name="attributes.StartYear" default="#NowYear#">
 
  <cfset CheckStart = CreateDate(attributes.StartYear, attributes.StartMonth, 1)>
 
  <cfif attributes.StartDay LTE DaysInMonth(CheckStart)>
   <cfset attributes.StartDate = CreateDate(attributes.StartYear, attributes.StartMonth, attributes.StartDay)>
  <cfelse>
   <cfset attributes.StartDate = CreateDate(attributes.StartYear, attributes.StartMonth, DaysInMonth(CheckStart))>
  </cfif>
 
 </cfif> 
 
 <cfif not isdate(attributes.toDate)>
 
  <cfparam name="attributes.toDay" default="#Day(Now())#">
  <cfparam name="attributes.toMonth" default="#nowMonth#">
  <cfparam name="attributes.toYear" default="#NowYear#">
 
  <cfset CheckTo = CreateDate(attributes.ToYear, attributes.ToMonth, 1)>
 
  <cfif attributes.ToDay LTE DaysInMonth(CheckTo)>
   <cfset attributes.ToDate = CreateDateTime(attributes.ToYear, attributes.ToMonth, attributes.ToDay, 23, 59, 59)>
  <cfelse>
   <cfset attributes.ToDate = CreateDateTime(attributes.ToYear, attributes.ToMonth, DaysInMonth(CheckTo), 23, 59, 59)>
  </cfif>
 
 </cfif> 
 
 <!--- Only perform date search for filled orders if no other fields filled out --->
 <cfif not len(Attributes.order_no) AND NOT isDefined("attributes.show") AND NOT len(attributes.datefilled) AND NOT len(attributes.UID) AND NOT len(attributes.customer)>
  <cfset filledsearch = 1>
 <cfelseif attributes.order IS NOT "search">
  <cfset filledsearch = 0>
 <cfelseif isDefined("attributes.show")>
 	<cfset filledsearch = 0>
<cfelse>
 	<cfset filledsearch = 1>
 </cfif>
 
<cfelse>
 <cfset filledsearch = 0>
 
</cfif>


<cfif attributes.ordertype is "filled">
	<cfquery name="GetDates" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT DISTINCT Year(DateOrdered) AS OrderYear, Month(DateOrdered) AS OrderMonth
	FROM #Request.DB_Prefix#Order_No 
	WHERE Filled = 1
	ORDER BY 1, 2 DESC
	</cfquery>
</cfif>

	
<!--- Get list of current orders --->
<cfquery name="qry_get_Orders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT O.Order_No, O.User_ID AS uid, O.Customer_ID, O.Affiliate, O.DateFilled, C.FirstName, C.LastName, O.DateOrdered, O.OfflinePayment, O.PayPalStatus, O.AuthNumber, Process, Filled, Paid, Status, Printed, ShipType
FROM 
<cfif len(attributes.prodid) AND isNumeric(attributes.prodid)>
(#Request.DB_Prefix#Order_No O
INNER JOIN #Request.DB_Prefix#Order_Items I ON I.Order_No = O.Order_No)
<cfelse>
#Request.DB_Prefix#Order_No O
</cfif>
LEFT JOIN #Request.DB_Prefix#Customers C ON O.Customer_ID = C.Customer_ID
WHERE 
		
	<cfif attributes.ordertype is "pending">
		Process = 0
		AND Filled = 0
	<cfelseif attributes.ordertype is "process">
		Process = 1
		AND Filled = 0
	<cfelseif attributes.ordertype is "filled">	
		Filled = 1
	<cfelseif attributes.ordertype is "billing">
		Process = 1
		AND Paid = 0
	<cfelse>
		1 = 1
	</cfif>
	
	<cfif len(attributes.prodid) AND isNumeric(attributes.prodid)>
		AND I.Product_ID = #attributes.prodid#
	</cfif>
	
	<cfif len(attributes.Order_No)>
		AND O.Order_No = #(Val(attributes.Order_No) - Get_Order_Settings.BaseOrderNum)#
	</cfif>
	
	 <cfif len(attributes.offlinepayment)>
		 AND O.OfflinePayment = '#offlinepayment#'
 	</cfif> 
	
	<cfif len(attributes.UID)>
		AND O.User_ID = #Val(attributes.UID)#
	</cfif>
	
	<cfif len(attributes.customer)>
		AND (FirstName Like '%#attributes.customer#%'
		OR LastName Like '%#attributes.customer#%'
		OR Company Like '%#attributes.customer#%') 
	</cfif>
	
	<cfif len(attributes.filled)>
		AND Filled = #attributes.filled#
	</cfif>

	<cfif len(attributes.paid)>
		AND Paid = #attributes.paid#
	</cfif>
	
	<cfif len(attributes.affiliate)>
  		AND Affiliate = #attributes.affiliate#
 	</cfif>
	
	<cfif isDefined("filledStart")>
		AND DateFilled >= #CreateODBCDateTime(filledStart)#
		AND DateFilled <= #CreateODBCDateTime(filledTo)#
	</cfif>
		
	<cfif len(attributes.StartDate) AND filledsearch >
		AND DateOrdered >= #CreateODBCDateTime(attributes.StartDate)#
	</cfif>
	<cfif len(attributes.ToDate) AND filledsearch>
		AND DateOrdered <= #CreateODBCDateTime(attributes.ToDate)#
	</cfif>

	<cfif isDefined("orderfrom") AND NOT isDefined("attributes.show")>
		AND DateOrdered >= #CreateODBCDateTime(orderfrom)#
		AND DateOrdered <= #CreateODBCDateTime(orderto)#
	</cfif>

	<cfif len(attributes.status)>
		<cfif attributes.status is "none">
			AND (Status = '' OR Status IS NULL)
		<cfelseif attributes.status is "void">
			AND Void = 1
		<cfelseif attributes.status is not "all">
			AND Status = '#attributes.status#'
		</cfif>
	<cfelse>
		AND VOID = 0
	</cfif>
	
	
	ORDER BY 
		
		<cfif attributes.sort is "printinv">
			Printed <> 1, Printed <> 3,
		<cfelseif attributes.sort is "printpack">
			Printed < 2,
		<cfelseif attributes.sort is "paytype">
			OfflinePayment, 
		<cfelseif attributes.sort is "shiptype">
			ShipType,
		<cfelseif attributes.sort is "customer">
			Company, LastName,
		<cfelseif attributes.sort is "orderdate">
			DateOrdered DESC, 
		</cfif>
		O.Order_No <cfif len(attributes.sortorder)>#attributes.sortorder#<cfelse>DESC</cfif>
	
</cfquery>


<!--- Set list for next item in order detail page --->
<cfset attributes.type = "order">
<cfinclude template="../../../customtags/nextitems.cfm">

