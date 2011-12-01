
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- This page performs the inventory checks if inventory control is being used. Called by shopping.checkout (step=payment) --->

<cfparam name="display_payform" default = 1>

<!--- Create lists of product numbers, option numbers and quantities in the basket --->
<cfset ItemNums = ValueList(qry_get_basket.Product_ID)>
<cfset OptNums = ValueList(qry_get_basket.OptChoice)>
<cfset QuantNums = ValueList(qry_get_basket.Quantity)>

<!--- Start new blank lists --->
<cfset NewItemNums = "">
<cfset NewOptNums = "">
<cfset NewQuantNums = "">

<!--- Counter --->
<cfset i = 0>

<!--- Combine duplicate products --->
<cfloop index="item" list="#ItemNums#">
	<cfset i = i + 1>
	<cfset Quant = ListGetAt(QuantNums, i)>
	<cfset OptChoice = ListGetAt(OptNums, i)>

	<!--- Check if product already on new list --->
	<cfif ListFind(NewItemNums, item)>
		<!--- If on new list, check if same option --->
		<cfset Spot = ListFind(NewItemNums, item)>
		<cfset CheckO = ListGetAt(NewOptNums, Spot)>

		<cfif CheckO IS OptChoice>
			<cfset Quant = Quant + ListGetAt(NewQuantNums, Spot)>
			<cfset NewQuantNums = ListSetAt(NewQuantNums, Spot, Quant)>

		<cfelse>
			<cfset NewItemNums = ListAppend(NewItemNums, item)>
			<cfset NewOptNums = ListAppend(NewOptNums, OptChoice)>
			<cfset NewQuantNums = ListAppend(NewQuantNums, Quant)>
		</cfif>

	<cfelse>
		<cfset NewItemNums = ListAppend(NewItemNums, item)>
		<cfset NewOptNums = ListAppend(NewOptNums, OptChoice)>
		<cfset NewQuantNums = ListAppend(NewQuantNums, Quant)>
	</cfif>

</cfloop>

<!--- Create blank table to hold backordered items --->
<cfset Backorder = QueryNew("ItemName, OptName, QuantinStock, QuantOrdered")>

<!--- Loop through list of items --->
<cfloop index="num" from="1" to="#ListLen(NewItemNums)#">
	<!--- Get items from lists --->
	<cfset Item = ListGetAt(NewItemNums, num)>
	<cfset Quant = ListGetAt(NewQuantNums, num)>

	<!--- Choice picked for the option if used for quantity --->
	<cfset OptChoice = ListGetAt(NewOptNums, num)>

	<!--- Retrieve number in stock, product name, and option used 
	for inventory for each item being ordered --->
	<cfquery name="CheckInv" datasource="#Request.DS#" username="#Request.user#" 
		password="#Request.pass#">
		SELECT Name, NumInStock, OptQuant, Prod_Type 
		FROM #Request.DB_Prefix#Products
		WHERE Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Item#">
	</cfquery>

	<!--- If NumInStock is blank, set to 0 --->
	<cfif NOT CheckInv.NumInStock>
		<cfset NumInStock = 0>
	<cfelse>
		<cfset NumInStock = CheckInv.NumInStock>
	</cfif>

	<!--- Check for any quantities being ordered that are higher than number in stock --->
	<!--- Exclude download and membership products from inventory check --->
	<cfif Quant GT NumInStock AND CheckInv.Prod_Type IS "product">

		<!--- If so, add info to backorder table --->
		<cfset QueryAddRow(Backorder)>
		<cfset QuerySetCell(Backorder, "ItemName", CheckInv.Name)>
		<cfset QuerySetCell(Backorder, "QuantinStock", NumInStock)>
		<cfset QuerySetCell(Backorder, "QuantOrdered", Quant)>

	<cfelseif CheckInv.Prod_Type is "product">

		<!--- Check if option out of stock --->
		<cfif CheckInv.OptQuant IS NOT 0>

		<cfquery name="CheckOInv" datasource="#Request.DS#" username="#Request.user#" 
		password="#Request.pass#">
		SELECT SC.Choice_ID, SC.ChoiceName, PC.NumInStock
		FROM #Request.DB_Prefix#StdOpt_Choices SC, 
			#Request.DB_Prefix#Product_Options PO,
			#Request.DB_Prefix#ProdOpt_Choices PC
		WHERE PO.Option_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#CheckInv.OptQuant#">
		AND PC.Choice_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#OptChoice#">
		AND PO.Std_ID = SC.Std_ID
		AND SC.Choice_ID = PC.Choice_ID
		AND PC.Option_ID = PO.Option_ID
		
		UNION 
		
		SELECT SC.Choice_ID, SC.ChoiceName, 0 AS NumInStock
		FROM #Request.DB_Prefix#StdOpt_Choices SC, #Request.DB_Prefix#Product_Options PO
		WHERE PO.Option_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#CheckInv.OptQuant#">
		AND SC.Choice_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#OptChoice#">
		AND PO.Std_ID = SC.Std_ID
		AND NOT EXISTS (SELECT * FROM #Request.DB_Prefix#ProdOpt_Choices PC
						WHERE Option_ID = PO.Option_ID
						AND Choice_ID = SC.Choice_ID)			
		
		UNION
		
		SELECT PC.Choice_ID, PC.ChoiceName, PC.NumInStock
		FROM #Request.DB_Prefix#ProdOpt_Choices PC, #Request.DB_Prefix#Product_Options PO 
		WHERE PO.Option_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#CheckInv.OptQuant#">
		AND PC.Choice_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#OptChoice#">
		AND PO.Option_ID = PC.Option_ID	
		AND PO.Std_ID = 0
		</cfquery>

		<!--- Make sure that the option is still used for tracking inventory. If not, will have to mark product as not in stock. --->
		<cfif OptChoice neq 0 AND CheckOInv.RecordCount>
			<cfset OptInStock = CheckOInv.NumInStock>
		<cfelse>
			<cfset OptInStock = 0>
		</cfif>

		<cfif Quant GT OptInStock>

			<!--- If so, add info to backorder table --->
			<cfset QueryAddRow(Backorder)>
			<cfset QuerySetCell(Backorder, "ItemName", CheckInv.Name)>
			<!--- Quantity Option is missing --->
			<cfif OptChoice neq 0 AND NOT CheckOInv.RecordCount>
				<cfset QuerySetCell(Backorder, "OptName", "Missing Option(s)!")>
			<cfelseif OptChoice neq 0>
				<cfset QuerySetCell(Backorder, "OptName", CheckOInv.ChoiceName)>
			<cfelse>
				<cfset QuerySetCell(Backorder, "OptName", "")>
			</cfif>
			<cfset QuerySetCell(Backorder, "QuantinStock", OptInStock)>
			<cfset QuerySetCell(Backorder, "QuantOrdered", Quant)>

		</cfif>

	</cfif>

</cfif>

</cfloop>


