<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<cfcomponent displayname="Promotion Functions" hint="This component is used for handling various promotion calculations for the store.">
<!--- This component developed by Mary Jo Sminkey maryjo@cfwebstore.com --->
<!--- Developed for use with CFWebstore e-commerce (www.cfwebstore.com) --->

<!--- Requires CFMX 6 or higher --->

<!--- This code is owned by Dogpatch Software and may not be distributes or reused without permission --->
	
<!--- Inlcude cftag functions --->
<cfinclude template="../tags/cftags.cfm">

<!------------------------- COMPONENT INITIALIZATION ----------------------------------->
<cffunction name="init" access="public" output="no" returntype="promotions">
    <cfreturn this>
  </cffunction>

<cffunction name="getPromotionMess" displayname="Promotion Message" hint="Used to get the promotion message for a selected store product." returntype="string" output="No" access="public">

	<cfargument name="PromoList" type="string" required="No" default="" hint="List of promotions for the product.">
	
	<cfscript>
		var PromotionMess = '';
		var qryPromotions = '';
		
		qryPromotions=getProdPromotions(arguments.PromoList);
	
		PromotionMess = ValueList(qryPromotions.Display);
		PromotionMess = Replace(PromotionMess, ",", ", ", "ALL");
	</cfscript>
	
	<cfreturn PromotionMess>

</cffunction>

<cffunction name="getProdPromoList" displayname="List of Product Promotions" hint="Gets a list of available promotions for a product in the store" output="No" access="public" returntype="string">

	<cfargument name="Product_ID" required="Yes" type="numeric" hint="The product ID to find promotions for">
		
	<cfscript>
		// queries
		var ThisProdPromos = '';
		var ProdPromos = '';
	</cfscript>
	
	<!--- Get the promotions for the product --->
	<cfquery name="ThisProdPromos" datasource="#Request.ds#" username="#Request.user#"  password="#Request.pass#">
		SELECT Promotion_ID FROM #Request.DB_Prefix#Promotion_Qual_Products
		WHERE Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Product_ID#">
	</cfquery>

	<cfset ProdPromos = ValueList(ThisProdPromos.Promotion_ID)>
	
	<cfreturn ProdPromos>

</cffunction>

<cffunction name="updProdPromotions" displayname="Update the Product Promotion List" hint="Updates the stored promotion list for a product in the store." output="No" access="public">

	<cfargument name="Product_ID" required="Yes" type="numeric" hint="The product ID to update">
		
	<cfscript>
		// queries
		var updProduct = '';
		var PromotionList = getProdPromoList(arguments.Product_ID);
	</cfscript>
	
	<cfquery name="updProduct" datasource="#Request.ds#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#Products
		SET Promotions = <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#PromotionList#">
		WHERE Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.Product_ID#">
	</cfquery>		

</cffunction>

