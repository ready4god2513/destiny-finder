<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<cfcomponent displayname="Checkout Functions" hint="This component is used for handling various checkout functions for the store.">

<!--- Include cftag functions --->
<cfinclude template="../tags/cftags.cfm">

<!------------------------- COMPONENT INITIALIZATION ----------------------------------->
<cffunction name="init" access="public" output="no" returntype="checkout">
    <cfreturn this>
  </cffunction>
  
<!------------------------- BEGIN SHIPPING INITIALIZE FUNCTION ----------------------------------->
<cffunction name="getCheckoutVars" returntype="struct" displayname="Get Checkout Variables" hint="This function retrieves the variables used during checkout by calculating the totals from the shopping cart and creating the shipping array." output="No">

<!--- Sets all the shipping variables used during checkout --->
<!--- 
ShipArray - 	This array contains the separate packages being shipped. Used for calculating the shipping rates
TotalCost - 	This is the total amount of the shippable items in the shopping cart, not including freight
TaxTotals - 	This contains the tax codes and total amount of items in the basket for that code
TotalWeight - 	This is the total weight of the shippable items in the shopping cart, not including freight
DropShipWeight - Total amount of weight that will be drop-shipped, to be subtracted from the total weight
TotalBasket - 	This is the subtotal of the basket items. Used if there is a minimum basket amount set
TotalShip - 	This is the total used to calculate shipping. 
				Is set to the total cost, weight or quantity according to the shipping type used
