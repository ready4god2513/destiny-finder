
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Clears the shopping cart information and returns the customer to the store. Called by shopping.clear --->

<cfparam name="attributes.clear" default="No">

<cfif trim(attributes.Clear) is "Yes" >
	
	<cfscript>
		Application.objCheckout.clearTempTables();
		//Reset basket totals
		qryBasket = Application.objCart.getBasket();
		Application.objCart.doBasketTotals(qryBasket);	
	</cfscript>

	<cflocation url="#Request.StoreURL##Session.Page#" addtoken="No">
	
</cfif>



