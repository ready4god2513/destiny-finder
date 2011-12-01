<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<cfcomponent displayname="Shopping Cart Functions" hint="This component is used for handling various calculations for the shopping cart.">
<!--- This component developed by Mary Jo Sminkey maryjo@cfwebstore.com --->
<!--- Developed for use with CFWebstore e-commerce (www.cfwebstore.com) --->

<!--- Requires CFMX 6 or higher --->

<!--- This code is owned by Dogpatch Software and may not be distributes or reused without permission --->

<!------------------------- COMPONENT INITIALIZATION ----------------------------------->
<cffunction name="init" access="public" output="no" returntype="cart">
    <cfreturn this>
  </cffunction>
	
<cffunction name="getProductTotals" displayname="Shopping Basket Totals" hint="Get the quantity and price totals for the products in the shopping cart" output="No" access="public" returntype="struct">

	<cfargument name="getBasket" type="query" required="Yes" hint="Query containing the shopping cart">
	
	<cfscript>
		var CartTotals = StructNew();
		// queries
		var GetItemNums = '';
		var GetProducts = '';
		// loop counters
		var i = 0;
		// other local vars 
		var v = StructNew();		
	</cfscript>
	
	<cfquery name="GetItemNums" dbtype="query">
	SELECT DISTINCT Product_ID, Discounts, Promotions FROM arguments.getBasket
	</cfquery>

	<!--- For each product in the shopping cart, get the subitems and add the totals to the structure --->
	<cfloop query="GetItemNums">
		
		<!--- Since BlueDragon does not support DISTINCT, check that this is not a product already calculated --->
		<cfif NOT StructKeyExists(CartTotals, GetItemNums.Product_ID)>
	
			<cfquery name="GetProducts" dbtype="query">
			SELECT AddonMultP, AddonNonMultP, OptPrice, Price, Quantity, QuantDisc FROM arguments.getBasket
			WHERE Product_ID = #GetItemNums.Product_ID#
			</cfquery>
			
			<cfscript>	
				v.TotalItems = 0;
				v.TotalCost = 0;
				v.ItemTotals = StructNew();
				
				v.numProducts = GetProducts.RecordCount;
				
				for (i=1; i lte v.numProducts; i=i+1) {
					v.TotalItems = v.TotalItems + GetProducts.Quantity[i];
					v.ItemPrice = GetProducts.Price[i] + GetProducts.OptPrice[i] + GetProducts.AddonMultP[i] - GetProducts.QuantDisc[i];
					v.ExtPrice = v.ItemPrice * GetProducts.Quantity[i];
					v.TotalCost = v.TotalCost + v.ExtPrice;
				}
				
				StructInsert(v.ItemTotals, "Quantity", v.TotalItems);
				StructInsert(v.ItemTotals, "Price", v.TotalCost);	
				
				// retrieve the discounts and promotions for the item
				v.ProdDiscounts = Application.objDiscounts.getProdDiscounts(GetItemNums.Discounts, "yes");
				v.ProdPromotions = Application.objPromotions.getProdPromotions(GetItemNums.Promotions);
				
				StructInsert(v.ItemTotals, "Discounts", ValueList(v.ProdDiscounts.Discount_ID));
				StructInsert(v.ItemTotals, "Promotions", ValueList(v.ProdPromotions.Promotion_ID));
				StructInsert(CartTotals, GetItemNums.Product_ID, v.ItemTotals);
			</cfscript>
		
		</cfif>
			
	</cfloop>
	
	<cfreturn CartTotals>

</cffunction>

<cffunction name="doBasketTotals" displayname="Basket Totals" hint="Used to calculate the shopping cart totals, to display on the shopping cart summary, and on the shopping cart page." access="public" output="No" returntype="struct">

	<cfargument name="qryBasket" required="Yes" type="query">
	
	<cfscript>
	// Reset the running totals
	var ProdTotal = 0;
	var DiscTotal = 0;
	var PromoTotal = 0;
	var EstTaxTotal = 0;
	var TotalCost = 0;
	//for addons not calculated with product
	var AddonTotal = 0;
	//for order level discounts
	var QuantTot = 0;
	var OrderDiscount = 0;
	// other local vars 
	var i =0;
	var BasketTotals = StructNew();
	var v = StructNew();
	</cfscript>	
		
	<!--- Process items in the basket --->
	<cfloop query="qryBasket">
		
		<cfscript>
		v.ProdPrice = qryBasket.Price + qryBasket.OptPrice - qryBasket.QuantDisc + qryBasket.AddonMultP;
		v.Ext = v.ProdPrice * qryBasket.Quantity;
		
		v.FinalCost = v.Ext + qryBasket.AddonNonMultP - qryBasket.PromoAmount - (qryBasket.DiscAmount * qryBasket.Quantity);
		
		v.EstTaxItem = calcEstTax(v.FinalCost, qryBasket.TaxCodes);
		
		TotalCost = TotalCost + v.FinalCost;
		
		ProdTotal = ProdTotal + v.Ext;		
		AddonTotal = AddonTotal + qryBasket.AddonNonMultP;
		PromoTotal = PromoTotal + qryBasket.PromoAmount;
		DiscTotal = DiscTotal + (qryBasket.DiscAmount * qryBasket.Quantity);
		EstTaxTotal = EstTaxTotal + v.EstTaxItem;
		
		QuantTot = QuantTot + qryBasket.Quantity;	
		</cfscript>
	
	</cfloop>
	
	<cfscript>
		v.Total = TotalCost + DiscTotal;
		
		// Calculate order-level discounts
		OrderDiscount = Application.objDiscounts.calcOrderDiscount(TotalCost, QuantTot); 
	
		v.TotalDisc = OrderDiscount + DiscTotal;
	
		// Check to see if total discount is greater than basket total 
		if (v.TotalDisc GT v.Total)	{
			v.TotalDisc = v.Total;
			OrderDiscount = v.Total - DiscTotal;
		}
	
		// Round these to two decimal places 
		v.Total = Round(v.Total * 100) / 100;
		v.TotalDisc = Round(v.TotalDisc * 100) / 100;
		PromoTotal = Round(PromoTotal * 100) / 100;
	
		v.CartTotal = v.Total - v.TotalDisc;
		
		//create the structure to return values
		BasketTotals.AddonTotal = AddonTotal;
		BasketTotals.OrderDiscount = OrderDiscount;
		BasketTotals.TotalDisc = v.TotalDisc;
		BasketTotals.PromoTotal = PromoTotal;
		BasketTotals.EstTaxTotal = EstTaxTotal;
		BasketTotals.SubTotal = v.CartTotal;
		BasketTotals.TotalItems = QuantTot;
	
	</cfscript>	
	
	<cflock scope="SESSION" timeout="15" type="EXCLUSIVE">
		<cfset Session.BasketTotals = StructNew()>
		<cfset Session.BasketTotals.Items = QuantTot>
		<cfset Session.BasketTotals.Total = v.CartTotal>
	</cflock>
	
	<cfreturn BasketTotals>

