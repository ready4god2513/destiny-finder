<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Clears all the temporary data and session vars used during checkout. Called by shopping.checkout (step=receipt) --->


<!--- Clean up temporary tables if checking out--->
<cfif attributes.fuseaction IS "shopping.checkout">
	<cfset Application.objCheckout.clearTempTables()>
</cfif>

<!--- Delete checkout session variable check --->
<cflock scope="SESSION" timeout="20">
	
	<cfif isDefined("Session.CheckingOut")>
		<cfset StructDelete(Session, "CheckingOut")>
	</cfif>
	
	<cfif isDefined("Session.AgreeTerms")>
		<cfset StructDelete(Session, "AgreeTerms")>
	</cfif>

	<!--- Delete any shipping rates in the session --->
	<cfif isDefined("Session.ShippingRates")>
		<cfset StructDelete(Session, "ShippingRates")>
	</cfif>

	<cfif isDefined("Session.CheckoutVars")>
		<cfset StructDelete(Session, "CheckoutVars")>
	</cfif>
</cflock>

<!--- Reset shopping cart totals --->
<cfset qry_Get_Basket = Application.objCart.getBasket()>
<cfset Application.objCart.doBasketTotals(qry_Get_Basket)>

