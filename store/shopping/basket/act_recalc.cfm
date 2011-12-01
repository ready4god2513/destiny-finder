<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Performs the recalculation of the shopping cart. Updates the quantities and removes items as checked off. Called by shopping.basket --->


<cfset qry_Get_Basket = Application.objCart.getBasket()>

<!----- Update Quantities ------>
<cfloop query="qry_Get_Basket">

	<!--- Run the various functions to set the basket quantity --->
	<cfscript>
		i = qry_Get_Basket.Currentrow;
		
		if (isdefined("attributes.Quantity#i#"))
			RowQuantity = attributes["Quantity" & i];
		else
			RowQuantity = qry_Get_Basket.Quantity;
			
		// Make sure quantity is a number; if not, set to 1
		if (NOT isNumeric(RowQuantity)) 
			RowQuantity = 1;
		else
			RowQuantity = Round(RowQuantity);
		
		//Make sure quantity is not negative
		if (RowQuantity LT 0)
			RowQuantity = 0;
		
		//Make sure this item is not a recurring product
		if (qry_Get_Basket.Recur IS 1 AND RowQuantity GT 1)
			RowQuantity = 1;
			
		//Make sure the quantity meets the required minimum
		else if (qry_Get_Basket.Min_Order GT 0 AND RowQuantity LT qry_Get_Basket.Min_Order)
			RowQuantity = qry_Get_Basket.Min_Order;
			
		//Make sure the quantity multiplies by the minimum if required
		else if (qry_Get_Basket.Min_Order GT 0 AND qry_Get_Basket.Mult_Min IS 1 AND RowQuantity MOD qry_Get_Basket.Min_Order GT 0) {
			// The MOD will give us any amount remaining when divided by minimum. Subtract from minimum to get the amount to add
			AmounttoAdd = qry_Get_Basket.Min_Order - (RowQuantity MOD qry_Get_Basket.Min_Order);
			RowQuantity = RowQuantity + AmounttoAdd;
			}
		
	</cfscript>

	<!--- Update the basket query --->
	<cfset QuerySetCell(qry_get_basket, "Quantity", RowQuantity, i)>

</cfloop>

<!--- Loop through the updated query and remove any deleted items --->
<cfloop index="Num" from="#qry_Get_Basket.RecordCount#" to="1" step="-1">

	<cfscript>
	// By default, do not delete item 
	DeleteItem = false;
	
	// See if this item was in list to be removed
	if (isDefined("attributes.Remove") AND ListFind(attributes.Remove, Num) IS NOT 0) 
		DeleteItem = true;

	// Delete if quantity is zero, even if remove box not checked 
	else if (qry_Get_Basket.Quantity[Num] IS 0)
		DeleteItem = true;
		
	</cfscript>
	
	<!--- Include the checks for availability of item and the option selections --->
	<cfinclude template="qry_check_item.cfm">
	
	<cfif NOT Available OR NOT OptQuantAvail OR NOT OptChoiceAvail>
		<cfset DeleteItem = "yes">
	</cfif>

	<cfif DeleteItem>

		<cfquery name="DeleteItem" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		DELETE FROM #Request.DB_Prefix#TempBasket 
		WHERE Basket_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#qry_Get_Basket.Basket_ID[Num]#">
		</cfquery>
		
		<cfset QuerySetCell(qry_get_basket, "Quantity", 0, num)>
		
	</cfif>
		
</cfloop>

<!--- If rows deleted, get the query again --->
<!--- <cfset qry_Get_Basket = Application.objCart.getBasket()> --->

<!--- If coupon entered, check for valid code --->
<cfparam name="attributes.Coupon" default=""> 
<cfinclude template="../checkout/customer/act_check_code.cfm">
<!--- Get the basket totals --->
<cfset getProductTotals = Application.objCart.getProductTotals(qry_Get_Basket)>

<!--- Get the quantity discounts and group prices for the products in the cart --->
<cfif qry_Get_Basket.RecordCount>
	<cfquery name="get_qty_discounts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Product_ID, QuantFrom, QuantTo, DiscountPer FROM #Request.DB_Prefix#ProdDisc
	WHERE Product_ID IN (<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ValueList(qry_Get_Basket.Product_ID)#" list="Yes">)
	AND Wholesale = <cfqueryparam cfsqltype="#Request.SQL_Bit#" value="#session.wholesaler#">
	ORDER BY Product_ID
	</cfquery>
	
	<cfquery name="get_grp_prices" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	SELECT Product_ID, Price FROM #Request.DB_Prefix#ProdGrpPrice
	WHERE Product_ID IN (<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ValueList(qry_Get_Basket.Product_ID)#" list="Yes">)
	AND Group_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#session.Group_ID#">
	ORDER BY Product_ID
	</cfquery>
</cfif>

<!--- Loop through the updated query to set discounts--->
<cfloop query="qry_Get_Basket">
		
	<cfscript>
	i = qry_Get_Basket.Currentrow;
	Basket_ID = qry_Get_Basket.Basket_ID;
	NewQuantDisc = 0;
	
	// check against total quantity of items for that product
	checkQuantity = getProductTotals[qry_Get_Basket.product_id].Quantity;
	</cfscript>

	<cfquery name="qry_get_qty_discount" dbtype="query">
		SELECT DiscountPer FROM get_qty_discounts
		WHERE Product_ID = #qry_Get_Basket.product_id#
		AND QuantFrom <= #checkQuantity#
		AND (QuantTo >= #checkQuantity# OR QuantTo = 0)
	</cfquery>
	
	<cfif qry_get_qty_discount.recordcount>
		<cfset NewQuantDisc = qry_get_qty_discount.DiscountPer>
	</cfif>
	
	<!--- Recalculate the base item price for this user --->
	<cfquery name="qry_get_grp_price" dbtype="query">
		SELECT Price FROM get_grp_prices
		WHERE Product_ID = #qry_Get_Basket.product_id#
	</cfquery>
	
	<cfscript>
		if (qry_get_grp_price.recordcount)
			NewPrice = qry_get_grp_price.Price;
		else if (Session.Wholesaler AND qry_get_basket.Wholesale IS NOT 0)
			NewPrice = qry_get_basket.Wholesale;
		else
			NewPrice = qry_get_basket.Base_Price;
			
		//Update the basket query
		QuerySetCell(qry_get_basket, "QuantDisc", NewQuantDisc, i);
		QuerySetCell(qry_get_basket, "Price", NewPrice, i);
	</cfscript>

	<cfquery name="UpdBasket" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	UPDATE #Request.DB_Prefix#TempBasket
	SET QuantDisc = <cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#NewQuantDisc#">,
		Price = <cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#NewPrice#">,
		Quantity = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#qry_Get_Basket.Quantity#">,
		DateAdded = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">
	WHERE Basket_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Basket_ID#">
	</cfquery> 
	
</cfloop>

<cfscript>
	//Get basket product totals
	getProductTotals = Application.objCart.getProductTotals(qry_Get_Basket);
	// Recalculate discounts
	Application.objDiscounts.doBasketDiscounts(getProductTotals);
	// Recalculate promotions
	Application.objPromotions.doBasketPromotions(getProductTotals);	
</cfscript>

<!--- Reset basket totals --->
<cfset doOrderPromos = "yes">
<cfinclude template="act_basket_totals.cfm">