</cffunction>

<cffunction name="doCartItemInfo" displayname="Process Item Info" hint="This function is used to process the add to cart form submission, prior to adding the item to the database." access="public" output="No" returntype="struct">

	<cfargument name="Product_ID" type="numeric" required="Yes" hint="Product ID to add to the cart">
	<cfargument name="Quantity" type="string" required="No" default="1" hint="Quantity to add to the cart">
	
	<cfscript>
	// Initialize addon price and weight information 
	var addQuantity = 1;
	var addSKU = 0;
	var ProdID = arguments.Product_ID;
	//queries
	var Item = '';
	var GrpPrice = '';
	var CheckRows = '';
	var CheckItems = '';
	// loop counters
	var i = 0;
	// other local vars 
	var ItemInfo = StructNew();
	var v = StructNew();
	
	// If arguments.Quantity passed in, make sure it's a number --->
	if (isNumeric(arguments.Quantity))
		addQuantity = arguments.Quantity;
	
	// Round to whole number and make sure it is positive value
	addQuantity = Round(addQuantity);

	if (addQuantity LT 0)
		addQuantity = 0;
		
	ItemInfo.addQuantity = addQuantity;
	</cfscript>
	
	<!--- Check for product and get product info --->
	<cfquery name="Item" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
		SELECT Base_Price, Wholesale, Weight, SKU, OptQuant, Recur
		FROM #Request.DB_Prefix#Products 
		WHERE Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ProdID#">
	</cfquery>
	
	<cfif Item.Recordcount>
	
		<!--- Check for group pricing --->
		<cfquery name="GrpPrice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
		SELECT Price FROM #Request.DB_Prefix#ProdGrpPrice 
		WHERE Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ProdID#">
		AND Group_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Session.Group_ID#">
		</cfquery>
	
		<cfscript>
		ItemInfo.ProdID = ProdID;
		ItemInfo.OptQuant = Item.OptQuant;
		ItemInfo.Recur = Item.Recur;
		
		//only one recurring item allowed
		if (Item.Recur AND addQuantity GT 1)
			ItemInfo.addQuantity = 1;
		
		if (GrpPrice.Recordcount) 
			ItemInfo.addPrice = GrpPrice.Price;
		else if (Session.Wholesaler AND Item.Wholesale IS NOT 0)
			ItemInfo.addPrice = Item.Wholesale;
		else
			ItemInfo.addPrice = Item.Base_price;
	
		ItemInfo.addWeight = Item.Weight;
		addSKU = Item.SKU;
		
		// process Options, check that they were passed in
		if (isDefined("arguments.Prod#ProdID#_Opts")) 
			v.OptList = arguments['Prod' & ProdID & '_Opts'];
		else
			v.OptList = '';
			
		v.NumOptions = ListLen(v.OptList);
		v.strOptions = StructNew();
			
		for(i=1; i lte v.NumOptions; i=i+1) {
			// Add the option to the structure of options for the product
			v.OptID = ListGetAt(v.OptList, i);
			if (isDefined("arguments.Option#v.OptID#")) 
				StructInsert(v.strOptions, v.OptID, arguments['Option' & v.OptID]);
		}
			
		// process the structure of options
		v.addOptions = processOptions(v.strOptions, ProdID, Item.OptQuant);
		
		if (v.addOptions.OptSKU IS NOT 0) 
			addSKU = v.addOptions.OptSKU;	
			
		ItemInfo.addSKU = addSKU;
		ItemInfo.addOptions = v.addOptions;
		
		// end processing of options				
		
		// process Addons, check that they were passed in
		if (isDefined("arguments.Prod#ProdID#_Addons"))	
			v.AddOnList = arguments['Prod' & ProdID & '_Addons'];
		else
			v.AddOnList = '';
			
		v.NumAddons = ListLen(v.AddonList);
		v.strAddons = StructNew();
		
		for(i=1; i lte v.NumAddons; i=i+1) {
			// Add the addon to the structure of addons for the product
			v.AddonID = ListGetAt(v.AddonList, i);
			if (isDefined("arguments.Addon#v.AddonID#")) 
				StructInsert(v.strAddons, v.AddonID, arguments['Addon' & v.AddonID]);
		}
		
		// process the structure of addons
		v.addAddons = processAddons(v.strAddons, ProdID);
		
		// Check for addon info on URL
		if (isDefined("arguments.ExtAddon"))
			v.addAddons.Addons = arguments.ExtAddon;

		ItemInfo.addAddons = v.addAddons;
		
		</cfscript>
		
	<cfelse>
		<!--- Product not found in the database --->
		<cfset ItemInfo.ProdID = 0>
	</cfif>
	
	<cfreturn ItemInfo>

</cffunction>