DropShippers -  Structure that holds all the packages that will be drop-shipped, and associated information
FreightCost - 	Total amount to charge for freight, holds both domestic and international totals
Download - 		Sets whether the order includes any downloadable items
Membership - 	Sets whether the order includes any membership items
NoShipInfo - 	This is turned on if shipping was not able to be calculated. Initialize it here

 --->

	<cfargument name="qry_Basket" required="Yes" type="query" hint="Query containing the shopping cart">
	<cfargument name="ShipType" required="Yes" type="string" hint="The shipping type being used, used for the Total Ship setting">
	<cfargument name="UseDropShippers" required="No" type="boolean" hint="Sets whether to use drop-shipper addresses">
	
	<!--- Initialize the variables to be used --->
	<cfscript>
		var CheckoutVars = StructNew();
		var ShipArray = ArrayNew(1);
		var TaxTotals = getTaxCodes();
		var Basket = arguments.qry_Basket;
		
		var TotalCost = 0;
		var TotalWeight = 0;
		var DropShipWeight = 0;
		var TotalAddOnWeight = 0;
		var TotalQuant = 0;
		var Download = 0;
		var Membership = 0;
		var TotalBasket = 0;
		
		//structure to hold drop-shipper packages
		var DropShippers = StructNew();
		
		// loop counters
		var i = 0;
		
		// other local vars
		var v = StructNew();
		
		var FreightCost = StructNew();
		FreightCost.Domestic = 0;
		FreightCost.Intl = 0;	
	</cfscript>	
		
	<cfloop query="Basket">
	
		<cfscript>
			v.ProdPrice = Basket.Price + Basket.OptPrice - Basket.QuantDisc + Basket.AddonMultP;
			v.DiscountAmount = Application.objDiscounts.getItemDiscount(Basket.Discount,v.ProdPrice);
			
			v.ExtPrice = ((v.ProdPrice - v.DiscountAmount) * Basket.Quantity) - Basket.PromoAmount;
			v.ExtWeight = (Basket.Weight + Basket.OptWeight + Basket.AddonMultW) * Basket.Quantity;
			v.ExtFreight_D = Basket.Freight_Dom * Basket.Quantity;
			v.ExtFreight_I = Basket.Freight_Intl * Basket.Quantity;
			
			// Round total to two decimal places 
			v.ExtPrice = Round(v.ExtPrice * 100) / 100;
			
			TotalBasket = TotalBasket + v.ExtPrice;
	
			TotalBasket = Round(TotalBasket * 100) / 100;
		// If item requires shipping charges, add amount to running total for shipping 
		
		if (Basket.Shipping IS 1) {
			if (v.ExtFreight_D IS NOT 0) {
				FreightCost.Domestic = FreightCost.Domestic + v.ExtFreight_D;
				FreightCost.Intl = FreightCost.Intl + v.ExtFreight_I;
				}
			
		
			else {
				v.ItemWeight = v.ExtWeight + Basket.AddonNonMultW;
				
				TotalCost = TotalCost + v.ExtPrice + Basket.AddonNonMultP;
				TotalQuant = TotalQuant + Basket.Quantity;
				TotalWeight = TotalWeight + v.ItemWeight;
				
				// Check if product is oversized. If so, add to Shipping Array 
				if (Basket.Pack_Height IS NOT 0) {
					// If oversized, create structure to hold the item information 
					v.ItemShip = StructNew();
					v.ItemShip.Pack_Length = Basket.Pack_Length;
					v.ItemShip.Pack_Width = Basket.Pack_Width;
					v.ItemShip.Pack_Height = Basket.Pack_Height;
					v.ItemShip.Quantity = Basket.Quantity;
					v.ItemShip.Weight = Basket.Weight + Basket.OptWeight + Basket.AddonMultW;
				}
				
				//check if using drop-shipper rates and this product is shipped from drop-shipper
				if (arguments.UseDropShippers AND Basket.DropShipper IS NOT 0) {
					//check if there is already a structure for this drop-shipper
					v.StructName = 'Vendor_' & Basket.DropShipper;
					if (NOT isDefined("DropShippers.#v.StructName#")) {
						DropShippers[v.StructName] = StructNew();
						DropShippers[v.StructName].ShipArray = ArrayNew(1);
						DropShippers[v.StructName].TotalWeight = 0;
					}
					
					DropShipWeight = DropShipWeight + v.ItemWeight;					
					DropShippers[v.StructName].TotalWeight = DropShippers[v.StructName].TotalWeight + v.ItemWeight;
					
					//if oversized package, add to the structure. 
					if (Basket.Pack_Height IS NOT 0) {
						ArrayAppend(DropShippers[v.StructName].ShipArray, v.ItemShip);
					}
					
				}
				//end drop-shippers code
				
				//if oversized package, add to the shipping array. 
				else if (Basket.Pack_Height IS NOT 0) {
						ArrayAppend(ShipArray, v.ItemShip);
				}
										
			}
			//end freight or not freight check
		}
		//end check for shipping charge on item
	
		// loop through the tax codes and add the product amount to the totals if found in the list
		if (len(Basket.TaxCodes)) {
			for(i=1; i lte ArrayLen(TaxTotals); i=i+1) {
				if (ListFind(Basket.TaxCodes, TaxTotals[i].Code_ID)) 
					TaxTotals[i].ProdTotal = TaxTotals[i].ProdTotal + v.ExtPrice;
			}
		}
		
		// Note any downloadable items 
		if (CompareNoCase(Basket.prod_type,"download") eq 0)
			Download = 1; 
	
		// Note any membership items 
		if (CompareNoCase(Basket.prod_type,"membership") eq 0) 
			Membership = 1;
		
		</cfscript>
			
	</cfloop>
	
	<cfscript>
	//Calculate shipping by total price 
		if (ListFind('Price,Price2',arguments.ShipType))
			v.TotalShip = TotalCost;
	
	// Calculate shipping by number of items
		else if (CompareNoCase(arguments.ShipType,'Items') eq 0) 
			v.TotalShip = TotalQuant;
	
	// Calculate shipping by weight or UPS 
		else
			v.TotalShip = TotalWeight;
			
	// drop information into the return structure
	CheckoutVars.ShipArray = ShipArray;
	CheckoutVars.TotalCost = TotalCost;
	CheckoutVars.TaxTotals = TaxTotals;
	CheckoutVars.TotalWeight = TotalWeight;
	CheckoutVars.DropShipWeight = DropShipWeight;
	CheckoutVars.TotalBasket = TotalBasket;
	CheckoutVars.TotalShip = v.TotalShip;
	CheckoutVars.DropShippers = DropShippers;
	CheckoutVars.FreightCost = FreightCost;
	CheckoutVars.Download = Download;
	CheckoutVars.Membership = Membership;
	CheckoutVars.NoShipInfo = 0;
	
	</cfscript>
	
	<cfreturn CheckoutVars>

