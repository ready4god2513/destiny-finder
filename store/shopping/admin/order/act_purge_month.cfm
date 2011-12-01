
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Runs the function to delete a select month's worth of filled orders. Called from act_orders_filled.cfm --->

<cfquery name="GetOrders" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
SELECT Order_No, Card_ID FROM #Request.DB_Prefix#Order_No 
WHERE MONTH(DateOrdered) = #ListGetAt(attributes.Month, 1)#
AND YEAR(DateOrdered) = #ListGetAt(attributes.Month, 2)#
AND Filled = 1
<!--- Don't remove orders used for an active recurring membership --->
AND Order_No NOT IN (SELECT Order_ID FROM #Request.DB_Prefix#Memberships
					WHERE Recur = 1
					AND Expire >= #CreateODBCDate(Now())# )
</cfquery>

<cfif GetOrders.RecordCount>

	<cfset OrderList = ValueList(GetOrders.Order_No)>
	<cfset CardList = ValueList(GetOrders.Card_ID)>
	
	<cfquery name="GetCustomers" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Customer_ID FROM #Request.DB_Prefix#Customers
	WHERE Customer_ID IN (SELECT Customer_ID FROM #Request.DB_Prefix#Order_No  
						WHERE MONTH(DateOrdered) = #ListGetAt(attributes.Month, 1)#
						AND YEAR(DateOrdered) = #ListGetAt(attributes.Month, 2)#) 
	AND Customer_ID NOT IN (SELECT Customer_ID FROM #Request.DB_Prefix#Users)
	AND Customer_ID NOT IN (SELECT Customer_ID FROM #Request.DB_Prefix#Order_No  
							WHERE Order_No NOT IN (#OrderList#) )
	AND Customer_ID NOT IN (SELECT Customer_ID FROM #Request.DB_Prefix#Account)
	AND User_ID = 0
	</cfquery>
	
	
	<cfset CustomerList = ValueList(GetCustomers.Customer_ID)>
	
	<cfif len(CardList)>
		<cfquery name="Purge3" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#CardData
		WHERE ID IN (#CardList#)
		</cfquery>
	</cfif>
	
	<cfif len(OrderList)>
		<cfquery name="Purge1" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#Order_Items
		WHERE Order_No IN (#OrderList#)
		</cfquery>
		
		<cfquery name="Purge2" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#OrderTaxes
		WHERE Order_No IN (#OrderList#)
		</cfquery>
		
		<cfquery name="DeleteOrderPO" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#Order_PO
		WHERE Order_No IN (#OrderList#)
		</cfquery>
		
		<cfquery name="Purge2" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#Order_No
		WHERE Order_No IN (#OrderList#)
		</cfquery>
		
	</cfif>
	
	
	<cfif len(CustomerList)>
		<cfquery name="Purge4" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#Customers
		WHERE Customer_ID IN (#CustomerList#)
		</cfquery>
	
	</cfif>


</cfif>