<cffunction name="doOtherItemInfo" displayname="Process Item Info" hint="This function is used to process the form to move items to the cart, from a gift registry or other cart, prior to adding the item to the database." access="public" output="No" returntype="struct">

	<cfargument name="Product_ID" type="numeric" required="Yes" hint="Product ID to add to the cart">
	<cfargument name="Quantity" type="string" required="No" default="1" hint="Quantity to add to the cart">
	<cfargument name="Options" type="string" required="No" default="" hint="Option description string">
	<cfargument name="Addons" type="string" required="No" default="" hint="Addon description string">
	<cfargument name="AddonMultP" type="numeric" required="No" default="0">
	<cfargument name="AddonNonMultP" type="numeric" required="No" default="0">
	<cfargument name="AddonMultW" type="numeric" required="No" default="0">
	<cfargument name="AddonNonMultW" type="numeric" required="No" default="0">
	<cfargument name="OptQuant" type="numeric" required="No" default="0">
	<cfargument name="OptChoice" type="numeric" required="No" default="0">
	<cfargument name="SKU" type="string" required="No" default="">
	<cfargument name="Price" type="numeric" required="No" default="0">
	<cfargument name="Weight" type="numeric" required="No" default="0">
	<cfargument name="OptPrice" type="numeric" required="No" default="0">
	<cfargument name="OptWeight" type="numeric" required="No" default="0">
	<cfargument name="Recur" type="numeric" required="No" default="0">	
	
	
	<cfscript>
	// local vars
	var ItemInfo = StructNew();
	var Item = '';
	var GrpPrice = '';
	</cfscript>
	
	<!--- Check for product and get product info --->
	<cfquery name="Item" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
		SELECT Base_Price, Wholesale
		FROM #Request.DB_Prefix#Products 
		WHERE Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Product_ID#">
	</cfquery>
	
	<cfif Item.Recordcount>
		<!--- Check for group pricing --->
		<cfquery name="GrpPrice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows=1>
			SELECT Price FROM #Request.DB_Prefix#ProdGrpPrice 
			WHERE Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Product_ID#">
			AND Group_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Session.Group_ID#">
		</cfquery>
		
		<cfscript>
		//move information into the structure
		ItemInfo.ProdID = arguments.Product_ID;
		ItemInfo.addQuantity = arguments.Quantity;
		ItemInfo.OptQuant = arguments.OptQuant;
		ItemInfo.addWeight = arguments.Weight;	
		ItemInfo.addSKU = arguments.SKU;
		ItemInfo.Recur = arguments.Recur;
		
		//updated pricing information
		if (GrpPrice.Recordcount) 
			ItemInfo.addPrice = GrpPrice.Price;
		else if (Session.Wholesaler AND Item.Wholesale IS NOT 0)
			ItemInfo.addPrice = Item.Wholesale;
		else
			ItemInfo.addPrice = Item.Base_price;
		
		//create structure for Option information
		ItemInfo.addOptions = StructNew();
		ItemInfo.addOptions.Options = arguments.Options;
		ItemInfo.addOptions.OptPrice = arguments.OptPrice;
		ItemInfo.addOptions.OptWeight = arguments.OptWeight;
		ItemInfo.addOptions.ChoiceQ = arguments.OptChoice;
		
		//create structure for Addon Information;
		ItemInfo.addAddOns = StructNew();
		ItemInfo.addAddOns.Addons = arguments.Addons;
		ItemInfo.addAddOns.AddonMultP = arguments.AddonMultP;
		ItemInfo.addAddOns.AddonNonMultP = arguments.AddonNonMultP;
		ItemInfo.addAddOns.AddonMultW = arguments.AddonMultW;
		ItemInfo.addAddOns.AddonNonMultW = arguments.AddonNonMultW;
		
		</cfscript>
	
	<cfelse>
		<!--- Product not found in the database --->
		<cfset ItemInfo.ProdID = 0>
	</cfif>
	
	<cfreturn ItemInfo>


</cffunction>