</cffunction>


<!--------------- INITIALIZE TAX CODES ARRAY -------------------->
<cffunction name="getTaxCodes" displayname="Get Tax Codes" hint="Creates a structure with the list of tax codes and default product amounts for each." output="No" returntype="array" access="public">

	<cfscript>
		var arrTaxCodes = ArrayNew(1);
		var strTaxCode = '';
		var qryTaxCodes = '';
		var SQLString = '';
				
		//counter
		var i = 0;
	</cfscript>
		
	<cfquery name="qryTaxCodes" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
		SELECT Code_ID, CodeName, DisplayName, TaxRate FROM #Request.DB_Prefix#TaxCodes 
		ORDER BY CalcOrder
	</cfquery>
		
	<cfscript>
		//Loop through the tax codes and add to the array
		for (i=1; i lte qryTaxCodes.recordcount; i = i + 1) {
			strTaxCode = StructNew();
			strTaxCode.Code_ID = qryTaxCodes.Code_ID[i];
			strTaxCode.CodeName = qryTaxCodes.CodeName[i];
			strTaxCode.Display = qryTaxCodes.DisplayName[i];
			strTaxCode.TaxRate = qryTaxCodes.TaxRate[i];
			strTaxCode.ProdTotal = 0;
			arrTaxCodes[i] = strTaxCode;
		}		
	</cfscript>
	
	<cfreturn arrTaxCodes>

</cffunction> 


