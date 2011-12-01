<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<cfcomponent displayname="Discounts Functions" hint="This component is used for handling various discount calculations for the store. Can be saved to application scope.">
<!--- This component developed by Mary Jo Sminkey maryjo@cfwebstore.com --->
<!--- Developed for use with CFWebstore e-commerce (www.cfwebstore.com) --->

<!--- Requires CFMX 6 or higher --->

<!--- This code is owned by Dogpatch Software and may not be distributes or reused without permission --->

<!------------------------- COMPONENT INITIALIZATION ----------------------------------->
<cffunction name="init" access="public" output="no" returntype="discounts">
    <cfreturn this>
  </cffunction>
  

<cffunction name="getDiscountMess" displayname="Discount Message" hint="Used to get the discount message, for a selected product, for the entire store, or for the order." returntype="string" output="No" access="public">

	<cfargument name="DiscList" type="string" required="No" default="" hint="For a product discount, the list of discounts for the product">
	<cfargument name="DiscType" type="string" required="No" default="Product" hint="The discount type to get the message string for">
	
	<cfscript>
		var DiscountMess = ''; 
		var qryDiscounts = '';	
		
		switch(arguments.DiscType) {
			case "Store": {
				qryDiscounts=getStoreDiscounts();
				break;
				}
			case "Order": {
				qryDiscounts=getOrderDiscounts();
				break;
				}
			case "Product": {
				qryDiscounts=getProdDiscounts(arguments.DiscList);
				break;
				}		
			}
			
		DiscountMess = ValueList(qryDiscounts.Display);
		DiscountMess = Replace(DiscountMess, ",", ", ", "ALL");
		
	</cfscript>
	
	<cfreturn DiscountMess>

</cffunction>

<cffunction name="dspDiscountMess" displayname="Display Discount Message" hint="Used to create the output string for the discount message." returntype="string" output="No" access="public">

	<cfargument name="DiscList" type="string" required="No" default="" hint="For a product discount, the list of discounts for the product">
	<cfargument name="DiscType" type="string" required="No" default="Product" hint="The discount type to get the message string for">
	<cfargument name="class" type="string" required="No" default="" hint="CSS class to use for the output string.">
	
	<cfscript>
		var strOutput = ''; 
		var DiscountMess = getDiscountMess(argumentcollection: arguments);
		
		if (len(DiscountMess))
			strOutput = '<span class="' & arguments.class & '">' & DiscountMess & '</span><br/>';
	
	</cfscript>
	
	<cfreturn strOutput>

</cffunction>