<cffunction name="getProdPromotions" displayname="Product Promotions" hint="Gets a list of qualified promotions for a product in the store" output="No" access="public" returntype="query">

	<cfargument name="PromoList" required="Yes" type="string" hint="List of product promotion IDs to include">
	
	<cfscript>
		var UserPromotions = '';
		var ProdPromotions = '';
		
		if (NOT isDefined("Request.UserPromotions"))
			Request.UserPromotions = getUserPromotions();
		
		if (len(arguments.PromoList) IS 0) 
			arguments.PromoList = '0';
	</cfscript>
	
	<!--- Get the promotions for the product, check if available to user --->
	<cfquery name="ProdPromotions" dbtype="query">
		SELECT Promotion_ID, Display FROM Request.UserPromotions
		WHERE Promotion_ID IN (#arguments.PromoList#)
	</cfquery>
	
	<cfreturn ProdPromotions>

</cffunction>

<cffunction name="getOrderPromotions" displayname="Order Promotions" hint="Gets a list of available order-level promotions" output="No" access="public" returntype="query">

	<cfscript>
	var OrderPromotions = '';
	if (NOT isDefined("Request.UserPromotions"))
		Request.UserPromotions = getUserPromotions();
	</cfscript>
	
	<!--- Get the Promotion for the store --->
	<cfquery name="OrderPromotions" dbtype="query">
		SELECT Promotion_ID, Display FROM Request.UserPromotions
		WHERE Type1 = 4
	</cfquery>
	
	<cfreturn OrderPromotions>

</cffunction>

<cffunction name="calcPromotions" displayname="Calculate Promotions" hint="Calculate the promotions for the shopping cart, returns a structure with the list of products and the best promotion for that product." output="No" access="public" returntype="struct">

	<cfargument name="CartTotals" required="Yes" type="struct" hint="Structure containing a list of Product IDs and the total price and quantity for each">
	
	<cfscript>
		var Cart = arguments.CartTotals;
		var PromotionTotals = StructNew();
		var ProdList = StructKeyList(arguments.CartTotals);
		// loop counters
		var prod = '';
		var i =0;
		// queries
		var itemPromotions = '';
		// all other local vars
		var v = StructNew();
				
		//Check for multiple-product promotions to only run once			
		v.MultiDone = '';
	</cfscript>
	
	<cfif NOT isDefined("Application.GetPromotions")>
		<cfset Application.GetPromotions = getallPromotions()>
	</cfif>
	
	<!--- Loop through the products in the shopping cart totals --->
	<cfloop index="prod" list="#ProdList#">
	
		<cfscript>
			v.PromotionList = Cart[prod].Promotions;
			v.PriceTotal = Cart[prod].Price;
			v.QuantTotal = Cart[prod].Quantity;
			//default values if no promotion found
			v.TopAmount = 0;
			v.BestPromotion = 0;
			v.DiscProd = 0;
			v.DiscQuant = 0;
			v.Coupon = '';
		</cfscript>

		<cfif Len(v.PromotionList)>
		<!--- For each product, retrieve the full promotion information --->
		<cfquery dbtype="query" name="itemPromotions">
			SELECT * FROM Application.GetPromotions
			WHERE Promotion_ID IN (#v.PromotionList#)
		</cfquery>
				
		<!--- Loop through each promotion that was returned and determine if the product meets the requirements --->
		<cfloop query="itemPromotions">
		
			<cfscript>
				v.CheckID = itemPromotions.Promotion_ID;
				
				//check if the amount to compare will be on this product, or a different one
				if (itemPromotions.Type1 IS 1) {
					v.CheckPrice = v.PriceTotal;
					v.CheckQuant = v.QuantTotal;
				}
				
				//if the discounted item is not added automatically, make sure it's in the cart
				else if (NOT itemPromotions.Add_DiscProd AND NOT ListFind(ProdList, itemPromotions.Disc_Product)) {
					v.CheckPrice = 0;
					v.CheckQuant = 0;
				}		
				
				// make sure a product price was returned for the discounted product
				// this will be blank if the merchant didn't properly set it up
				else if (Not isNumeric(itemPromotions.ProdPrice) OR NOT isNumeric(itemPromotions.DiscountNum)) {
					v.CheckPrice = 0;
					v.CheckQuant = 0;
				}				
				
				// Valid cross-promotion, continue
				else {
					v.CheckPrice = itemPromotions.ProdPrice * itemPromotions.DiscountNum;
					v.CheckQuant = itemPromotions.DiscountNum;
				}				
				
				// Determine the promotion amount, by amount or percentage
				if (itemPromotions.Type2 IS 1) 	
					v.PromotionAmount = itemPromotions.Amount * v.CheckQuant;
				else
					v.PromotionAmount = itemPromotions.Amount * v.CheckPrice;
			
			// If Type1 is 3, this is a multi-item promotion. 
			
			// Make sure this is not a multi-item promotion that was already checked
			if (ListFind(v.MultiDone, v.CheckID)) {
				v.PriceTotal = 0;
				v.QuantTotal = 0;
			}
			// Find any other products with this promotion and add them up for the totals
			else if (itemPromotions.Type1 IS 3) {
				for (i=1; i lte ListLen(ProdList); i=i+1) {
					v.checkprod = ListGetAt(ProdList, i);
					if (v.checkprod IS NOT prod AND ListFind(Cart[v.checkprod].Promotions, v.CheckID)) {
						v.PriceTotal = v.PriceTotal + Cart[v.checkprod].Price;
						v.QuantTotal = v.QuantTotal + Cart[v.checkprod].Quantity;
					}
				}
				//Add to the list of completed multi-item promotions
				v.MultiDone = ListAppend(v.MultiDone, v.CheckID);
			}
			
			// Check if the product meets the qualifying amount 
			if (itemPromotions.Type3 IS 0)
				v.CheckTotal = v.QuantTotal;
			else
				v.CheckTotal = v.PriceTotal;
			
			if (v.CheckTotal GTE itemPromotions.QualifyNum AND v.PromotionAmount GT v.TopAmount) {
				v.TopAmount = v.PromotionAmount;
				v.BestPromotion = v.CheckID;
				//determine the number of items that will be discounted
				if (itemPromotions.Multiply IS NOT 0)
					v.DiscQuant = Int(v.CheckTotal/itemPromotions.QualifyNum) * itemPromotions.DiscountNum;
				else
					v.DiscQuant = itemPromotions.DiscountNum;
				//set the discounted product for the promotion
				if (itemPromotions.Type1 IS 1) 
					v.DiscProd = prod;
				else
					v.DiscProd = itemPromotions.Disc_Product;
				
			}
			
			</cfscript>

		</cfloop>
		
		</cfif>
		
		<cfscript>
			v.PromotionInfo = StructNew();
			v.PromotionInfo.PromotionID = v.BestPromotion;
			v.PromotionInfo.DiscProd = v.DiscProd;
			v.PromotionInfo.DiscQuant = v.DiscQuant;
			StructInsert(PromotionTotals, prod, v.PromotionInfo);
		</cfscript>
		
	</cfloop>
	
	<cfreturn PromotionTotals>

</cffunction>

<cffunction name="calcOrderPromotion" displayname="Calculate Order Promotion" access="public" returntype="numeric" hint="Calculate the order-level promotion for a customer." output="no">

	<cfargument name="TotalCost" type="numeric" required="yes" hint="Total amount spent on the order">
	<cfargument name="TotalQuant" type="numeric" required="yes" hint="Total number of items in the order">
	<cfargument name="qryBasket" required="Yes" type="query" hint="The customer's current shopping cart">
	
	<cfscript>
		var BestPromotion = 0;
		var TopAmount = 0;
		var OrderPromotion = 0;
		var OrderPromotions = getOrderPromotions();
		var PromotionList = ValueList(OrderPromotions.Promotion_ID);	
		// queries 
		var thePromotions = '';	
		var checkCurrPromoID = '';
		// all the other local vars
		var v = structnew();
		
	</cfscript>
	
	<cfif NOT isDefined("Application.GetPromotions")>
		<cfset Application.GetPromotions = getallPromotions()>
	</cfif>
	
	<cfif OrderPromotions.RecordCount IS NOT 0>
		<!--- Retrieve the full promotion information --->
		<cfquery dbtype="query" name="thePromotions">
			SELECT * FROM Application.GetPromotions
			WHERE Promotion_ID IN (#PromotionList#)
		</cfquery>
		
		<!--- Loop through the available order promotions --->
		<cfloop query="thePromotions">	
			
			<!--- Check the shopping cart for the discounted item on this promotion --->
			<cfquery name="checkCurrPromoID" dbtype="query">
				SELECT Product_ID, Quantity, Price, OptPrice, QuantDisc, DiscAmount, AddonMultP, AddonNonMultP FROM arguments.qryBasket
				WHERE Product_ID = #thePromotions.Disc_Product#
			</cfquery>
		
			<cfscript>
				//Get the amounts to compare from the promotion information
				v.CheckPrice = thePromotions.ProdPrice * thePromotions.DiscountNum;
				v.CheckQuant = thePromotions.DiscountNum;					
				
				//Check to see if the discounted product is already in the shopping cart, if so remove it from totals
				if (checkCurrPromoID.RecordCount) {
					v.RemoveQuant = checkCurrPromoID.Quantity;
					v.ExtDiscProd = (checkCurrPromoID.Price + checkCurrPromoID.OptPrice - checkCurrPromoID.QuantDisc + checkCurrPromoID.AddonMultP) * checkCurrPromoID.Quantity;
					v.RemoveTotal = v.ExtDiscProd + checkCurrPromoID.AddonNonMultP - (checkCurrPromoID.DiscAmount * checkCurrPromoID.Quantity);
					}
				else {
					v.RemoveQuant = 0;
					v.RemoveTotal = 0;
					}		
		
				// promotion based on amount spent, or number of items
				if (thePromotions.Type3 IS 0)
					v.CheckTotal = arguments.TotalQuant - v.RemoveQuant;
				else
					v.CheckTotal = arguments.TotalCost - v.RemoveTotal;		
				
				// Determine the promotion amount, by amount or percentage
				if (thePromotions.Type2 IS 1) 	
					v.PromotionAmount = thePromotions.Amount * v.CheckQuant;
				else
					v.PromotionAmount = thePromotions.Amount * v.CheckPrice;
					
				// Check if the order meets the qualifying amount
				if (v.CheckTotal GTE thePromotions.QualifyNum AND v.PromotionAmount GT TopAmount) {
					TopAmount = v.PromotionAmount;
					BestPromotion = thePromotions.Promotion_ID;
					//determine the number of items that will be discounted
					if (thePromotions.Multiply IS NOT 0)
						v.DiscQuant = Int(v.CheckTotal/thePromotions.QualifyNum) * thePromotions.DiscountNum;
					else
						v.DiscQuant = thePromotions.DiscountNum;	
					//set the discounted product for the promotion
					v.DiscProd = thePromotions.Disc_Product;			
				}
			</cfscript>
					
		</cfloop>
		
		<cfscript>
			//if order promotion found, apply the promotion to the shopping cart
			if (BestPromotion IS NOT 0) {
				doApplyPromotion(BestPromotion, v.DiscProd, v.DiscQuant);
			}		
		</cfscript>
	
	</cfif>
	
	<cfreturn BestPromotion>
	

</cffunction>

<cffunction name="doBasketPromotions" displayname="Calculate the Shopping Basket Promotions" hint="Using the list of promotions for the items in the shopping cart, determines the promotional amounts to apply to the shopping cart items." output="No" access="public">

	<cfargument name="CartTotals" required="Yes" type="struct">

	<cfscript>
		// loop counters
		var prod = '';
		// queries
		var ClearPromos = '';
		var UpdateBasket = '';
		// all other local vars
		var DiscQuant = 0;
		var DiscProd = 0;
		var PromoID = 0;
		
		//Calculate the promotions for the items in the shopping cart
		var PromoTotals = calcPromotions(arguments.CartTotals);
		var ProdList = StructKeyList(PromoTotals);
	</cfscript>
	
	<cfquery name="ClearPromos" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#TempBasket 
		SET Promotion = 0, PromoAmount = 0, PromoQuant = 0, Promo_Code = ''
		WHERE BasketNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
	</cfquery>

	<cfloop index="prod" list="#ProdList#">

		<cfset PromoID = PromoTotals[prod].PromotionID>
	
		<cfquery name="UpdateBasket" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#TempBasket
		SET Promotion = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#PromoID#">
		WHERE BasketNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
		AND Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#prod#">
		</cfquery>
		
		<cfscript>
			//If setting a promotion, run the promotion calculations to set the promotion discount amounts
			if (PromoID IS NOT 0) {
			
				DiscProd = PromoTotals[prod].DiscProd;
				DiscQuant = PromoTotals[prod].DiscQuant;
				
				//apply the promotion to the shopping carts items that qualify
				doApplyPromotion(PromoID, DiscProd, DiscQuant);
			
			}
		</cfscript>	
		
	</cfloop>

</cffunction>

<cffunction name="doApplyPromotion" description="Apply Promotion" hint="This function takes a product ID, number of items, and promotion ID and searches the shopping cart for the product to apply it to. Returns the final discounted amount" output="No" access="public" returntype="void">

	<cfargument name="PromoID" type="numeric" required="Yes">
	<cfargument name="Product_ID" type="numeric" required="Yes" hint="The product to apply the promotion on">
	<cfargument name="DiscQuant" type="numeric" required="Yes" hint="The number of items to apply the promotion to">
	
	<cfscript>
		var DiscProd = arguments.Product_ID;
		// queries
		var getPromoInfo = '';
		var getPromoItems = '';
		var getTotalQuant = '';
		// all other local vars
		var v = StructNew();
	</cfscript>
	
		
	<cfif NOT isDefined("Application.GetPromotions")>
		<cfset Application.GetPromotions = getallPromotions()>
	</cfif>

	<!--- Get info on this promotion ---> 
	<cfquery name="getPromoInfo" dbtype="query">
		SELECT * FROM Application.GetPromotions
		WHERE Promotion_ID = #arguments.PromoID#
	</cfquery>
	
	<!--- Search the shopping cart for available products to discount, product cannot already be used for promo --->
	<cfquery name="getPromoItems" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT * FROM #Request.DB_Prefix#TempBasket 
		WHERE BasketNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
		AND Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#DiscProd#">
		AND PromoQuant < Quantity
	</cfquery>

	<cfif getPromoItems.Recordcount>
		<!--- Count the number of items available for promotions --->
		<cfquery name="getTotalQuant" dbtype="query">
			SELECT SUM(Quantity) AS TotalItems, SUM(PromoQuant) AS TotalUsed 
			FROM getPromoItems
		</cfquery>
			
		<cfset v.TotalLeft = getTotalQuant.TotalItems - getTotalQuant.TotalUsed>
		
	<cfelse>
		
		<cfset v.TotalLeft = 0>
			
	</cfif>
			
	<cfset v.TotalNeeded = arguments.DiscQuant - v.TotalLeft>
	
	<!--- if the item is not found or not enough quantity in the cart, and set to be added automatically, 
		add it to the shopping cart --->
		<cfif v.TotalNeeded GT 0 AND getPromoInfo.Add_DiscProd>
		<cfinvoke component="#Request.CFCMapping#.shopping.cart" 
			returnvariable="v.Result" method="doAddCartItem" Product_ID="#DiscProd#" Quantity="#v.TotalNeeded#">
		<!--- Retrieve the newly added item --->
		<cfquery name="getPromoItems" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
			SELECT * FROM #Request.DB_Prefix#TempBasket
			WHERE BasketNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
			AND Product_ID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#DiscProd#">
			AND PromoQuant < Quantity
		</cfquery>
	</cfif>
	
	<!--- For each item found, determine the promotion amount to apply --->
	<cfloop query="getPromoItems">
		<cfscript>
			//Check number of items available for promotion
			v.QuantLeft = getPromoItems.Quantity - getPromoItems.PromoQuant;
			if (v.QuantLeft LT arguments.DiscQuant) 
				v.QuantUsed = v.QuantLeft;
			else
				v.QuantUsed = arguments.DiscQuant;		
				
			//discount a specific amount
			if (getPromoInfo.Type2 IS 1)
				v.PromoTotal = v.QuantUsed * getPromoInfo.Amount;
			// discount by percentage, so determine the item price
			else {
				v.ItemPrice = getPromoItems.Price + getPromoItems.OptPrice + getPromoItems.AddonMultP;
				v.ItemPrice = v.ItemPrice - getPromoItems.QuantDisc - getPromoItems.DiscAmount;
				v.PromoTotal = v.QuantUsed * (v.ItemPrice * getPromoInfo.Amount);
				}		
		</cfscript>
		
		<cfquery name="UpdateBasket" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		UPDATE #Request.DB_Prefix#TempBasket
		SET PromoAmount = PromoAmount + <cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#v.PromoTotal#">,
		PromoQuant = PromoQuant + <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#v.QuantUsed#">,
		Promo_Code = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#getPromoInfo.Coup_Code#">
		WHERE Basket_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#getPromoItems.Basket_ID#">
		</cfquery>
		
		<!--- Subtract this quantity from the total discounted quantity --->
		<cfset arguments.DiscQuant = arguments.DiscQuant - v.QuantUsed>
		
	</cfloop>


</cffunction>



<cffunction name="qryGroupPromotions" displayname="Group Promotions Query" hint="Gets a list of available promotions for the user group, using current database cache setting." output="No" access="public" returntype="query">

	<cfargument name="Group_ID" type="numeric" required="No" default="#Session.Group_ID#" hint="User group to query promotions for.">
	<cfargument name="reset" required="No" default="no" hint="Set whether to refresh the cached group promotions query.">

	<cfscript>
		var GrpPromotions = '';	
		if (arguments.reset)
			Request.Cache = CreateTimeSpan(0, 0, 0, 0);
	</cfscript>

	<cfquery name="GrpPromotions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" cachedwithin="#Request.Cache#">
	<!--- Get the list of non-user discounts that are active --->
	SELECT Promotion_ID, Display, Type1, Coup_Code, AccessKey 
	FROM #Request.DB_Prefix#Promotions
	WHERE Type4 = 0
	AND (StartDate IS NULL OR StartDate <= #createODBCdate(now())#)
	AND (EndDate IS NULL OR EndDate >= #createODBCdate(now())#)
	
	UNION
	
	<!--- Get the list of user discounts for the current users's group 
		and that are currently active --->
	SELECT Promotion_ID, Display, Type1, Coup_Code, AccessKey 
	FROM #Request.DB_Prefix#Promotions
	WHERE Type4 = 1
	AND (StartDate IS NULL OR StartDate <= #createODBCdate(now())#)
	AND (EndDate IS NULL OR EndDate >= #createODBCdate(now())#)
	AND Promotion_ID IN (SELECT Promotion_ID FROM #Request.DB_Prefix#Promotion_Groups
						WHERE Group_ID = #Val(arguments.Group_ID)#) 
	</cfquery>

	<cfreturn GrpPromotions>

</cffunction>


<cffunction name="getUserPromotions" displayname="User Promotions" hint="Retuns the list of available promotions for the user." output="No" access="public" returntype="query">

	<cfscript>
	// set local vars
	var GrpPromotions = qryGroupPromotions();
	var UserPromotions = "";
	var accesskeys = 0;
	var key_loc = '';
	
	//determine user's current access keys
	if (Session.User_ID) {
		accesskeys = '0,1';
		key_loc = ListContainsNoCase(session.userPermissions,'contentkey_list',';');
		if (key_loc)
			accesskeys = ListAppend(accesskeys,ListLast(ListGetAt(session.userPermissions,key_loc,';'),'^'));
		}
	</cfscript>

	<!--- Get list of promotions for the user, filtered with coupon --->
	<cfquery name="UserPromotions" dbtype="query">
	SELECT * FROM GrpPromotions
	WHERE (Coup_Code IS NULL OR Coup_Code = '#Session.Coup_Code#')	
	AND AccessKey IN (#accesskeys#)
	</cfquery>
	
	<cfreturn UserPromotions>

</cffunction>



<cffunction name="getallPromotions" displayname="Get All Promotions" hint="Gets the full list of promotions used for the store" output="No" access="public" returntype="query">

	<cfscript>
		var qryPromotions = '';
	</cfscript>

	<cfquery name="qryPromotions" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT P.*, Pt.Base_Price AS ProdPrice 
		FROM #Request.DB_Prefix#Promotions P
		LEFT OUTER JOIN #Request.DB_Prefix#Products Pt ON P.Disc_Product = Pt.Product_ID
		ORDER BY QualifyNum, Amount 
	</cfquery>
	
	<cfreturn qryPromotions>

</cffunction>



</cfcomponent>


