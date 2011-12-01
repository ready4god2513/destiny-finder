
<!--- CFWebstore�, version 6.43 --->

<!--- CFWebstore� is �Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Removes items from inventory according to the inventory settings. Called from act_order.cfm --->

<cftransaction isolation="SERIALIZABLE">

	<!--- Get list of items being ordered --->
	<cfquery name="GetOrder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT O.Product_ID, O.Quantity, O.OptChoice, P.Prod_Type 
	FROM #Request.DB_Prefix#Order_Items O, #Request.DB_Prefix#Products P
	WHERE O.Order_No = #Order_No#
	AND O.Product_ID = P.Product_ID
	</cfquery>

	<cfloop query="GetOrder">
		<!--- Only remove tangible products --->
		
		<cfif GetOrder.Prod_Type IS "product">
	
			<cfquery name="UpdateInv" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Products
			SET NumInStock = NumInStock - #GetOrder.Quantity#
			WHERE Product_ID = #GetOrder.Product_ID#
			</cfquery>
			
			<!--- check re-order level of the product ---->
			<cfinclude template="act_reorder_check.cfm">
			
			<cfif GetOrder.OptChoice IS NOT 0>
			
				<!--- Update Option Quantity --->
				<cfquery name="UpdateChoice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
					UPDATE #Request.DB_Prefix#ProdOpt_Choices
					SET NumInStock = NumInStock - #GetOrder.Quantity#
					WHERE Option_ID IN (SELECT OptQuant FROM Products
										WHERE Product_ID = #GetOrder.Product_ID#)
					AND Choice_ID = #GetOrder.OptChoice#
				</cfquery>
	
			</cfif>
		
		</cfif>
	</cfloop>
	
</cftransaction>
			
<!--- Update the order --->
<cfquery name="GetInfo" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">	
	UPDATE #Request.DB_Prefix#Order_No
	SET InvDone = 1
	WHERE Order_No = #Order_No#
</cfquery>