<!--------------- CALCULATE ORDER TAX -------------------->
<cffunction name="calcOrderTax" displayname="Calculate Order Tax" hint="Uses the list of tax codes and product totals to calculate the tax for the order." output="Yes" returntype="array" access="public">

	<cfargument name="arrTaxCodes" required="Yes" type="array" hint="Array containing the list of store tax codes and product totals for each.">
	<cfargument name="strCustAddress" required="Yes" type="struct" hint="Structure containing the customer's billing and shipping addresses.">
	<cfargument name="ShipAmount" required="Yes" type="numeric" hint="Cost of shipping for the order.">
	<cfargument name="TaxExempt" required="Yes" type="numeric" hint="Sets if the user is tax exempt or not.">
	
	<cfscript>
		//counter
		var i = 0;
		//queries
		var qryTaxCode = '';
		//structure to hold tax totals
		var strTaxTotals = StructNew();	
		//duplicate the tax code array to use for results
		var arrTaxAmounts = Duplicate(arguments.arrTaxCodes);
		
		// other local vars
		var v = StructNew();
		
		//initialize Running Totals
		strTaxTotals.AllTax = 0;
		strTaxTotals.StateTax = 0;
		strTaxTotals.LocalTax = 0;
		strTaxTotals.CountyTax = 0;
		strTaxTotals.CountryTax = 0;
		
		//loop through the list of tax codes
		for (i=1; i lte ArrayLen(arguments.arrTaxCodes); i=i+1) {
			//check if there are any items for this taxcodes and user is not tax exempt
			v.Amounttotax = arguments.arrTaxCodes[i].ProdTotal;
			
			if (v.Amounttotax IS NOT 0 AND arguments.TaxExempt IS 0) {						
				//get the tax code information
				v.SQLString = "SELECT * FROM #Request.DB_Prefix#TaxCodes ";
				v.SQLString = v.SQLString & "WHERE Code_ID = #arguments.arrTaxCodes[i].Code_ID#";
				qryTaxCode = CF_QUERY(v.SQLString);
				
				v.Amounttotax = arguments.arrTaxCodes[i].ProdTotal;		
											
				//if this is a tax for all users, calculate the tax amount
				if (qryTaxCode.TaxAll AND arguments.TaxExempt IS 0) {
					//if cumulative add previous amounts
					if (qryTaxCode.Cumulative) {
						v.Amounttotax = v.Amounttotax + strTaxTotals.AllTax; }
					//if taxing shipping, add to amount to tax
					if (qryTaxCode.TaxShipping) {
						v.Amounttotax = v.Amounttotax + arguments.ShipAmount; }
						
					v.TaxResult = Round(v.Amounttotax*qryTaxCode.TaxRate*100)/100;
					//add to totals 
					arrTaxAmounts[i].TotalTax = v.TaxResult;
					strTaxTotals.AllTax = strTaxTotals.AllTax + v.TaxResult;
				}
				
				//tax based on location, only run if user is not exempt
				else if (arguments.TaxExempt IS 0) {	
				
					//set address to use
					if (qryTaxCode.TaxAddress IS "Billing") {
						v.CustAddress = arguments.strCustAddress.Billing;
						arrTaxAmounts[i].AddressUsed = "Billing";
						}
					else {
						v.CustAddress = arguments.strCustAddress.Shipping;
						arrTaxAmounts[i].AddressUsed = "Shipping";
						}			
											
					// calculate the tax amounts for this code
					v.strTaxAmounts = doTaxCalc(qryTaxCode, v.CustAddress, v.Amounttotax, arguments.ShipAmount, strTaxTotals);

					//add to totals
					strTaxTotals.StateTax = strTaxTotals.StateTax + v.strTaxAmounts.StateTax;
					strTaxTotals.LocalTax = strTaxTotals.LocalTax + v.strTaxAmounts.LocalTax;
					strTaxTotals.CountyTax = strTaxTotals.CountyTax + v.strTaxAmounts.CountyTax;
					strTaxTotals.CountryTax = strTaxTotals.CountryTax + v.strTaxAmounts.CountryTax;
					
					v.TotalTaxes = v.strTaxAmounts.StateTax + v.strTaxAmounts.LocalTax + v.strTaxAmounts.CountyTax + v.strTaxAmounts.CountryTax;
					arrTaxAmounts[i].Taxes = v.strTaxAmounts;
					arrTaxAmounts[i].TotalTax = v.TotalTaxes;
					}
				
				}
				
			// no products for this tax;
			else {
				arrTaxAmounts[i].TotalTax = 0;
				}
			
			}
			
	</cfscript>


	<cfreturn arrTaxAmounts>
	
</cffunction>


