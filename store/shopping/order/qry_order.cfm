
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves all the data for the order. Called by put_order.cfm --->

<!--- Get the order information --->
<cfquery name="CheckOrder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Order_No FROM #Request.DB_Prefix#Order_No
WHERE Order_No = <cfqueryparam value="#Order_No#" cfsqltype="CF_SQL_INTEGER">
<cfif Type IS NOT "Admin">
AND User_ID = <cfqueryparam value="#Session.User_ID#" cfsqltype="CF_SQL_INTEGER">
</cfif>
</cfquery>

<cfif CheckOrder.RecordCount IS 0>

	<cfset errormess = "Sorry, there does not appear to be an order with this number in the database.">

<cfelse>

	<!--- Get the order information, one row needed only --->
	<cfquery name="GetOrder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT * FROM #Request.DB_Prefix#Order_Items O, #Request.DB_Prefix#Order_No N
	WHERE O.Order_No = <cfqueryparam value="#Order_No#" cfsqltype="CF_SQL_INTEGER">
	AND O.Order_No = N.Order_No
	</cfquery>
	
	
	<cfif GetOrder.RecordCount IS 0>
		
		<cfset errormess = "Sorry, this order appears to have no items listed.">
	
	<cfelse>
	
		<!--- Get the Affiliate information --->
		<cfif GetOrder.Affiliate>
			<cfquery name="GetAffiliate" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT A.*, C.FirstName, C.LastName 
			FROM #Request.DB_Prefix#Affiliates A, #Request.DB_Prefix#Users U, #Request.DB_Prefix#Customers C
			WHERE A.AffCode = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#GetOrder.Affiliate#">
			AND U.Affiliate_ID = A.Affiliate_ID
			AND C.Customer_ID = U.Customer_ID
			</cfquery>
		</cfif>
	
		<cfquery name="GetCardData" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
			SELECT * FROM #Request.DB_Prefix#CardData
			WHERE ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#GetOrder.Card_ID#">
		</cfquery>
	
	
	</cfif>


</cfif>

