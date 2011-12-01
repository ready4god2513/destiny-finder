<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves order and customer information for an order, used for the shipping form page. Called by shopping.admin&order=shipping --->

	<!-----
	<cfif isdefined("attributes.order_num")>
		<cfset attributes.Order_No = Evaluate(attributes.Order_Num - Get_Order_Settings.BaseOrderNum)>
	</cfif>
	---->
	
	<!--- Get order --->
	<cfquery name="GetOrder" datasource="#Request.DS#" 
	username="#Request.user#" password="#Request.pass#">
	SELECT O.Order_No, O.Customer_ID, O.DateOrdered, C.FirstName, C.LastName, C.Email
	FROM #Request.DB_Prefix#Order_No O, #Request.DB_Prefix#Customers C
	WHERE O.Order_No = #attributes.Order_No# 
	AND O.Customer_ID = C.Customer_ID
	</cfquery>
	