<cffunction name="doTaxCalc" displayname="Do Single Tax Code Calculation" hint="This takes the customer address and tax information to determine the taxes for this particular tax code at the state, local, county and country levels." returntype="struct" output="No" access="public">

	<cfargument name="qryTaxCode" type="query" required="Yes" hint="Recordset with the tax code info.">
	<cfargument name="CustAddress" type="struct" required="Yes" hint="Structure with the customer address information.">
	<cfargument name="AmounttoTax" type="numeric" required="Yes" hint="The product totals used for figuring the tax.">
	<cfargument name="ShipAmount" type="numeric" required="Yes" hint="The shipping amount, if added before tax figured.">
	<cfargument name="strTaxTotals" type="struct" required="Yes" hint="Structure containing the current running tax amounts">

	<cfscript>
		//get the various tax rate queries
		var qryStateTaxes = getStateTaxes();
		var qryLocalTaxes = getLocalTaxes();
		var qryCountyTaxes = getCountyTaxes();
		var qryCountryTaxes = getCountryTaxes();
		
		var StateTaxRates = '';
		var CountyTaxRates = '';
		var LocalTaxRates = '';
		var CountryTaxRates = '';
		
		var codeid  = arguments.qryTaxCode.Code_ID;
		var SQLString = '';
		var SQLString2 = '';
		
		//structure for results
		var strTaxAmounts = StructNew();
		
		// other local vars
		var v = StructNew();
	</cfscript>
	
	<cfquery name="StateTaxRates" dbtype="query">
		SELECT * FROM qryStateTaxes
		WHERE Code_ID = #codeid#
		AND State = '#arguments.CustAddress.State#'
	</cfquery>
	
	<cfquery name="CountyTaxRates" dbtype="query">
		SELECT * FROM qryCountyTaxes
		WHERE Code_ID = #codeid#
		AND Name = '#arguments.CustAddress.County#'
		AND State = '#arguments.CustAddress.State#'
	</cfquery>
	
	<cfquery name="LocalTaxRates" dbtype="query">
		SELECT * FROM qryLocalTaxes
		WHERE Code_ID = #codeid#
		AND ZipCode = '#arguments.CustAddress.Zip#' 
		OR (ZipCode < '#arguments.CustAddress.Zip#' AND EndZip >= '#arguments.CustAddress.Zip#')
	</cfquery>
	
	<cfquery name="CountryTaxRates" dbtype="query">
		SELECT * FROM qryCountryTaxes
		WHERE Code_ID = #codeid#
		AND Abbrev = '#arguments.CustAddress.Country#'
	</cfquery>

	<cfscript>	
		//set starting tax amounts
		v.AmounttoTax = arguments.AmounttoTax;
				
		//Calculate the state taxes
		if (StateTaxRates.RecordCount) {			
			//add previous state tax amount if cumulative
			if (arguments.qryTaxCode.Cumulative)
				v.StateAmount = v.AmounttoTax + arguments.strTaxTotals.StateTax;
			else
				v.StateAmount = v.AmounttoTax;
			//add shipping amount if included
			if (StateTaxRates.TaxShip)
				v.StateAmount = v.StateAmount + arguments.ShipAmount;
			//calculate the tax
			v.TaxResult = Round(v.StateAmount*StateTaxRates.TaxRate*100)/100;
			strTaxAmounts.StateTax = v.TaxResult;
		}
		else
			strTaxAmounts.StateTax = 0;
			
		//Calculate the county taxes
		if (CountyTaxRates.RecordCount) {			
			//add previous county tax amount if cumulative
			if (arguments.qryTaxCode.Cumulative)
				v.CountyAmount = v.AmounttoTax + arguments.strTaxTotals.CountyTax;
			else
				v.CountyAmount = v.AmounttoTax;
			//add shipping amount if included
			if (CountyTaxRates.TaxShip)
				v.CountyAmount = v.CountyAmount + arguments.ShipAmount;
			//calculate the tax
			v.TaxResult = Round(v.CountyAmount*CountyTaxRates.TaxRate*100)/100;
			strTaxAmounts.CountyTax = v.TaxResult;
		}
		else
			strTaxAmounts.CountyTax = 0;
			
		//Calculate the local taxes
		if (LocalTaxRates.RecordCount) {			
			//add previous local tax amount if cumulative
			if (arguments.qryTaxCode.Cumulative)
				v.LocalAmount = v.AmounttoTax + arguments.strTaxTotals.LocalTax;
			else
				v.LocalAmount = v.AmounttoTax;
			//add shipping amount if included
			if (LocalTaxRates.TaxShip)
				v.LocalAmount = v.LocalAmount + arguments.ShipAmount;
			//calculate the tax
			v.TaxResult = Round(v.LocalAmount*LocalTaxRates.Tax*100)/100;
			strTaxAmounts.LocalTax = v.TaxResult;
		}
		else
			strTaxAmounts.LocalTax = 0;
		
		//Calculate the country taxes
		if (CountryTaxRates.RecordCount) {			
			//add previous country tax amount if cumulative
			if (arguments.qryTaxCode.Cumulative)
				v.CountryAmount = v.AmounttoTax + arguments.strTaxTotals.CountryTax;
			else
				v.CountryAmount = v.AmounttoTax;
			//add shipping amount if included
			if (CountryTaxRates.TaxShip)
				v.CountryAmount = v.CountryAmount + arguments.ShipAmount;
			//calculate the tax
			v.TaxResult = Round(v.CountryAmount*CountryTaxRates.TaxRate*100)/100;
			strTaxAmounts.CountryTax = v.TaxResult;
		}
		else
			strTaxAmounts.CountryTax = 0;
	
	</cfscript>
	
	<cfreturn strTaxAmounts>


