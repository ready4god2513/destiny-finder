<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Used to output the price for a product --->

<!--- Sets whether to show all price information, or just the base price for this user --->
<cfparam name="AllPrices" default="Yes">
<cfset UserPrice = 0>
<cfset Savings = 0>

<!--- Starting value for the price string to output to the page --->
<cfset PriceString = '<span class="prodprice"><br/>'>

<!--- Put prices into a structure --->
<cfscript>
	ProdPrices = StructNew();
	ProdPrices.RetailPrice = qry_get_products.Retail_Price;
	ProdPrices.BasePrice = qry_get_products.base_Price;
	ProdPrices.WholesalePrice = qry_get_products.Wholesale;
	
	// Check for group price
	if (GetGroupPrice.RecordCount) {
		ProdPrices.GroupPrice = GetGroupPrice.Price; }
	else {
		ProdPrices.GroupPrice = 0; }
</cfscript>

<!--- Check for a product tax and set prices with tax if found --->
<cfset PricesWithTax = Application.objCart.calcProdTax(ProdPrices, qry_get_products.TaxCodes)>

<!--- Wholesale or group prices --->
<cfif ProdPrices.GroupPrice OR (Session.Wholesaler AND ProdPrices.WholesalePrice)>

	<cfif Request.AppSettings.ShowRetail AND ProdPrices.RetailPrice IS NOT 0>
		<cfset PriceString = PriceString & '<strong>Suggested Retail: </strong>'>
		<cfif NOT StructIsEmpty(PricesWithTax)>
			<cfset PriceString = PriceString & '#LSCurrencyFormat(PricesWithTax.RetailPrice)# (incl. #PricesWithTax.TaxName#)'>
		<cfelse>
			<cfset PriceString = PriceString & LSCurrencyFormat(ProdPrices.RetailPrice)>
		</cfif>
		<cfset PriceString = PriceString & '<br/>'>
	</cfif>
	
	<cfif ProdPrices.BasePrice IS NOT 0>
		<cfset PriceString = PriceString & "Regular Price: ">
		<cfif NOT StructIsEmpty(PricesWithTax)>
			<cfset PriceString = PriceString & '#LSCurrencyFormat(PricesWithTax.BasePrice)# (incl. #PricesWithTax.TaxName#)'>
		<cfelse>
			<cfset PriceString = PriceString & LSCurrencyFormat(ProdPrices.BasePrice)>
		</cfif>
		<cfset PriceString = PriceString & '<br/>'>		
	</cfif>

	<cfset PriceString = PriceString & '<span class="prodprice2"><b>Your Price: </b></span> '>
	<!--- Group Price Applies --->	
	<cfif ProdPrices.GroupPrice>
		<cfset custPrice = ProdPrices.GroupPrice>
		<cfif NOT StructIsEmpty(PricesWithTax)>
			<cfset PriceString = PriceString & '#LSCurrencyFormat(PricesWithTax.GroupPrice)# (incl. #PricesWithTax.TaxName#)<br/>'>
			<cfset PriceString = PriceString & '<span class="prodprice2">Price excl. #PricesWithTax.TaxName#: </span>'>
			<cfset PriceString = PriceString & LSCurrencyFormat(ProdPrices.GroupPrice)>
			<cfset Savings = PricesWithTax.RetailPrice - PricesWithTax.GroupPrice>
			<cfset UserPrice = PricesWithTax.GroupPrice>
		<cfelse>
			<cfset PriceString = PriceString & LSCurrencyFormat(ProdPrices.GroupPrice)>
			<cfset Savings = ProdPrices.RetailPrice - ProdPrices.GroupPrice>
			<cfset UserPrice = ProdPrices.GroupPrice>
		</cfif>	
		
	<!--- Wholesale price applies --->
	<cfelse>
		<cfset custPrice = ProdPrices.WholesalePrice>
		<cfif NOT StructIsEmpty(PricesWithTax)>
			<cfset PriceString = PriceString & '#LSCurrencyFormat(PricesWithTax.WholesalePrice)# (incl. #PricesWithTax.TaxName#)<br/>'>
			<cfset PriceString = PriceString & '<span class="prodprice2">Price excl. #PricesWithTax.TaxName#: </span>'>
			<cfset PriceString = PriceString & LSCurrencyFormat(ProdPrices.WholesalePrice)>
			<cfset Savings = PricesWithTax.RetailPrice - PricesWithTax.WholesalePrice>
			<cfset UserPrice = PricesWithTax.WholesalePrice>
		<cfelse>
			<cfset PriceString = PriceString & LSCurrencyFormat(ProdPrices.WholesalePrice)>
			<cfset Savings = ProdPrices.RetailPrice - ProdPrices.WholesalePrice>
			<cfset UserPrice = ProdPrices.WholesalePrice>
		</cfif>	
	</cfif>