<cffunction name="doAddCartItem" displayname="Add Item to the Shopping Cart" hint="This function is used to add a new item into the cart. It will check if the item already exists, and increment the quantity if so. Otherwise, adds a new line item to the cart. Any number of options and addons may be passed as arguments." output="No" access="public">

	<cfargument name="Product_ID" type="numeric" required="Yes" hint="Product ID to add to the cart">
	<cfargument name="Quantity" type="string" required="No" default="1" hint="Quantity to add to the cart">
	
	<cfscript>
	var Action = 'Insert';
	var ItemInfo = '';
	//queries
	var CheckRows = '';
	var CheckItems = '';
	var UpdateBasket = '';
	var AddItem = '';
	// other local vars 
	var v = StructNew();	
	</cfscript>
	
	<!--- Get Info for the item being added --->
	<cfif isDefined("arguments.GiftItem_ID") OR isDefined("arguments.BasketCopy")>
		<!--- Ordering from a gift registry --->
		<cfinvoke component="cart" method="doOtherItemInfo" returnvariable="ItemInfo" argumentcollection="#arguments#">
	<cfelse>	
		<!--- Normal product cart submissions --->
		<cfinvoke component="cart" method="doCartItemInfo" returnvariable="ItemInfo" argumentcollection="#arguments#">
		
	</cfif>
	
	<!--- Check if a valid product was found --->
	<cfif ItemInfo.ProdID IS NOT 0>

		<cfscript>
		// Check for stored basket, or start a new one
		if (Session.BasketNum IS 0)
			Session.BasketNum = doNewBasket();
			
		</cfscript>
		
		<!--- Check basket to see if product has already been added once --->
		<cfquery name="CheckRows" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
		SELECT Basket_ID FROM #Request.DB_Prefix#TempBasket 
		WHERE BasketNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
		AND Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ItemInfo.ProdID#">
		AND Options <cfif len(ItemInfo.addOptions.Options)>= 
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ItemInfo.addOptions.Options#">
					<cfelse>is Null</cfif>
		AND AddOns <cfif len(ItemInfo.addAddOns.Addons)>= 
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ItemInfo.addAddOns.Addons#">
					<cfelse> is Null</cfif>
		<cfif isDefined("arguments.GiftItem_ID")>
			AND GiftItem_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.GiftItem_ID#">
		</cfif>
		</cfquery>
	
		<cfif CheckRows.RecordCount>
		
			<cfset Action = "Update">		
	
		<cfelse><!--- add item ----->
		
			<cfscript>
				//Get next number for basket Item
				//UUID for new basket item ID
				v.basket_ID = CreateUUID();
				v.basket_ID = Replace(v.basket_ID, "-", "", "All");	
			</cfscript>
	
		</cfif>
			
		<!--- Only add additional item if not a recurring membership --->
		<cfif Action IS 'Update' AND NOT ItemInfo.Recur>
			<cfquery name="UpdateBasket" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#TempBasket
				SET Quantity = Quantity + <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ItemInfo.addQuantity#">,
				DateAdded = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">
				WHERE Basket_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#CheckRows.Basket_ID#">
			</cfquery>
			
		<cfelseif Action IS 'Insert'>
			<!--- Add item to basket --->
			<cfquery name="AddItem" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			INSERT INTO #Request.DB_Prefix#TempBasket
				(Basket_ID, BasketNum, Product_ID, GiftItem_ID, 
				Options, AddOns, AddonMultP, AddonNonMultP, AddonMultW, AddonNonMultW, OptPrice, OptWeight,
				SKU, Price, Weight, Quantity, OptQuant, OptChoice, Discount, PromoAmount, QuantDisc, DateAdded)
			VALUES
				(<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#v.basket_ID#">, 
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">, 
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ItemInfo.ProdID#">, 
				<cfif isDefined("arguments.GiftItem_ID")>
					<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.GiftItem_ID#">,
				<cfelse> 0, </cfif>
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ItemInfo.addOptions.Options#" 
								null="#YesNoFormat(NOT len(ItemInfo.addOptions.Options))#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ItemInfo.addAddOns.Addons#" 
								null="#YesNoFormat(NOT len(ItemInfo.addAddOns.Addons))#">,
				<cfif isDefined("ItemInfo.addAddOns.AddonMultP")>
					<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#ItemInfo.addAddOns.AddonMultP#">,
					<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#ItemInfo.addAddOns.AddonNonMultP#">,
					<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#ItemInfo.addAddOns.AddonMultW#">,
					<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#ItemInfo.addAddOns.AddonNonMultW#">,
				<cfelse>
					0,0,0,0,
				</cfif>
				<cfqueryparam value="#ItemInfo.addOptions.OptPrice#" cfsqltype="CF_SQL_DOUBLE">, 
				<cfqueryparam value="#ItemInfo.addOptions.OptWeight#" cfsqltype="CF_SQL_DOUBLE">, 	
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ItemInfo.addSKU#" null="#YesNoFormat(NOT len(ItemInfo.addSKU))#">,
				<cfqueryparam value="#ItemInfo.addPrice#" cfsqltype="CF_SQL_DOUBLE">,
				<cfqueryparam value="#ItemInfo.addWeight#" cfsqltype="CF_SQL_DOUBLE">,	
				<cfqueryparam value="#ItemInfo.addQuantity#" cfsqltype="CF_SQL_INTEGER">, 
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ItemInfo.OptQuant#">, 
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ItemInfo.addOptions.ChoiceQ#">, 
				0, 0, 0,
				<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#"> )
			</cfquery>	
		
		</cfif>
	
	<!--- end product check --->	
	</cfif>

</cffunction>

<cffunction name="doAddOrderItem" displayname="Add Item to an Order" hint="This function is used to add a new item to an order.  Any number of options and addons may be passed as arguments." returntype="numeric" output="No" access="public">

	<cfargument name="Order_No" type="numeric" required="Yes" hint="The order we are adding this item to.">
	<cfargument name="Product_ID" type="numeric" required="Yes" hint="Product ID to add to the order">
	<cfargument name="Quantity" type="string" required="No" default="1" hint="Quantity to add to the order">
	
	<cfscript>
	var ItemInfo = '';
	//queries
	var Prod_info = '';
	var GetNext = '';
	var AddItem = '';
	var UpdOrder = '';
	//return var
	var OptChoiceID = 0;
	</cfscript>
	
	<!--- Get Info for the item being added --->
	<cfinvoke component="cart" method="doCartItemInfo" returnvariable="ItemInfo" argumentcollection="#arguments#">
	
	<!--- Check if a valid product was found --->
	<cfif ItemInfo.ProdID IS NOT 0>
	
		<!--- Get the product's information --->
		<cfquery name="Prod_info" datasource="#Request.DS#" username="#Request.user#" 
		password="#Request.pass#" maxrows="1">
		SELECT Name, Account_ID, Dropship_Cost, Vendor_SKU, Prod_Type 
		FROM #Request.DB_Prefix#Products
		WHERE Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ItemInfo.ProdID#">
		</cfquery>
		
		<cftransaction isolation="SERIALIZABLE">
		<cfquery name="GetNext" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT MAX(Item_ID) AS newID FROM #Request.DB_Prefix#Order_Items 
			WHERE Order_No = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Order_No#">
		</cfquery>
	
		<!--- Add the item to order database --->
		<cfquery name="AddItem" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		INSERT INTO #Request.DB_Prefix#Order_Items 
			(Item_ID, Order_No, Product_ID, Name, SKU, Options, Addons, AddonMultP, AddonNonMultP,
			Price, OptPrice, Quantity, DiscAmount, Disc_Code, PromoAmount, PromoQuant, Promo_Code, 
			OptQuant, OptChoice, Dropship_Account_ID, Dropship_Qty, Dropship_Cost, Dropship_SKU )
		
		VALUES 
			(<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#iif(isNumeric(GetNext.newID), Evaluate(DE('GetNext.newID+1')), 1)#">,
			<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Order_No#">, 
			<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ItemInfo.ProdID#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Prod_info.Name#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ItemInfo.addSKU#" null="#YesNoFormat(NOT len(ItemInfo.addSKU))#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ItemInfo.addOptions.Options#" 
								null="#YesNoFormat(NOT len(ItemInfo.addOptions.Options))#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ItemInfo.addAddOns.Addons#" 
								null="#YesNoFormat(NOT len(ItemInfo.addAddOns.Addons))#">,
			<cfif isDefined("ItemInfo.addAddOns.AddonMultP")>
				<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#ItemInfo.addAddOns.AddonMultP#">,
				<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#ItemInfo.addAddOns.AddonNonMultP#">, 
			<cfelse>
				0, 0, 
			</cfif>
			<cfqueryparam value="#ItemInfo.addPrice#" cfsqltype="CF_SQL_DOUBLE">,
			<cfqueryparam value="#ItemInfo.addOptions.OptPrice#" cfsqltype="CF_SQL_DOUBLE">, 
			<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Quantity#">, 
			0, NULL, 0, 0, NULL, 
			<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ItemInfo.OptQuant#">, 
			<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#ItemInfo.addOptions.ChoiceQ#">, 
			<cfif Prod_info.Account_ID gt 0>
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Prod_info.Account_ID#">,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Quantity#">,
			<cfelse>
				NULL, 0, 
			</cfif>
			<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#iif(isNumeric(Prod_info.dropship_cost), Prod_info.dropship_cost, 0)#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Prod_info.Vendor_SKU#" null="#YesNoFormat(NOT len(Prod_info.Vendor_SKU))#">
			)
		</cfquery>
		</cftransaction>
		
		<!--- Update the Order Total for this order --->
		<cfset ItemTotal = (ItemInfo.addPrice + ItemInfo.addOptions.OptPrice) * arguments.Quantity>
		<cfquery name="UpdOrder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#Order_No
			SET OrderTotal = OrderTotal + <cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#ItemTotal#">,
			Admin_Name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.Realname#">,
			Admin_Updated = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">
			WHERE Order_No = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Order_No#">
		</cfquery>		
		
		<!--- Return the selected option choice --->
		<cfset OptChoiceID = ItemInfo.addOptions.ChoiceQ>
	
	<!--- end product check --->	
	</cfif>
	
	<cfreturn OptChoiceID>

</cffunction>


<cffunction name="addProducttoRegistry" displayname="Adds Product to the Gift Registry" hint="This function is used to add a single product into the gift registry. Any number of options and addons may be passed as arguments." output="No" access="public">

	<cfargument name="GiftRegistry_ID" required="Yes" type="numeric" hint="ID for the registry to add the product to.">
	<cfargument name="Product_ID" type="numeric" required="Yes" hint="Product ID to add to the cart">
	<cfargument name="Quantity" type="string" required="No" default="1" hint="Quantity to add to the cart">
	
	<cfscript>
	var ItemInfo = '';
	//queries
	var CheckRows = '';
	var UpdateRegistry = '';
	var GetNext = '';
	var AddItem = '';
	</cfscript>
	
	<!--- Get Info for the item being added --->
	<cfinvoke component="cart" method="doCartItemInfo" returnvariable="ItemInfo" argumentcollection="#arguments#">
	
	<!--- Check if a valid product was found --->
	<cfif ItemInfo.ProdID IS NOT 0>

		<!--- Call the add item to registry function, passing in the variables as needed --->	
		<cfinvoke component="cart" method="doAddRegistryItem" 
			GiftRegistry_ID="#arguments.GiftRegistry_ID#"
			Product_ID="#ItemInfo.ProdID#"
			Quantity="#ItemInfo.addQuantity#"
			Price="#ItemInfo.addPrice#"
			Weight="#ItemInfo.addWeight#"
			addOptions="#ItemInfo.addOptions#"
			addAddOns="#ItemInfo.addAddOns#"
			SKU="#ItemInfo.addSKU#"
			OptQuant="#ItemInfo.OptQuant#"
			Recur="#ItemInfo.Recur#">		
		
	</cfif>

</cffunction>


<cffunction name="moveCarttoRegistry" displayname="Move Cart to Gift Registry" hint="This function is used to take all the items currently in the user's shopping cart and transfer them to their gift registry. It will check if the item already exists, and increment the quantity if so. Otherwise, adds a new line item to the registry." output="No" access="public">

	<cfargument name="GiftRegistry_ID" required="Yes" type="numeric" hint="The gift registry to add the items to.">
	
	<cfscript>
		var qryBasket = getBasket();
		var addAddOns = StructNew();
		var addOptions = StructNew();
	</cfscript>
	
	<cfloop query="qryBasket">

		<cfscript>
			//Move Addon information to structure
			addAddOns.Addons = qryBasket.Addons;
			addAddOns.AddonMultP = qryBasket.AddonMultP;
			addAddOns.AddonMultW = qryBasket.AddonMultW;
			addAddOns.AddonNonMultP = qryBasket.AddonNonMultP;
			addAddOns.AddonNonMultW = qryBasket.AddonNonMultW;
			
			//Move Option information to structure
			addOptions.Options = qryBasket.Options;
			addOptions.OptPrice = qryBasket.OptPrice;
			addOptions.OptWeight = qryBasket.OptWeight;
			addOptions.ChoiceQ = qryBasket.OptChoice;
			
		</cfscript>
	
		<!--- Run the function to add the item to the registry --->
		<cfinvoke component="cart" method="doAddRegistryItem" 
			GiftRegistry_ID="#arguments.GiftRegistry_ID#"
			Product_ID="#qryBasket.Product_ID#"
			Quantity="#qryBasket.Quantity#"
			Price="#qryBasket.Price#"
			Weight="#qryBasket.Weight#"
			Recur="#qryBasket.Recur#"
			addOptions="#addOptions#"
			addAddOns="#addAddOns#"
			SKU="#qryBasket.SKU#"
			OptQuant="#qryBasket.OptQuant#">
	
	</cfloop>
	
	<!--- Clear shopping cart and reset totals --->
	<cfscript>
		Application.objCheckout.clearTempTables();
		//Reset basket totals
		qryBasket = Application.objCart.getBasket();
		Application.objCart.doBasketTotals(qryBasket);	
	</cfscript>

</cffunction>

<cffunction name="doAddRegistryItem" displayname="Add Item to the Gift Registry" hint="This function is used to add a new item into a gift registry. It will check if the item already exists, and increment the quantity if so. Otherwise, adds a new line item to the registry." returntype="void" output="No" access="public">

	<cfargument name="GiftRegistry_ID" required="Yes" type="numeric" hint="ID for the registry to add the item to.">
	<cfargument name="Product_ID" required="Yes" type="numeric" hint="ID for the product to add to the registry.">
	<cfargument name="Quantity" required="Yes" type="numeric" hint="Quantity to add.">
	<cfargument name="Price" required="Yes" type="numeric" hint="Current item price.">
	<cfargument name="Weight" required="Yes" type="numeric" hint="Current item weight.">
	<cfargument name="addOptions" required="Yes" type="struct" hint="Structure containing the option information">
	<cfargument name="addAddOns" required="Yes" type="struct" hint="Structure containing the addon information">
	<cfargument name="SKU" required="Yes" type="string" hint="SKU for the selected item, if any">
	<cfargument name="OptQuant" required="Yes" type="numeric" hint="The ID for the option on this product that does inventory tracking.">
	<cfargument name="Recur" required="No" type="boolean" hint="Checks if this is a recurring item.">
	
<cfscript>
	//queries
	var CheckRows = '';
	var UpdateRegistry = '';
	var GetNext = '';
	var AddItem = '';
	</cfscript>
	
	<!--- Check registry to see if product has already been added once --->
	<cfquery name="CheckRows" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" maxrows="1">
		SELECT GiftItem_ID FROM #Request.DB_Prefix#GiftItems 
		WHERE GiftRegistry_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.GiftRegistry_ID#">
		AND Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Product_ID#">
		AND Options <cfif len(arguments.addOptions.Options)>
						= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.addOptions.Options#">
					<cfelse>is Null</cfif>
		AND AddOns <cfif len(arguments.addAddOns.AddOns)>
						= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.addAddOns.AddOns#">
					<cfelse>is Null</cfif>
	</cfquery>
		
	<!--- Only update quantity if not a recurring item --->
	<cfif CheckRows.RecordCount AND NOT arguments.Recur>
		
		<!--- Update quantity for this item --->
		<cfquery name="UpdateRegistry" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			UPDATE #Request.DB_Prefix#GiftItems
			SET Quantity_Requested = Quantity_Requested + 
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Quantity#">,
			DateAdded = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#">
			WHERE GiftItem_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#CheckRows.GiftItem_ID#">
		</cfquery>
			
	<cfelse>
		<!--- Add new item to the registry --->		
		<cfquery name="AddItem" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		INSERT INTO #Request.DB_Prefix#GiftItems
			(GiftRegistry_ID, Product_ID, Options, Addons, AddonMultP, AddonNonMultP, AddonMultW, AddonNonMultW,
			OptQuant, OptChoice, OptPrice, OptWeight, SKU, Price, Weight, Quantity_Requested, Quantity_Purchased, DateAdded)
		VALUES
			(<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.GiftRegistry_ID#">, 
			<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Product_ID#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.addOptions.Options#" 
					null="#YesNoFormat(NOT len(arguments.addOptions.Options))#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.addAddOns.Addons#" 
					null="#YesNoFormat(NOT len(arguments.addAddOns.Addons))#">,
			<cfif isDefined("arguments.addAddOns.AddonMultP")>
				<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#arguments.addAddOns.AddonMultP#">,
				<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#arguments.addAddOns.AddonNonMultP#">,
				<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#arguments.addAddOns.AddonMultW#">,
				<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#arguments.addAddOns.AddonNonMultW#">,
			<cfelse>
				0,0,0,0,
			</cfif>
			<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.OptQuant#">, 
			<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.addOptions.ChoiceQ#">,
			<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#arguments.addOptions.OptPrice#">,
			<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#arguments.addOptions.OptWeight#">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.SKU#" null="#YesNoFormat(NOT len(arguments.SKU))#">,
			<cfqueryparam value="#arguments.Price#" cfsqltype="CF_SQL_DOUBLE">, 
			<cfqueryparam value="#arguments.Weight#" cfsqltype="CF_SQL_DOUBLE">, 		
			<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Quantity#">, 
			0, <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Now()#"> )
		</cfquery>
	
	</cfif>
	

</cffunction>


<cffunction name="processOptions" displayname="Process Product Options" hint="This function retrieves the information for the options included with the product and sends back the final options string, price/weight totals, SKU from the option (if any) and selected option choice for inventory (if any)." output="No" returntype="struct">

	<cfargument name="strOptions" required="Yes" type="struct" hint="Structure containing the list of option IDs and the option choice selected by the customer">
	<cfargument name="Product_ID" required="Yes" type="numeric" hint="Product ID the options are for">
	<cfargument name="OptQuant" required="Yes" type="numeric" hint="Option ID being used for inventory amounts">
	
	<cfscript>
	var OptionString = '';
	var ChoiceQ = 0;
	var OptSKU = 0;
	var optPrice = 0;
	var optWeight = 0;
	var strOptionInfo = StructNew();
	var OptionIDs = StructKeyList(arguments.strOptions);
	//queries 
	var GetOptions = '';
	var GetChoice = '';
	// loop counters
	var num = '';
	// other local vars 
	var v = StructNew();
	</cfscript>
	
	<cfif len(OptionIDs)>
		
		<!--- Retrieve the option information --->
		<cfquery name="GetOptions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT PO.*, SO.Std_Desc, SO.Std_Required, SO.Std_Prompt
			FROM #Request.DB_Prefix#Product_Options PO 
			LEFT JOIN #Request.DB_Prefix#StdOptions SO ON PO.Std_ID = SO.Std_ID
			WHERE PO.Option_ID IN (<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#OptionIDs#" list="Yes">)
			AND PO.Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Product_ID#">
			ORDER BY PO.Priority, PO.Option_ID
		</cfquery>	
		
		<cfloop query="GetOptions">
		
			<cfset v.Option = arguments.strOptions[GetOptions.Option_ID]>		
			
			<!--- retrieve option choice information --->
			<cfif isNumeric(v.Option)>
				<cfquery name="GetChoice" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				SELECT SC.Choice_ID, SC.ChoiceName, SC.Price, SC.Weight, PC.SKU, PC.NumInStock
				FROM #Request.DB_Prefix#StdOpt_Choices SC, 
					#Request.DB_Prefix#Product_Options PO,
					#Request.DB_Prefix#ProdOpt_Choices PC
				WHERE PO.Option_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#GetOptions.Option_ID#">
				AND PC.Choice_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#v.Option#">
				AND PO.Std_ID = SC.Std_ID
				AND SC.Choice_ID = PC.Choice_ID
				AND PC.Option_ID = PO.Option_ID
				
				UNION 
				
				SELECT SC.Choice_ID, SC.ChoiceName, SC.Price, SC.Weight, '' AS SKU, 0 AS NumInStock
				FROM #Request.DB_Prefix#StdOpt_Choices SC, #Request.DB_Prefix#Product_Options PO
				WHERE PO.Option_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#GetOptions.Option_ID#">
				AND SC.Choice_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#v.Option#">
				AND PO.Std_ID = SC.Std_ID
				AND NOT EXISTS (SELECT * FROM #Request.DB_Prefix#ProdOpt_Choices PC
								WHERE Option_ID = PO.Option_ID
								AND Choice_ID = SC.Choice_ID)			
				
				UNION
				
				SELECT PC.Choice_ID, PC.ChoiceName, PC.Price, PC.Weight, PC.SKU, PC.NumInStock
				FROM #Request.DB_Prefix#ProdOpt_Choices PC, #Request.DB_Prefix#Product_Options PO 
				WHERE PO.Option_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#GetOptions.Option_ID#">
				AND PC.Choice_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#v.Option#">
				AND PO.Option_ID = PC.Option_ID	
				AND PO.Std_ID = 0
				</cfquery>	
				
			<cfelse>
				<cfset GetChoice = QueryNew("Choice_ID")>
			</cfif>
			
			<cfscript>
			// Regular Product Option 
			if (GetOptions.Std_ID IS 0) {
				v.Required = GetOptions.Required;
				v.OptDesc = GetOptions.OptDesc;	
				v.UserPrompt = GetOptions.Prompt;
			}
			
			else {
				v.Required = GetOptions.Std_Required;
				v.OptDesc = GetOptions.Std_Desc;	
				v.UserPrompt = GetOptions.Std_Prompt;	
			}
			
			//set option description
			if (Len(v.OptDesc) IS 0) 
				v.OptDesc = v.UserPrompt;
			
			// Check if anything entered for the option
			if ((v.Required OR arguments.OptQuant IS GetOptions.Option_ID) AND NOT len(Trim(v.Option))) {
				v.ProdID = arguments.product_id;
				doRedirect('Prod_ID=#v.ProdID#&Filler=No##Prod#v.ProdID##Request.Token2#');			
			}
			
			else if (GetChoice.Recordcount) {
			
				//add choices to weight, price and SKU
				optPrice = optPrice + GetChoice.Price;
				optWeight = optWeight + GetChoice.Weight;
				
				if (len(GetChoice.SKU)) 
					OptSKU = GetChoice.SKU;
					
				// Check if current option is used for inventory, if so pass the choice number
				if (arguments.OptQuant IS GetOptions.Option_ID) 
					ChoiceQ = v.Option;	
			
				// append option to string
				OptionString = ListAppend(OptionString, v.OptDesc);
				OptionString = OptionString & ":" & GetChoice.ChoiceName;
			}
			
			</cfscript>
		
		</cfloop>
	
	</cfif>
	
	<cfscript>
	
		strOptionInfo.Options = Replace(OptionString, ",", ", ", "ALL");
		strOptionInfo.OptWeight = optWeight;
		strOptionInfo.OptPrice = optPrice;
		strOptionInfo.OptSKU = OptSKU;
		strOptionInfo.ChoiceQ = ChoiceQ;
	
	</cfscript>
	
	<cfreturn strOptionInfo>
	
</cffunction>

<cffunction name="processAddons" displayname="Process Product Addons" hint="This function retrieves the information for the addons included with the product and sends back the final addon string and price/weight totals." output="No" returntype="struct">

	<cfargument name="strAddons" required="Yes" type="struct" hint="Structure containing the list of addon IDs and the included addon information from the customer">
	<cfargument name="Product_ID" required="Yes" type="numeric" hint="Product ID the addons are for">
	<cfargument name="redirectto" required="No" type="string" default="product" hint="Determines where to redirect if required addon missing.">
	
	<cfscript>
	var AddonMultP = 0;
	var AddonNonMultP = 0;
	var AddonMultW = 0;
	var AddonNonMultW = 0;	
	var AddonList = '';
	var strAddonInfo = StructNew();
	var AddonIDs = StructKeyList(arguments.strAddons);
	//queries 
	var GetAddons  = '';
	// loop counters
	var num = '';
	// other local vars 
	var v = StructNew();
	</cfscript>
	
	<cfif len(AddonIDs)>
		
		<!--- retrieve addon information --->
		<cfquery name="GetAddons" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT PA.*, SA.Std_Desc, SA.Std_Price, SA.Std_Weight, SA.Std_Type, SA.Std_ProdMult, SA.Std_Required
		FROM #Request.DB_Prefix#ProdAddons PA 
		LEFT JOIN #Request.DB_Prefix#StdAddons SA ON PA.Standard_ID = SA.Std_ID
		WHERE PA.Addon_ID IN (<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#AddonIDs#" list="Yes">)
		</cfquery>	
		
		<cfloop query="GetAddons">
		
			<cfset v.Addon = arguments.strAddons[GetAddons.Addon_ID]>
			
			<cfscript>
			
			if (GetAddons.Standard_ID IS 0) {
				// Custom Addon 
				v.CartDesc = GetAddons.AddonDesc;
				v.AddPrice = GetAddons.Price;
				v.AddWeight = GetAddons.Weight;
				v.PriceMult = GetAddons.ProdMult;
				v.AddType = GetAddons.AddonType;
				v.Required = GetAddons.Required;
			}
			
			else {
				// Standard Addon 
				v.CartDesc = GetAddons.Std_Desc;
				v.AddPrice = GetAddons.Std_Price;
				v.AddWeight = GetAddons.Std_Weight;
				v.PriceMult = GetAddons.Std_ProdMult;
				v.AddType = GetAddons.Std_Type;
				v.Required = GetAddons.Std_Required;
			}
								
			// Check if anything entered for the addon
			if (v.Required and NOT len(Trim(v.Addon))) {
				v.ProdID = arguments.product_id;
				if (arguments.redirectto IS "product")
					doRedirect('Prod_ID=#v.ProdID#&Filler=No##Prod#v.ProdID##Request.Token2#');
				else if (arguments.redirectto IS "order")
					strAddonInfo.Redirect = "Yes";
			}
			
			else if (Len(Trim(v.Addon))) {
				
				// If quantity, make sure number entered 
				if (v.AddType IS 'quantity' AND NOT isNumeric(v.Addon))
					v.Addon = 1;			
				
				// Append addon descriptions 
				AddonList = AddonList & v.CartDesc;
				AddonList = AddonList & ": " & v.Addon & "<br />";
				
				// If quantity, multiply the price and weight 
				if (v.AddType IS "quantity") {
					v.AddPrice = v.AddPrice * v.Addon;
					v.AddWeight = v.AddWeight * v.Addon;
				}
				
				// Set Price and Weight multipliers
				if (v.PriceMult) {
					AddonMultP = AddonMultP + v.AddPrice;
					AddonMultW = AddonMultW + v.AddWeight;
				}
				
				else {
					AddonNonMultP = AddonNonMultP + v.AddPrice;
					AddonNonMultW = AddonNonMultW + v.AddWeight;
				}	
			
			}
			</cfscript>
	
		</cfloop>
	
	</cfif>
	
	<cfscript>
		strAddonInfo.Addons = AddonList;
		strAddonInfo.AddonMultP = AddonMultP;
		strAddonInfo.AddonMultW = AddonMultW;
		strAddonInfo.AddonNonMultP = AddonNonMultP;
		strAddonInfo.AddonNonMultW = AddonNonMultW;
	</cfscript>
	
	<cfreturn strAddonInfo>

</cffunction>

<cffunction name="calcProdTax" description="Calculates the prices with tax for a selected product based on the item prices." access="public" output="No" returntype="struct">

	<cfargument name="ProdPrices" required="Yes" type="struct" hint="Structure containing the product prices.">
	<cfargument name="Tax_List" required="Yes" type="string" hint="List of Tax Code IDs for the product">
	
	<cfscript>
	var qryProdTaxes = getProdTaxes();
	var strTaxedPrices = StructNew();
	//queries
	var prodTax = '';
	</cfscript>
	
	<cfif qryProdTaxes.Recordcount AND len(arguments.Tax_List)>
		<cfquery name="prodTax" dbtype="query">
			SELECT * FROM qryProdTaxes
			WHERE Code_ID IN (#arguments.Tax_List#)
		</cfquery>
		
		<cfscript>
			if (prodTax.Recordcount) {
				strTaxedPrices.TaxName = prodTax.DisplayName;
				strTaxedPrices.RetailPrice = PricewithTax(arguments.ProdPrices.RetailPrice, prodTax.TaxRate);
				strTaxedPrices.BasePrice = PricewithTax(arguments.ProdPrices.BasePrice, prodTax.TaxRate);
				strTaxedPrices.WholesalePrice = PricewithTax(arguments.ProdPrices.WholesalePrice, prodTax.TaxRate);
				strTaxedPrices.GroupPrice = PricewithTax(arguments.ProdPrices.GroupPrice, prodTax.TaxRate);			
			}
		</cfscript>		
	</cfif>
	
	<cfreturn strTaxedPrices>	

</cffunction>

<cffunction name="calcEstTax" description="Calculates an estimated tax for the products in the shopping cart." access="public" output="No" returntype="numeric">

	<cfargument name="TotalPrice" required="Yes" type="numeric" hint="The total amount for this product.">
	<cfargument name="Tax_List" required="Yes" type="string" hint="List of Tax Code IDs for the product">
	
	<cfscript>
	var qryProdTaxes = getProdTaxes();
	var TaxAmount = 0;
	//queries
	var prodTax = '';
	</cfscript>
	
	<cfif qryProdTaxes.Recordcount AND len(arguments.Tax_List)>
		<cfquery name="prodTax" dbtype="query">
			SELECT * FROM qryProdTaxes
			WHERE Code_ID IN (#arguments.Tax_List#)
		</cfquery>
		
		<cfscript>
			if (prodTax.Recordcount) {
				TaxAmount = Round(arguments.TotalPrice*prodTax.TaxRate*100)/100;
			}
		</cfscript>		
	</cfif>
	
	<cfreturn TaxAmount>	

</cffunction>

<cffunction name="PricewithTax" displayname="Calculate Price with Tax" hint="Calculates the total product price with tax included." output="No" returntype="numeric" access="public">

	<cfargument name="Price" type="numeric" required="Yes">
	<cfargument name="TaxRate" type="numeric" required="Yes">
	
	<cfset var TaxAmount = arguments.Price * arguments.TaxRate>
	<cfset TaxAmount = Round(TaxAmount*100)/100>
	<cfreturn arguments.Price+TaxAmount>

</cffunction>

<cffunction name="getProdTaxes" displayname="Get Product Taxes" hint="Gets the full list of product tax rates used for the store" output="No" access="public" returntype="query">
	
	<cfargument name="reset" required="No" default="no" hint="Set whether to refresh this cached query.">

	<cfscript>
		var qryProdTaxes = ''; 
		
		if (arguments.reset)
			Request.Cache = CreateTimeSpan(0, 0, 0, 0);
	</cfscript>

	<cfquery name="qryProdTaxes" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" cachedwithin="#Request.Cache#">
		SELECT Code_ID, DisplayName, TaxShipping, TaxRate 
		FROM #Request.DB_Prefix#TaxCodes
		WHERE ShowonProds = 1
		ORDER BY CalcOrder, Code_ID
	</cfquery>
	
	<cfreturn qryProdTaxes>

</cffunction>


<cffunction name="getBasket" displayname="Get Basket" hint="Retrieves the shopping basket for the current user." output="no" returntype="query" access="public">

	<cfset var qry_Get_Basket = "">

	<cfquery name="qry_Get_Basket" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT TB.*, P.Shipping, P.Name, P.TaxCodes, P.Prod_Type, P.Display, P.NotSold, P.Sale_Start, P.Sale_End, 
		P.Discounts, P.Promotions, P.Freight_Dom, P.Freight_Intl, P.Pack_Length, P.Pack_Width, P.Pack_Height,
		P.OptQuant AS ProdOptQuant, P.Account_ID AS DropShipper, P.GiftWrap, P.Recur, P.Recur_Product_ID, P.Base_Price, 
		P.Wholesale, P.Min_Order, P.Mult_Min, GR.Registrant, GR.GiftRegistry_Type, GR.GiftRegistry_ID
		FROM ((#Request.DB_Prefix#TempBasket TB 
				INNER JOIN #Request.DB_Prefix#Products P ON TB.Product_ID = P.Product_ID) 
			LEFT JOIN #Request.DB_Prefix#GiftItems GI on GI.GiftItem_ID = TB.GiftItem_ID)
		LEFT JOIN #Request.DB_Prefix#GiftRegistry GR ON GI.GiftRegistry_ID = GR.GiftRegistry_ID
		WHERE BasketNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
	</cfquery>
	
	<cfreturn qry_Get_Basket>

</cffunction>


<cffunction name="doNewBasket" displayname="New Shopping Cart" hint="Creates the shopping cart." access="public" output="No" returntype="string">
<!--- This functions sets the basket number. It is stored in three variables:
	SESSION.BASKETNUM
	COOKIE
	USER
	--->	
	<cfscript>
		var BasketNum = 0;
		//queries
		var updUsers = '';
		var UpdUser = '';
		var qryBasket = '';
	</cfscript>
		
	<!--- If the basket ID is in a cookie, retrieve it from there --->
	<cfif isDefined("cookie.#Request.DS#_Basket")>
		<cfset BasketNum = cookie[Request.DS & '_Basket']>
	
	<cfelse>
		<cfset BasketNum = doBasketString()>
		
	</cfif>
	
	<cfscript>	
		// reset the basket totals
		Session.BasketNum = BasketNum;
		qryBasket = getBasket();
		doBasketTotals(qryBasket);		
	</cfscript>
	
	<cfreturn BasketNum>

</cffunction>


<cffunction name="copyBasketItems" displayname="Copy Basket Items" hint="Copies items from a stored shopping cart into the user's current temporary cart" access="public" output="No" returntype="void">
	<cfargument name="BaskettoCopy" required="Yes" type="string" hint="Basket to copy from">
	
	<cfscript>
		//queries
		var qryGetItems = '';
		//loops
		var i = 0;
		//other local vars
		var cols = '';
	</cfscript>
	
	<cfquery name="qryGetItems" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT * FROM #Request.DB_Prefix#TempBasket TB 
		WHERE BasketNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.BaskettoCopy#">
	</cfquery>
	
	<!--- For each item in the cart, loop through and move items into attributes scope, then copy to the shopping cart --->
	<cfloop query="qryGetItems">
		<cfscript>
			cols = listToArray(qryGetItems.ColumnList);
			for (i=1; i lte ArrayLen(cols); i=i+1) {	
				//BlueDragon does not accept null arguments, so make sure all empty fields are sent as strings
				if (NOT len(qryGetItems[cols[i]][currentrow])) {
					SetVariable('attributes.' & cols[i], '');
					}
				else  {
					SetVariable('attributes.' & cols[i], qryGetItems[cols[i]][currentrow]);
					}
				}
			// Mark this as a shopping cart copy 
			attributes.BasketCopy = "yes";
			//Copy to the current cart
			doAddCartItem(argumentcollection=attributes);
		</cfscript>
		
	</cfloop>

</cffunction>


<cffunction name="doBasketString" displayname="Basket String" hint="Creates a new shopping basket string identifier." output="no" returntype="string" access="public">
<!--- The shopping basket number is made from the user's IP address and a time/date stamp --->

	<cfscript>
		var BasketNum = '';
		var DateStamp = NumberFormat(Now(),"_____");
		var TimeStamp = MID(Now(),16,9);
		var OriginIP = REPLACE(CGI.REMOTE_ADDR,".","","ALL");
			
		TimeStamp = REPLACE(TimeStamp,":","","ALL");
		TimeStamp = REPLACE(TimeStamp," ","","ALL");
	
		BasketNum = DateStamp & TimeStamp & OriginIP;
	
	</cfscript>
	
	<cfreturn BasketNum>

</cffunction>

<cffunction name="dspBasketStats" displayname="Display Basket Stats" hint="Generates the string to output the shopping basket statistics" output="No" access="public" returntype="string">

	<cfargument name="class" required="No" type="string" default="menu_footer">
	
	<cfscript>
		var CartItems = 0;
		var CartTotal = 0;	
		var strText = '';
	
		if (isStruct(Session.BasketTotals)) {
			CartItems = Session.BasketTotals.Items;
			CartTotal = Session.BasketTotals.Total;
		}
	</cfscript>
	
	<cfsavecontent variable="strText">
	<cfoutput><a class="#arguments.class#" href="#Request.StoreURL##request.self#?fuseaction=shopping.basket#Request.Token2#">Cart items: #CartItems# &nbsp;Total: #LSCurrencyFormat(CartTotal)#</a></cfoutput>
	</cfsavecontent>	
	
	<cfreturn strText>


</cffunction>


<cffunction name="doRedirect" hint="Redirects the user if information was missing when adding cart items" output="No" returntype="void" access="public">
	
	<cfargument name="location" required="Yes" type="string">
	
	<cfif NOT Find("?", Session.Page)>
		<cflocation url="#Session.Page#?#arguments.location#" addtoken="No">
	<cfelse>
		<cflocation url="#Session.Page#&#arguments.location#" addtoken="No">
	</cfif>

</cffunction>

</cfcomponent>