</cffunction>

<cffunction name="saveOrderTaxes" displayname="Save Order Taxes" hint="Takes the order taxes from the session and saves them into the database" output="No" access="public" returntype="void">
	
	<cfargument name="arrTaxes" type="array" required="Yes" hint="Array containing the taxes for the order.">
	<cfargument name="OrderID" type="numeric" required="Yes" hint="The ID number for the order.">
	
	<cfscript>
	// counter
	var i = 0;
	//current structure
	var strTaxes = '';
	// query
	var insTaxes = '';
	</cfscript>
	
	<cfloop index="i" from="1" to="#ArrayLen(arguments.arrTaxes)#">
		<cfset strTaxes = arguments.arrTaxes[i]>
		<!--- make sure this tax code had products applied --->
		<cfif strTaxes.ProdTotal IS NOT 0 AND isDefined("strTaxes.TotalTax")>
			<cfquery name="insTaxes" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">			
			INSERT INTO #Request.DB_Prefix#OrderTaxes
			(Order_No, Code_ID, ProductTotal, CodeName, AddressUsed, 
			AllUserTax, StateTax, CountyTax, LocalTax, CountryTax)
			VALUES
			(<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.OrderID#">, 
			<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#strTaxes.Code_ID#">, 
			<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#strTaxes.ProdTotal#">, 
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#strTaxes.CodeName#">,
			<cfif isDefined("strTaxes.Taxes")>
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#strTaxes.AddressUsed#">, 0,
				<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#strTaxes.Taxes.StateTax#">, 
				<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#strTaxes.Taxes.CountyTax#">, 
				<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#strTaxes.Taxes.LocalTax#">, 
				<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#strTaxes.Taxes.CountryTax#"> )
			<cfelse>
				<!--- tax applied to all users --->
				NULL, 
				<cfqueryparam cfsqltype="CF_SQL_DOUBLE" value="#strTaxes.TotalTax#">, 
				0, 0, 0, 0 )
			</cfif>
			</cfquery>
		
		</cfif>
	
	</cfloop>

</cffunction>


<!--------------- CUSTOMER ADDRESSES -------------------->
<cffunction name="doCustomerAddress" displayname="Do Customer Address" hint="This takes the temporary queries with the customer address information and returns the billing and shipping addresses to use for other functions." output="No" returntype="struct" access="public">

	<cfargument type="query" name="BillingInfo" hint="Query containing the customer billing information">
	<cfargument type="query" name="ShippingInfo" hint="Query containing the customer shipping information">
	
	<cfscript>
		//structure to hold all local vars
		var v = StructNew();
		
		v.CustAddress = StructNew();
		v.CustAddress.Billing = StructNew();
		v.CustAddress.Shipping = StructNew();
		
		// Enter billing address info
			v.CustAddress.Billing.Country = ListGetAt(arguments.BillingInfo.Country, 1, "^");
			if (arguments.BillingInfo.State IS "Unlisted") 
				v.CustAddress.Billing.State = arguments.BillingInfo.State2;
			else
				v.CustAddress.Billing.State = arguments.BillingInfo.State;
			v.CustAddress.Billing.Name = arguments.BillingInfo.FirstName & " " & arguments.BillingInfo.LastName;
			v.CustAddress.Billing.Address = arguments.BillingInfo.Address1;
			v.CustAddress.Billing.Address2 = arguments.BillingInfo.Address2;
			v.CustAddress.Billing.City = arguments.BillingInfo.City;
			v.CustAddress.Billing.County = arguments.BillingInfo.County;
			v.CustAddress.Billing.Residence = arguments.BillingInfo.Residence;		
			// Convert the postal code to Upper case and drop spaces or 4-digit portion
			v.zip = UCase(ListGetAt(arguments.BillingInfo.zip,1,"-"));	
			v.CustAddress.Billing.Zip = Replace(v.zip," ","","ALL");
			
		// Check if there is a ShipTo Address
		if (arguments.ShippingInfo.RecordCount IS NOT 0) {
			v.CustAddress.Shipping.Country = ListGetAt(arguments.ShippingInfo.Country, 1, "^");
			if (arguments.ShippingInfo.State IS "Unlisted")
				v.CustAddress.Shipping.State = arguments.ShippingInfo.State2;
			else 
				v.CustAddress.Shipping.State = arguments.ShippingInfo.State;
			v.CustAddress.Shipping.Name = arguments.ShippingInfo.FirstName & " " & arguments.ShippingInfo.LastName;
			v.CustAddress.Shipping.Address = arguments.ShippingInfo.Address1;
			v.CustAddress.Shipping.Address2 = arguments.ShippingInfo.Address2;
			v.CustAddress.Shipping.City = arguments.ShippingInfo.City;
			v.CustAddress.Shipping.County = arguments.ShippingInfo.County;
			v.CustAddress.Shipping.Residence = arguments.ShippingInfo.Residence;
			// Convert the postal code to Upper case and drop spaces or 4-digit portion
			v.zip = UCase(ListGetAt(arguments.ShippingInfo.zip,1,"-"));	
			v.CustAddress.Shipping.Zip = Replace(v.zip," ","","ALL");
			}
		else {
			v.CustAddress.Shipping.Country = v.CustAddress.Billing.Country;
			v.CustAddress.Shipping.Name = v.CustAddress.Billing.Name;
			v.CustAddress.Shipping.Address = v.CustAddress.Billing.Address;
			v.CustAddress.Shipping.Address2 = v.CustAddress.Billing.Address2;
			v.CustAddress.Shipping.State = v.CustAddress.Billing.State;
			v.CustAddress.Shipping.City = v.CustAddress.Billing.City;
			v.CustAddress.Shipping.County = v.CustAddress.Billing.County;
			v.CustAddress.Shipping.Residence = v.CustAddress.Billing.Residence;
			v.CustAddress.Shipping.Zip = v.CustAddress.Billing.Zip;
			}
	</cfscript>
	
	<cfreturn v.CustAddress>