<!--- Output normal user price --->
<cfelse>

	<cfif Request.AppSettings.ShowRetail AND ProdPrices.RetailPrice IS NOT 0>
		<cfset PriceString = PriceString & '<strong>Retail Price: </strong>'>
		<cfif NOT StructIsEmpty(PricesWithTax)>
			<cfset PriceString = PriceString & '<strike>#LSCurrencyFormat(PricesWithTax.RetailPrice)#</strike> (incl. #PricesWithTax.TaxName#)'>
		<cfelse>
			<cfset PriceString = PriceString & '<strike>#LSCurrencyFormat(ProdPrices.RetailPrice)#</strike>'>
		</cfif>
		<cfset PriceString = PriceString & '<br/><span class="prodprice2">Our </span>'>
	</cfif>
	
	<cfset custPrice = ProdPrices.BasePrice>
		<cfset PriceString = PriceString & '<span class="prodprice2">Price: </span>'>
	<cfif NOT StructIsEmpty(PricesWithTax)>
		<cfset PriceString = PriceString & '#LSCurrencyFormat(PricesWithTax.BasePrice)# (incl. #PricesWithTax.TaxName#)<br/>'>
		<cfset PriceString = PriceString & '<span class="prodprice2">Price excl. #PricesWithTax.TaxName#: </span>#LSCurrencyFormat(ProdPrices.BasePrice)#'>
		<cfset Savings = PricesWithTax.RetailPrice - PricesWithTax.BasePrice>					
		<cfset UserPrice = PricesWithTax.BasePrice>
	<cfelse>
		<cfset PriceString = PriceString & LSCurrencyFormat(ProdPrices.BasePrice)>
		<cfset Savings = ProdPrices.RetailPrice - ProdPrices.BasePrice>
		<cfset UserPrice = ProdPrices.BasePrice>
	</cfif>	

</cfif>

<!--- Check for a currency exchange rate --->
<cfif Request.AppSettings.CurrExchange IS NOT "None">
	<!--- Exchange Rates: --->
	<cftry>
		<cfmodule template="../../customtags/CurrencyExchange.cfm"
			country="#Request.AppSettings.CurrExchange#"
			price="#custPrice#"
			Refresh="#YesNoFormat(isDefined("attributes.refresh"))#"
			>
			<cfset PriceString = PriceString & '&nbsp;&nbsp;&nbsp;'>
			<cfif len(Request.AppSettings.CurrExLabel)>
				<cfset PriceString = PriceString & '<span class="prodprice2">#Request.AppSettings.CurrExLabel#:</span> '>
			</cfif>
			<cfset PriceString = PriceString & '#Evaluate(Request.AppSettings.CurrExchange & '_Price')#'>
		<cfcatch type="service_timeout">
			<cfset PriceString = PriceString & '<em>#cfcatch.message#</em>'>
		</cfcatch>
	</cftry>
</cfif>

<cfset PriceString = PriceString & '</span><br/>'>

<cfif Request.AppSettings.ShowRetail AND Savings GT 0>
<cfset PriceString = PriceString & '<span class="prodsavings">You Save #LSCurrencyFormat(Savings)#!</span><br/>'>
</cfif>

<cfif AllPrices>
	<cfoutput>#PriceString#</cfoutput>
<cfelseif UserPrice IS NOT 0>
	<cfoutput>#LSCurrencyFormat(UserPrice)#</cfoutput>
</cfif>

<!--- Optional output of discounted product price --->
<!--- <cfset DiscAmount = Application.objDiscounts.calcProdDiscount(product_id,custPrice)>
<cfif DiscAmount>
<cfoutput><span class="proddiscounted">Discount Price:</span> #LSCurrencyFormat(custPrice-DiscAmount)#</span><br/></cfoutput>
</cfif> --->



