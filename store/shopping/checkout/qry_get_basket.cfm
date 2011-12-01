
<!--- CFWebstore®, version 6.43 --->

<!--- CFWebstore® is ©Copyright 1998-2009 by Dogpatch Software, All Rights Reserved. This code may not be copied or sold without permission of the original author. Dogpatch Software may be contacted at info@cfwebstore.com --->

<!--- Retrieves the shopping cart data from the temporary table. Called by do_checkout.cfm --->

<!--- Check for Paypal IPN transactions --->
<!--- <cfif IsDefined("attributes.txn_id") AND IsDefined("attributes.custom") AND ListLen(attributes.custom, "^") GT 1>
	<cfset Session.BasketNum=ListGetAt(attributes.custom, 1, "^")>
	<cfset Session.User_ID=ListGetAt(attributes.custom, 2, "^")>
</cfif> --->

<cfset qry_Get_Basket = Application.objCart.getBasket()>