</cffunction>


<!------------------------- SHIPPING ADDRESS FUNCTION ----------------------------------->

<cffunction name="doAddresses" returntype="struct" hint="Takes the customer information and returns a struct with the shipping information. Used mainly for shipping calculations." output="No" access="public">

	<cfargument type="query" name="BillingInfo" hint="Query containing the customer billing information">
	<cfargument type="query" name="ShippingInfo" hint="Query containing the customer shipping information">
	
	<cfscript>
		var AddressInfo = StructNew();
		var CustAddress = doCustomerAddress(arguments.BillingInfo,arguments.ShippingInfo);
		
		//process the customer information			
		AddressInfo.Country = CustAddress.Shipping.Country;
		AddressInfo.State = CustAddress.Shipping.State;
		AddressInfo.City = CustAddress.Shipping.City;
		AddressInfo.Zip = CustAddress.Shipping.Zip;
		AddressInfo.Residence = CustAddress.Shipping.Residence;
		
	</cfscript>
	<!--- <cfdump var="#AddressInfo#"> --->
	
	<cfreturn AddressInfo>

</cffunction>


<cffunction name="doShipFrom" returntype="struct" hint="Takes the shipper's information and returns a struct with parsed information. Used mainly for shipping calculations." output="No" access="public">

<cfargument type="struct" name="MerchantInfo" hint="A structure with the merchant shipping origin information">

<cfscript>
	var ShipFrom = StructCopy(arguments.MerchantInfo);
	
	//process the merchant information
	ShipFrom.Zip = Replace(arguments.MerchantInfo.Zip," ","","ALL");
	ShipFrom.Country = ListGetAt(arguments.MerchantInfo.Country, 1, "^");
			
	// Check if extended zips, if so, just get first part
	if (ListLen(ShipFrom.Zip, "-") IS 2)
		ShipFrom.Zip = ListGetAt(ShipFrom.Zip, 1, "-");
		
</cfscript>

<cfreturn ShipFrom>

</cffunction>