<cffunction name="getProdDiscounts" displayname="Product Discounts" hint="Gets a list of available discounts for a product, store level discounts optional" output="No" access="public" returntype="query">

	<cfargument name="DiscountList" required="Yes" type="string" hint="List of product discount IDs to include">
	<cfargument name="include_store" required="no" default="no" hint="Set whether to include store discounts or not, default is no">
	
	<cfscript>
		// queries
		var ProdDiscounts = '';
		
		if (NOT isDefined("Request.UserDiscounts"))
			Request.UserDiscounts = getUserDiscounts();
		
		if (len(arguments.DiscountList) IS 0) 
			arguments.DiscountList = '0';
	</cfscript>

	<!--- Find these discounts in the user's list of discounts --->
	<cfquery name="ProdDiscounts" dbtype="query">
		SELECT Discount_ID, Display FROM Request.UserDiscounts
		WHERE Discount_ID IN (#arguments.DiscountList#)
		<cfif arguments.include_store>
			UNION 
			SELECT Discount_ID, Display FROM Request.UserDiscounts
			WHERE Type3 = 3
		</cfif>
	</cfquery>
	
	<cfreturn ProdDiscounts>

</cffunction>


<cffunction name="getStoreDiscounts" displayname="Store Discounts" hint="Gets a list of available discounts for the store" output="No" access="public" returntype="query">
	
	<cfscript>
	var StoreDiscounts = '';
	if (NOT isDefined("Request.UserDiscounts"))
		Request.UserDiscounts = getUserDiscounts();
	</cfscript>
	
	<!--- Get the Discounts for the store --->
	<cfquery name="StoreDiscounts" dbtype="query">
		SELECT Discount_ID, Display FROM Request.UserDiscounts
		WHERE Type3 = 3
	</cfquery>
	
	<cfreturn StoreDiscounts>

</cffunction>


<cffunction name="getOrderDiscounts" displayname="Order Discounts" hint="Gets a list of available order-level discounts" output="No" access="public" returntype="query">

	<cfscript>
	var OrderDiscounts = '';
	if (NOT isDefined("Request.UserDiscounts"))
		Request.UserDiscounts = getUserDiscounts();
	</cfscript>
	
	<!--- Get the Discounts for the store --->
	<cfquery name="OrderDiscounts" dbtype="query">
		SELECT Discount_ID, Display FROM Request.UserDiscounts
		WHERE Type3 = 4
	</cfquery>
	
	<cfreturn OrderDiscounts>

</cffunction>

<cffunction name="calcDiscounts" displayname="Calculate Discounts" hint="Calculate the discounts for the shopping cart, returns a structure with the list of products and the best discount for that product." output="No" access="public" returntype="struct">

	<cfargument name="CartTotals" required="Yes" type="struct" hint="Structure containing a list of Product IDs and the total price and quantity for each">
	
	<cfscript>
		var Cart = arguments.CartTotals;
		var DiscTotals = StructNew();
		var ProdList = StructKeyList(arguments.CartTotals);
		//loop counters		
		var prod = '';
		var i = '';
		// queries
		var itemDiscounts = '';
		// all the other local vars
		var v = structnew();
	</cfscript>
	
	<cfif NOT isDefined("Application.GetDiscounts")>
		<cfset Application.GetDiscounts = getallDiscounts()>
	</cfif>
	
	<!--- Loop through the products in the shopping cart totals --->
	<cfloop index="prod" list="#ProdList#">
	
		<cfscript>
			v.DiscountList = Cart[prod].Discounts;
			v.TopAmount = 0;
			v.BestDiscount = 0;
			v.Coupon = '';
		</cfscript>

		<cfif Len(v.DiscountList)>
		<!--- For each product, retrieve the full discount information --->
		<cfquery dbtype="query" name="itemDiscounts">
			SELECT * FROM Application.GetDiscounts
			WHERE Discount_ID IN (#v.DiscountList#)
		</cfquery>
		
		<!--- Loop through each discount that was returned and determine if the product meets the requirements --->
		<cfloop query="itemDiscounts">
		
			<cfscript>
				v.CheckID = itemDiscounts.Discount_ID;				
				v.PriceTotal = Cart[prod].Price;
				v.QuantTotal = Cart[prod].Quantity;
			
			// Determine the discount amount, by amount or percentage
				if (itemDiscounts.Type2 IS 1) 	
					v.DiscountAmount = itemDiscounts.Amount * v.QuantTotal;
				else
					v.DiscountAmount = itemDiscounts.Amount * v.PriceTotal;
			
			// If Type1 is 2, this is a multi-item discount. 
			// Find any other products with this discount and add them up for the totals
			if (itemDiscounts.Type1 IS 2) {
				for (i=1; i lte ListLen(ProdList); i=i+1) {
					v.checkprod = ListGetAt(ProdList, i);
					if (v.checkprod IS NOT prod AND ListFind(Cart[v.checkprod].Discounts, v.CheckID)) {
						v.PriceTotal = v.PriceTotal + Cart[v.checkprod].Price;
						v.QuantTotal = v.QuantTotal + Cart[v.checkprod].Quantity;
					}
				}
			}
			
			// Check if the product meets the minimum and maximum amounts 
			if (itemDiscounts.Type4 IS 0)
				v.CheckTotal = v.QuantTotal;
			else
				v.CheckTotal = v.PriceTotal;
			
			if (v.CheckTotal GTE itemDiscounts.MinOrder AND v.CheckTotal LTE itemDiscounts.MaxOrder AND v.DiscountAmount GT v.TopAmount) {
				v.TopAmount = v.DiscountAmount;
				v.BestDiscount = v.CheckID;
				v.Coupon = itemDiscounts.Coup_Code;
			}
			
			</cfscript>

		</cfloop>
		
		</cfif>
		
		<cfscript>
			v.strBestDisc = StructNew();
			StructInsert(v.strBestDisc, "DiscountID", v.BestDiscount);
			StructInsert(v.strBestDisc, "Coupon", v.Coupon);
			
			StructInsert(DiscTotals, prod, v.strBestDisc);			
		</cfscript>
		
	</cfloop>
	
	<cfreturn DiscTotals>

</cffunction>

<cffunction name="calcOrderDiscount" displayname="Calculate Order Discount" access="public" returntype="numeric" hint="Calculate the order-level discount for a customer." output="no">

	<cfargument name="TotalCost" type="numeric" required="yes" hint="Total amount spent on the order">
	<cfargument name="TotalQuant" type="numeric" required="yes" hint="Total number of items in the order">
	
	<cfscript>
		var BestDiscount = 0;
		var TopAmount = 0;
		var OrderDiscount = 0;
		var OrderDiscounts = getOrderDiscounts();
		var DiscountList = ValueList(OrderDiscounts.Discount_ID);	
		// queries 
		var theDiscounts = '';	
		// all the other local vars
		var v = structnew();
		
	</cfscript>
	
	<cfif NOT isDefined("Application.GetDiscounts")>
		<cfset Application.GetDiscounts = getallDiscounts()>
	</cfif>
	
	<cfif OrderDiscounts.RecordCount IS NOT 0>
		<!--- Retrieve the full discount information --->
		<cfquery dbtype="query" name="theDiscounts">
			SELECT * FROM Application.GetDiscounts
			WHERE Discount_ID IN (#DiscountList#)
		</cfquery>
		
		<!--- Loop through the available order discounts --->
		<cfloop query="theDiscounts">	
		
			<cfscript>
				// Check if the order meets the minimum and maximum amounts 
				if (theDiscounts.Type4 IS 0)
					v.CheckTotal = arguments.TotalQuant;
				else
					v.CheckTotal = arguments.TotalCost;
				
				// Determine the discount amount, by amount or percentage
				if (theDiscounts.Type2 IS 1) 	
					v.DiscountAmount = theDiscounts.Amount;
				else
					v.DiscountAmount = theDiscounts.Amount * arguments.TotalCost;
						
				if (v.CheckTotal GTE theDiscounts.MinOrder AND v.CheckTotal LTE theDiscounts.MaxOrder 
					AND v.DiscountAmount GT TopAmount) {
					TopAmount = v.DiscountAmount;
					BestDiscount = theDiscounts.Discount_ID;
				}
			</cfscript>
					
		</cfloop>
		
		<cfset OrderDiscount = Round(TopAmount*100)/100>
	
	</cfif>
	
	<cfreturn OrderDiscount>

</cffunction>

<cffunction name="doBasketDiscounts" displayname="Apply the Shopping Basket Discounts" hint="Using the list of discounts for the products in the shopping cart, apply to the shopping cart items." output="No" access="public">

	<cfargument name="CartTotals" required="Yes" type="struct">
	
	<cfscript>
		var prod = '';
		//queries
		var ClearDisc = '';
		var getProducts = '';
		var UpdateBasket = '';
		// all the other local vars
		var v = structnew();
		//Calculate the discounts for the items in the shopping cart
		var DiscTotals = calcDiscounts(arguments.CartTotals);
		var ProdList = StructKeyList(DiscTotals);
	</cfscript>
	
	<cfquery name="ClearDisc" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#TempBasket 
		SET Discount = 0, DiscAmount = 0, Disc_Code = ''
		WHERE BasketNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
	</cfquery>
	
	<!--- Loop through each returned product and update the discounts if any being used --->	
	<cfloop index="prod" list="#ProdList#">

		<cfset v.DiscountID = DiscTotals[prod].DiscountID>
		<cfset v.Coupon = DiscTotals[prod].Coupon>
		
		<cfif v.DiscountID IS NOT 0>
			<!--- Search the shopping cart for these products to discount --->			
			<cfquery name="getProducts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				SELECT Basket_ID, Price, OptPrice, AddonMultP, QuantDisc
				FROM #Request.DB_Prefix#TempBasket 
				WHERE BasketNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
				AND Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#prod#">
			</cfquery>
			
			<cfloop query="getProducts">
				<cfset v.ItemPrice = getProducts.Price + getProducts.OptPrice + getProducts.AddonMultP - getProducts.QuantDisc>
				<cfset v.ItemDiscount = getItemDiscount(v.DiscountID, v.ItemPrice)>
			
			<cfquery name="UpdateBasket" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
				UPDATE #Request.DB_Prefix#TempBasket
				SET Discount = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#v.DiscountID#">,
				DiscAmount = <cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#v.ItemDiscount#">,
				Disc_Code = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#v.Coupon#">
				WHERE BasketNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
				AND Basket_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#getProducts.Basket_ID#">
			</cfquery>
			
			</cfloop>

		</cfif>		
		
		
	</cfloop>

</cffunction>

<cffunction name="getItemDiscount" displayname="Item Discount" hint="Calculates the discount for a given item in the shopping cart" output="No" access="public">

	<cfargument name="DiscountID" required="Yes" type="numeric" hint="The ID for the discount">
	<cfargument name="Price" required="Yes" type="numeric" hint="The price for the product">
	
	<cfscript>
		var DiscountAmount = 0;
		//queries
		var getItemDiscount = '';
		// all local vars
		var v = structnew();
	</cfscript>
	
	<cfif NOT isDefined("Application.GetDiscounts")>
		<cfset Application.GetDiscounts = getallDiscounts()>
	</cfif>

	<cfif arguments.DiscountID IS NOT 0>
		<!--- use query-of-query to get the selected discount --->
		<cfquery dbtype="query" name="getItemDiscount" maxrows="1">
			SELECT * FROM Application.GetDiscounts
			WHERE Discount_ID = #arguments.DiscountID#
		</cfquery>
			
		<cfscript>
			if (getItemDiscount.Recordcount IS NOT 0) {
				v.Amount = getItemDiscount.Amount;
				v.Type = getItemDiscount.Type2;
				if (v.Type IS 1) 
					DiscountAmount = v.Amount;
				else
					DiscountAmount = (v.Amount * arguments.Price);
				// Round the discount amount
				DiscountAmount = Round(DiscountAmount*100)/100;
			}
		
		</cfscript>
		
		
	</cfif>
	
	<cfreturn DiscountAmount>

</cffunction>



<cffunction name="calcProdDiscount" displayname="Calculate Product Discount" hint="This function can be used in the store to determine a discount amount for a product, to display prices after the discount is applied. By default it uses store-level discounts with a minimum quantity purchase set to one." access="public" output="No" returntype="numeric">
	
	<cfargument name="ProdID" required="Yes" type="numeric" hint="The product ID to find discounts for.">
	<cfargument name="ItemPrice" required="Yes" type="numeric" hint="The price for this product.">
	<cfargument name="Type" required="No" default="store" type="string" hint="The type of discount to check for: store, product or category.">
	
	<cfscript>
		var DiscountAmount = 0;
		var DiscTotals = StructNew();
		// loop counter
		var i = 0;
		// queries
		var prodDiscounts = getProdDiscounts(arguments.ProdID, 'yes');
		var itemDiscounts = '';
		// all the other local vars
		var v = structnew();
		
		if (CompareNoCase(arguments.Type, 'product') IS 0)
			v.DiscType = 0;
		else if (CompareNoCase(arguments.Type, 'category') IS 0)
			v.DiscType = 1;
		else 
			v.DiscType = 3;
			
		v.DiscountList = ValueList(prodDiscounts.Discount_ID);
		
	</cfscript>
	
	<cfif NOT isDefined("Application.GetDiscounts")>
		<cfset Application.GetDiscounts = getallDiscounts()>
	</cfif>
	
	<cfif Len(v.DiscountList)>
		<!--- Retrieve the full discount information --->
		<cfquery dbtype="query" name="itemDiscounts">
			SELECT * FROM Application.GetDiscounts
			WHERE Discount_ID IN (#v.DiscountList#)
		</cfquery>
				
		<!--- Run for each product discount --->
		<cfloop query="itemDiscounts">
		
			<cfscript>
				//Check if this is a discount with a minimum amount of 1 item, and the selected type 
				if (itemDiscounts.MinOrder IS 1 AND itemDiscounts.Type4 IS 0 AND Compare(itemDiscounts.Type3, v.DiscType) IS 0)
				{			
				// Calculate the amount for the discount 
					if (itemDiscounts.Type2 IS 1) {
						v.TestAmount = itemDiscounts.Amount;
					}
					else {
						v.TestAmount = arguments.ItemPrice * itemDiscounts.Amount;
					}			
				
				if (DiscountAmount LT v.TestAmount) {
					DiscountAmount = v.TestAmount;
					}
				
				}
			
			</cfscript>
		</cfloop>

	</cfif>
		
	<cfreturn DiscountAmount>		

</cffunction>


<cffunction name="getProdDiscountList" displayname="List of Product Discounts" hint="Gets a list of available discounts for a product in the store, including product and category-level discounts" output="No" access="public" returntype="string">

	<cfargument name="Product_ID" required="Yes" type="numeric" hint="The product ID to find discounts for">
		
	<cfscript>
		// queries
		var ThisProdDiscounts = '';
		var ProdDiscounts = '';
	</cfscript>
	
	<!--- Get the discounts for the product and the categories the product is assigned to --->
	<cfquery name="ThisProdDiscounts" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
		SELECT DISTINCT Discount_ID FROM #Request.DB_Prefix#Discount_Categories
		WHERE Category_ID IN (SELECT Category_ID FROM #Request.DB_Prefix#Product_Category
								WHERE Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Product_ID#">)
		UNION 
		
		SELECT DISTINCT Discount_ID FROM #Request.DB_Prefix#Discount_Products
		WHERE Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Product_ID#">
	</cfquery>

	<cfset ProdDiscounts = ValueList(ThisProdDiscounts.Discount_ID)>
	
	<cfreturn ProdDiscounts>

</cffunction>


<cffunction name="updProdDiscounts" displayname="Update the Product Discount List" hint="Updates the stored discount list for a product in the store." output="No" access="public">

	<cfargument name="Product_ID" required="Yes" type="numeric" hint="The product ID to update">
		
	<cfscript>
		// queries
		var updProduct = '';
		var DiscountList = getProdDiscountList(arguments.Product_ID);
	</cfscript>
	
	<cfquery name="updProduct" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#Products
		SET Discounts = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#DiscountList#">
		WHERE Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Product_ID#">
	</cfquery>		

</cffunction>


<cffunction name="qryGroupDiscounts" displayname="Group Discounts Query" hint="Gets a list of available discounts for the user group, using current database cache setting." output="No" access="public" returntype="query">

	<cfargument name="Group_ID" type="numeric" required="No" default="#Session.Group_ID#" hint="User group to query discounts for.">
	<cfargument name="reset" required="No" default="no" hint="Set whether to refresh the cached group discounts query.">

	<cfscript>
		var GrpDiscounts = '';	
		if (arguments.reset)
			Request.Cache = CreateTimeSpan(0, 0, 0, 0);
	</cfscript>

	<cfquery name="GrpDiscounts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" cachedwithin="#Request.Cache#">
	<!--- Get the list of non-user discounts that are active --->
	SELECT Discount_ID, Display, Type3, Coup_Code, OneTime, AccessKey 
	FROM #Request.DB_Prefix#Discounts
	WHERE Type5 = 0
	AND (StartDate IS NULL OR StartDate <= #createODBCdate(now())#)
	AND (EndDate IS NULL OR EndDate >= #createODBCdate(now())#)
	
	UNION
	
	<!--- Get the list of user discounts for the current users's group 
		and that are currently active --->
	SELECT Discount_ID, Display, Type3, Coup_Code, OneTime, AccessKey 
	FROM #Request.DB_Prefix#Discounts
	WHERE Type5 = 1
	AND (StartDate IS NULL OR StartDate <= #createODBCdate(now())#)
	AND (EndDate IS NULL OR EndDate >= #createODBCdate(now())#)
	AND Discount_ID IN (SELECT Discount_ID FROM #Request.DB_Prefix#Discount_Groups
						WHERE Group_ID = #Val(arguments.Group_ID)#) 
	</cfquery>

	<cfreturn GrpDiscounts>

</cffunction>


<cffunction name="getUserDiscounts" displayname="User Discounts" hint="Retuns the list of available discounts for the user." output="No" access="public" returntype="query">

	<cfscript>
	// set local vars
	var GrpDiscounts = qryGroupDiscounts();
	var UserDiscounts = '';
	var GetCoupons = '';
	var accesskeys = 0;
	var key_loc = '';
	var CoupList = '';
	
	//determine user's current access keys
	if (Session.User_ID) {
		accesskeys = '0,1';
		key_loc = ListContainsNoCase(session.userPermissions,'contentkey_list',';');
		if (key_loc)
			accesskeys = ListAppend(accesskeys,ListLast(ListGetAt(session.userPermissions,key_loc,';'),'^'));
		}
	</cfscript>
	
	<!--- Get any previously used coupons --->
	<cfquery name="GetCoupons" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT DISTINCT I.Disc_Code FROM #Request.DB_Prefix#Order_Items I
		INNER JOIN #Request.DB_Prefix#Order_No N ON I.Order_No = N.Order_No
		WHERE I.Disc_Code IS NOT NULL
		AND I.Disc_Code <> ''
		AND N.User_ID <> 0 
		AND N.User_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#Session.User_ID#">
	</cfquery>
	
	<cfset CoupList = ValueList(GetCoupons.Disc_Code)>

	<!--- Get list of discounts for the user, filtered with coupon --->
	<cfquery name="UserDiscounts" dbtype="query">
	SELECT * FROM GrpDiscounts
	WHERE (Coup_Code IS NULL OR Coup_Code = '#Session.Coup_Code#')
	<cfif len(CoupList)>
	AND (Coup_Code IS NULL OR OneTime = 0 OR 
		Coup_Code NOT IN (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#CoupList#" list="Yes">) )
	</cfif>
	AND AccessKey IN (#accesskeys#)
	</cfquery>
	
	<cfreturn UserDiscounts>

</cffunction>


<cffunction name="getallDiscounts" displayname="Get All Discounts" hint="Gets the full list of discounts used for the store" output="No" access="public" returntype="query">

	<cfset var qryDiscounts = ''>

	<cfquery name="qryDiscounts" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT * FROM #Request.DB_Prefix#Discounts
		ORDER BY MaxOrder DESC, Type3 DESC
	</cfquery>
	
	<cfreturn qryDiscounts>

</cffunction>


</cfcomponent>