<cffunction name="getStateTaxes" displayname="Get State Taxes" hint="Gets the full list of state tax rates used for the store" output="No" access="public" returntype="query">
	
	<cfargument name="reset" required="No" default="no" hint="Set whether to refresh this cached query.">

	<cfscript>
		var qryStateTaxes = ''; 
		
		if (arguments.reset)
			Request.Cache = CreateTimeSpan(0, 0, 0, 0);
	</cfscript>

	<cfquery name="qryStateTaxes" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" cachedwithin="#Request.Cache#">
		SELECT * FROM #Request.DB_Prefix#StateTax
		ORDER BY Code_ID
	</cfquery>
	
	<cfreturn qryStateTaxes>

</cffunction>


<cffunction name="getLocalTaxes" displayname="Get Local Taxes" hint="Gets the full list of local tax rates used for the store" output="No" access="public" returntype="query">
	
	<cfargument name="reset" required="No" default="no" hint="Set whether to refresh this cached query.">

	<cfscript>
		var qryLocalTaxes = ''; 
		
		if (arguments.reset)
			Request.Cache = CreateTimeSpan(0, 0, 0, 0);
	</cfscript>

	<cfquery name="qryLocalTaxes" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" cachedwithin="#Request.Cache#">
		SELECT * FROM #Request.DB_Prefix#LocalTax
		ORDER BY Code_ID
	</cfquery>
	
	<cfreturn qryLocalTaxes>

</cffunction>
<cffunction name="getCountyTaxes" displayname="Get County Taxes" hint="Gets the full list of county tax rates used for the store" output="No" access="public" returntype="query">
	
	<cfargument name="reset" required="No" default="no" hint="Set whether to refresh this cached query.">

	<cfscript>
		var qryCountyTaxes = ''; 
		
		if (arguments.reset)
			Request.Cache = CreateTimeSpan(0, 0, 0, 0);
	</cfscript>

	<cfquery name="qryCountyTaxes" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" cachedwithin="#Request.Cache#">
		SELECT * FROM #Request.DB_Prefix#Counties
		ORDER BY Code_ID
	</cfquery>
	
	<cfreturn qryCountyTaxes>

</cffunction>


<cffunction name="getCountryTaxes" displayname="Get Country Taxes" hint="Gets the full list of country tax rates used for the store" output="No" access="public" returntype="query">
	
	<cfargument name="reset" required="No" default="no" hint="Set whether to refresh this cached query.">

	<cfscript>
		var qryCountryTaxes = ''; 
		
		if (arguments.reset)
			Request.Cache = CreateTimeSpan(0, 0, 0, 0);
	</cfscript>

	<cfquery name="qryCountryTaxes" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#" cachedwithin="#Request.Cache#">
		SELECT T.*, C.Abbrev FROM #Request.DB_Prefix#CountryTax T
		INNER JOIN #Request.DB_Prefix#Countries C ON T.Country_ID = C.ID
		ORDER BY Code_ID
	</cfquery>
	
	<cfreturn qryCountryTaxes>

</cffunction>


<!------------------------- CLEAR TEMPORARY ORDER TABLES ----------------------------------->
<cffunction name="clearTempTables" displayname="Clear Temp Tables" hint="Clears the temporary shopping cart and checkout database tables for the current user." output="No" returntype="void" access="public">

	<!--- Clear Shopping Cart --->
	<cfquery name="ClearBasket" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	DELETE FROM #Request.DB_Prefix#TempBasket 
	WHERE BasketNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
	</cfquery>
	
	<cfquery name="ClearOrder" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	DELETE FROM #Request.DB_Prefix#TempOrder 
	WHERE BasketNum = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
	</cfquery>
	
	<cfquery name="ClearCustomer" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	DELETE FROM #Request.DB_Prefix#TempCustomer
	WHERE TempCust_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
	</cfquery>
	
	<cfquery name="ClearShip" datasource="#Request.DS#" username="#Request.user#" password="#Request.pass#">
	DELETE FROM #Request.DB_Prefix#TempShipTo 
	WHERE TempShip_ID = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Session.BasketNum#">
	</cfquery>

</cffunction>

</cfcomponent>